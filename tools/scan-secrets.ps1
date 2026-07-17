[CmdletBinding()]
param([string]$Root)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
} else {
    $Root = (Resolve-Path -LiteralPath $Root).Path
}

$scannerPath = $MyInvocation.MyCommand.Path
$patterns = [ordered]@{
    'windows-user-path' = '(?i)[A-Z]:\\Users\\(?!<USER>\\)[^\\\r\n]+'
    'absolute-windows-path' = '(?i)(?<![A-Z0-9_>])[A-Z]:\\'
    'email-address' = '(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b'
    'private-ipv4' = '\b(?:10\.(?:\d{1,3}\.){2}\d{1,3}|172\.(?:1[6-9]|2\d|3[01])\.(?:\d{1,3}\.)\d{1,3}|192\.168\.(?:\d{1,3}\.)\d{1,3})\b'
    'mac-address' = '(?i)\b(?:[0-9A-F]{2}[:-]){5}[0-9A-F]{2}\b'
    'guid' = '(?i)\b[0-9A-F]{8}-[0-9A-F]{4}-[1-5][0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}\b'
    'known-token-shape' = '(?i)\b(?:ghp_|github_pat_|sk-)[A-Z0-9_.-]{12,}\b'
    'bearer-credential' = '(?i)\bBearer\s+[A-Z0-9_.-]{16,}\b'
    'credential-assignment' = '(?i)\b(?:api[_-]?key|password|passphrase|secret|token)\s*[:=]\s*["'']?[A-Z0-9_+/=.-]{12,}'
    'bitlocker-recovery-key' = '\b\d{6}(?:-\d{6}){7}\b'
    'oobe-machine-name' = '(?i)\bWIN-[A-Z0-9]{7,}\b'
}

$localRulesPath = Join-Path $PSScriptRoot 'scan-secrets.local.ps1'
if (Test-Path -LiteralPath $localRulesPath -PathType Leaf) {
    . $localRulesPath
    if ($AdditionalSecretPatterns -is [System.Collections.IDictionary]) {
        foreach ($entry in $AdditionalSecretPatterns.GetEnumerator()) {
            $patterns[$entry.Key] = $entry.Value
        }
    }
}

$binaryExtensions = @('.7z', '.bin', '.ckpt', '.dll', '.dylib', '.exe', '.gguf', '.gz', '.jpg', '.jpeg', '.onnx', '.pfx', '.png', '.pt', '.pth', '.safetensors', '.so', '.tar', '.zip')
$findings = [System.Collections.Generic.List[object]]::new()
$files = Get-ChildItem -LiteralPath $Root -Recurse -File -Force | Where-Object {
    $_.FullName -ne $scannerPath -and
    $_.FullName -ne $localRulesPath -and
    $_.FullName -notmatch '[\\/]\.git[\\/]' -and
    $binaryExtensions -notcontains $_.Extension.ToLowerInvariant()
}

foreach ($file in $files) {
    $lines = Get-Content -LiteralPath $file.FullName -Encoding UTF8
    for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
        foreach ($entry in $patterns.GetEnumerator()) {
            if ($lines[$lineIndex] -match $entry.Value) {
                $findings.Add([pscustomobject]@{
                    Rule = $entry.Key
                    File = $file.FullName.Substring($Root.Length).TrimStart('\', '/')
                    Line = $lineIndex + 1
                })
            }
        }
    }
}

if ($findings.Count -gt 0) {
    $findings | Sort-Object File, Line, Rule | Format-Table -AutoSize
    Write-Output "RESULT=FINDINGS COUNT=$($findings.Count)"
    throw 'Secret-shape scan found content that requires manual review.'
}

Write-Output 'RESULT=CLEAN'
