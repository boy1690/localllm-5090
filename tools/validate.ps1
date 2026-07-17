[CmdletBinding()]
param([string]$Root)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
} else {
    $Root = (Resolve-Path -LiteralPath $Root).Path
}

$failures = [System.Collections.Generic.List[string]]::new()
$schemaValidationCount = 0

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message)
    Write-Output "FAIL: $Message"
}

function Read-JsonFile {
    param([string]$RelativePath)
    $path = Join-Path $Root $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Add-Failure "missing required file: $RelativePath"
        return $null
    }
    try {
        return Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        Add-Failure "invalid JSON: $RelativePath — $($_.Exception.Message)"
        return $null
    }
}

function Test-UniqueIds {
    param([object[]]$Rows, [string]$Context)
    $ids = @($Rows | ForEach-Object { [string]$_.id })
    foreach ($emptyIndex in 0..([Math]::Max(0, $ids.Count - 1))) {
        if ($ids.Count -gt 0 -and [string]::IsNullOrWhiteSpace($ids[$emptyIndex])) {
            Add-Failure "$Context contains an empty id"
        }
    }
    $duplicates = @($ids | Group-Object | Where-Object Count -gt 1)
    foreach ($duplicate in $duplicates) {
        Add-Failure "$Context contains duplicate id: $($duplicate.Name)"
    }
    return $ids
}

function Test-SubmissionSchema {
    param([string]$JsonPath, [string]$Context)
    if (-not (Get-Command Test-Json -ErrorAction SilentlyContinue)) { return }
    try {
        $schemaPath = Join-Path $Root 'schemas/submission.schema.json'
        $valid = (Get-Content -LiteralPath $JsonPath -Raw -Encoding UTF8) | Test-Json -SchemaFile $schemaPath -ErrorAction Stop
        if (-not $valid) {
            Add-Failure "submission schema failed: $Context"
        } else {
            $script:schemaValidationCount++
        }
    } catch {
        Add-Failure "submission schema failed: $Context — $($_.Exception.Message)"
    }
}

Write-Output "ROOT=$Root"

$forbiddenExtensions = @('.7z', '.bin', '.ckpt', '.dll', '.dylib', '.exe', '.gguf', '.gz', '.onnx', '.pfx', '.pt', '.pth', '.safetensors', '.so', '.tar', '.zip')
$forbiddenDirectories = @('node_modules', 'target', '.venv', '__pycache__', 'out')
$files = @(Get-ChildItem -LiteralPath $Root -Recurse -File -Force | Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' })

foreach ($file in $files) {
    $relative = $file.FullName.Substring($Root.Length).TrimStart('\', '/').Replace('\', '/')
    if ($forbiddenExtensions -contains $file.Extension.ToLowerInvariant()) {
        Add-Failure "forbidden artifact: $relative"
    }
    if (($relative -split '/') | Where-Object { $forbiddenDirectories -contains $_ }) {
        Add-Failure "generated/dependency directory: $relative"
    }
    if ($file.Length -gt 2MB) {
        Add-Failure "file exceeds 2 MiB distilled-repo limit: $relative"
    }
}

$jsonCount = 0
foreach ($file in $files | Where-Object Extension -eq '.json') {
    try {
        $null = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
        $jsonCount++
    } catch {
        Add-Failure "invalid JSON: $($file.FullName.Substring($Root.Length).TrimStart('\', '/'))"
    }
}
Write-Output "JSON_PARSE_COUNT=$jsonCount"

$systemsDoc = Read-JsonFile 'data/systems.json'
$modelsDoc = Read-JsonFile 'data/models.json'
$suitesDoc = Read-JsonFile 'data/benchmark-suites.json'
$resultsDoc = Read-JsonFile 'data/results.json'
$topologiesDoc = Read-JsonFile 'data/topologies.json'
$decisionsDoc = Read-JsonFile 'data/decisions.json'
$provenanceDoc = Read-JsonFile 'data/provenance.json'
$sourceFilesDoc = Read-JsonFile 'data/source-files.json'

foreach ($docAndName in @(
    @($systemsDoc, 'systems'), @($modelsDoc, 'models'), @($suitesDoc, 'benchmark-suites'),
    @($resultsDoc, 'results'), @($topologiesDoc, 'topologies'), @($decisionsDoc, 'decisions'),
    @($provenanceDoc, 'provenance'), @($sourceFilesDoc, 'source-files')
)) {
    if ($null -ne $docAndName[0] -and $docAndName[0].schema_version -ne '1.0') {
        Add-Failure "unsupported schema_version: $($docAndName[1])"
    }
}

$systemIds = if ($systemsDoc) { @(Test-UniqueIds @($systemsDoc.systems) 'systems') } else { @() }
$modelIds = if ($modelsDoc) { @(Test-UniqueIds @($modelsDoc.models) 'models') } else { @() }
$suiteIds = if ($suitesDoc) { @(Test-UniqueIds @($suitesDoc.suites) 'benchmark suites') } else { @() }
$resultIds = if ($resultsDoc) { @(Test-UniqueIds @($resultsDoc.results) 'results') } else { @() }
$topologyIds = if ($topologiesDoc) { @(Test-UniqueIds @($topologiesDoc.topologies) 'topologies') } else { @() }

if ($resultsDoc) {
    foreach ($row in @($resultsDoc.results)) {
        if ($systemIds -notcontains [string]$row.system_id) { Add-Failure "result $($row.id) references unknown system_id" }
        if ($modelIds -notcontains [string]$row.model_id) { Add-Failure "result $($row.id) references unknown model_id" }
        if ($suiteIds -notcontains [string]$row.suite_id) { Add-Failure "result $($row.id) references unknown suite_id" }
        if ($null -eq $row.metrics -or $row.metrics.PSObject.Properties.Count -eq 0) { Add-Failure "result $($row.id) has no metrics" }
    }
}

if ($topologiesDoc) {
    foreach ($row in @($topologiesDoc.topologies)) {
        if ($suiteIds -notcontains [string]$row.suite_id) { Add-Failure "topology $($row.id) references unknown suite_id" }
        foreach ($modelId in @($row.model_ids)) {
            if ($modelIds -notcontains [string]$modelId) { Add-Failure "topology $($row.id) references unknown model_id $modelId" }
        }
    }
}

if ($decisionsDoc) {
    $null = Test-UniqueIds @($decisionsDoc.routes) 'decision routes'
    $null = Test-UniqueIds @($decisionsDoc.prohibitions) 'decision prohibitions'
    foreach ($row in @($decisionsDoc.routes) + @($decisionsDoc.prohibitions)) {
        foreach ($modelId in @($row.model_ids)) {
            if ($modelIds -notcontains [string]$modelId) { Add-Failure "decision $($row.id) references unknown model_id $modelId" }
        }
        if ($row.PSObject.Properties.Name -contains 'evidence_result_ids') {
            foreach ($resultId in @($row.evidence_result_ids)) {
                if ($resultIds -notcontains [string]$resultId) { Add-Failure "decision $($row.id) references unknown result_id $resultId" }
            }
        }
        if ($row.PSObject.Properties.Name -contains 'evidence_topology_ids') {
            foreach ($topologyId in @($row.evidence_topology_ids)) {
                if ($topologyIds -notcontains [string]$topologyId) { Add-Failure "decision $($row.id) references unknown topology_id $topologyId" }
            }
        }
    }
}

if ($sourceFilesDoc -and $provenanceDoc) {
    $sourceRows = @($sourceFilesDoc.files)
    if ($sourceRows.Count -ne [int]$provenanceDoc.source_file_count) {
        Add-Failure 'source manifest count does not match provenance'
    }
    $sourceBytes = ($sourceRows | Measure-Object bytes -Sum).Sum
    if ($sourceBytes -ne [int64]$provenanceDoc.source_bytes) {
        Add-Failure 'source manifest bytes do not match provenance'
    }
    $pathDuplicates = @($sourceRows | Group-Object path | Where-Object Count -gt 1)
    if ($pathDuplicates.Count -gt 0) { Add-Failure 'source manifest contains duplicate paths' }
    foreach ($row in $sourceRows) {
        if ([IO.Path]::IsPathRooted([string]$row.path) -or [string]$row.path -match '(^|/)\.\.(/|$)') {
            Add-Failure "unsafe source manifest path: $($row.path)"
        }
        if ([string]$row.sha256 -notmatch '^[a-f0-9]{64}$') {
            Add-Failure "invalid source SHA-256: $($row.path)"
        }
    }
    foreach ($expected in @($provenanceDoc.dispositions)) {
        $matching = @($sourceRows | Where-Object disposition -eq $expected.id)
        $matchingBytes = ($matching | Measure-Object bytes -Sum).Sum
        if ($matching.Count -ne [int]$expected.files -or $matchingBytes -ne [int64]$expected.bytes) {
            Add-Failure "source disposition mismatch: $($expected.id)"
        }
    }
    Write-Output "SOURCE_MANIFEST_COUNT=$($sourceRows.Count)"
}

$submissionRoot = Join-Path $Root 'submissions'
$submissionCount = 0
if (Test-Path -LiteralPath $submissionRoot -PathType Container) {
    foreach ($submitterDir in Get-ChildItem -LiteralPath $submissionRoot -Directory | Where-Object { -not $_.Name.StartsWith('_') }) {
        if ($submitterDir.Name -notmatch '^[a-z0-9][a-z0-9-]{1,63}$') { Add-Failure "invalid submitter directory: $($submitterDir.Name)" }
        foreach ($runDir in Get-ChildItem -LiteralPath $submitterDir.FullName -Directory) {
            $submissionCount++
            if ($runDir.Name -notmatch '^[0-9]{4}-[0-9]{2}-[0-9]{2}--[a-z0-9][a-z0-9-]{1,63}$') { Add-Failure "invalid run directory: $($runDir.Name)" }
            $runFiles = @(Get-ChildItem -LiteralPath $runDir.FullName -Recurse -File)
            if ($runFiles.Count -ne 1 -or $runFiles[0].Name -ne 'submission.json') { Add-Failure "submission run must contain submission.json only: $($runDir.Name)"; continue }
            Test-SubmissionSchema $runFiles[0].FullName "$($submitterDir.Name)/$($runDir.Name)"
            $submission = Get-Content -LiteralPath $runFiles[0].FullName -Raw -Encoding UTF8 | ConvertFrom-Json
            if ($submission.submission_id -ne $runDir.Name) { Add-Failure "submission_id mismatch: $($runDir.Name)" }
            if ($submission.submitter_slug -ne $submitterDir.Name) { Add-Failure "submitter_slug mismatch: $($runDir.Name)" }
            if ($suiteIds -notcontains [string]$submission.suite_id) { Add-Failure "unknown submission suite_id: $($submission.suite_id)" }
            if ($submission.license_accepted -ne $true) { Add-Failure "license_accepted must be true: $($runDir.Name)" }
            if (@($submission.results).Count -eq 0) { Add-Failure "submission has no results: $($runDir.Name)" }
            if ($submission.model.file_sha256 -and [string]$submission.model.file_sha256 -notmatch '^[a-f0-9]{64}$') { Add-Failure "invalid submission SHA-256: $($runDir.Name)" }
        }
    }
}
Write-Output "COMMUNITY_SUBMISSION_COUNT=$submissionCount"

$templatePath = Join-Path $Root 'submissions/_template/submission.json'
if (Test-Path -LiteralPath $templatePath -PathType Leaf) {
    Test-SubmissionSchema $templatePath 'submissions/_template/submission.json'
}
if (Get-Command Test-Json -ErrorAction SilentlyContinue) {
    Write-Output "JSON_SCHEMA_VALIDATION_COUNT=$schemaValidationCount"
} else {
    Write-Output 'JSON_SCHEMA_VALIDATION_COUNT=SKIPPED (Test-Json unavailable; structural validation used)'
}

$tokens = $null
$parseErrors = $null
foreach ($scriptFile in $files | Where-Object Extension -eq '.ps1') {
    $null = [System.Management.Automation.Language.Parser]::ParseFile($scriptFile.FullName, [ref]$tokens, [ref]$parseErrors)
    if ($parseErrors.Count -gt 0) { Add-Failure "PowerShell parse failed: $($scriptFile.Name)" }
}

try {
    & (Join-Path $Root 'tools/scan-secrets.ps1') -Root $Root
} catch {
    Add-Failure 'secret-shape scan failed'
}

if ($failures.Count -gt 0) {
    Write-Output "RESULT=FAIL COUNT=$($failures.Count)"
    exit 1
}

Write-Output "RESULT=PASS FILES=$($files.Count) MODELS=$($modelIds.Count) RESULTS=$($resultIds.Count) TOPOLOGIES=$($topologyIds.Count)"
