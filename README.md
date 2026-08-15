# localllm-5090

[English](#english) | [繁體中文](#繁體中文)

## English

A distilled local-LLM benchmark dataset measured on an RTX 5090 Laptop GPU with 24 GB of dedicated VRAM.

This repository publishes normalized results, not a mirror of a private research workspace. All 119 source files were classified and hashed, while duplicate long-form reports, raw prompts, wire payloads, compiler work directories, and project-specific runners were excluded from the public tree.

### At a glance

| Work | Reference route | Required gate |
|---|---|---|
| Strict JSON materialization | Qwen3.6 35B-A3B Q4_K_M, non-thinking 8K | JSON parse + schema |
| TypeScript and general implementation | Devstral Small 2 24B Q4_K_M | type-check + targeted tests |
| High-risk Rust and invariants | Qwen3.6 35B-A3B Q4_K_M, thinking 32K | Cargo diagnostics + adaptive repair loop |
| Bounded checker | Qwen3 4B | fixed fields only |
| Code-specific escalation | Qwen2.5-Coder 7B | no authority to freely rewrite the full patch |
| Required tool call | Agents-A1 4B | exact tool name, count, and arguments |

Devstral Q6_K loaded at both 8K and 16K, but it was about 26% slower than Q4. Its Rust Cargo gate reported 6 errors and 1 warning, and its compiler-repair response produced false verification. It therefore does not replace Q4.

### Repository layout

```text
data/
  systems.json              # de-identified reference system
  models.json               # model status and role boundaries
  benchmark-suites.json     # comparable lanes and objective gates
  results.json              # normalized model, capacity, and checker results
  topologies.json           # measured multi-model compositions
  decisions.json            # current routes and prohibitions
  provenance.json           # distillation policy and source statistics
  source-files.json         # SHA-256 and disposition for all 119 source files
docs/
  methodology.md
  findings.md
  data-model.md
  limitations.md
  localization.md
  local-coding-contract.md
schemas/
  submission.schema.json
submissions/
  _template/submission.json
tools/
  validate.ps1
  scan-secrets.ps1
```

### Using the data

Reference JSON uses stable IDs and foreign keys. English is stored in the base natural-language field and Traditional Chinese in the matching `*_zh_tw` field. Do not directly compare or average throughput from different `suite_id` values or runtime lanes.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

To add a result, copy `submissions/_template/` to `submissions/<submitter>/<YYYY-MM-DD--run-slug>/`. Add only your own immutable submission; do not edit shared reference arrays. See [CONTRIBUTING.md](CONTRIBUTING.md).

### License

- Documentation and data: CC BY 4.0.
- Software, schemas, CI, and tools: MIT.

See [LICENSE](LICENSE) for the exact scope. Model weights are not distributed by this repository, and third-party models and datasets remain subject to their original licenses.

---

## 繁體中文

這是在 RTX 5090 Laptop GPU（24 GB dedicated VRAM）上量測的本機 LLM 實測蒸餾資料集。

本 repo 發布正規化結果，不是私人研究工作區的鏡像。119 個來源檔已逐一分類與雜湊；重複長報告、raw prompts、wire payloads、編譯工作目錄及專案耦合 runner 均未放入公開 tree。

### 一頁結論

| 工作 | 參考路由 | 必要 gate |
|---|---|---|
| 嚴格 JSON 材料化 | Qwen3.6 35B-A3B Q4_K_M，non-thinking 8K | JSON parse + schema |
| TypeScript／一般施工 | Devstral Small 2 24B Q4_K_M | type-check + targeted tests |
| 高風險 Rust／不變量 | Qwen3.6 35B-A3B Q4_K_M，thinking 32K | Cargo diagnostics + adaptive repair loop |
| 有界 checker | Qwen3 4B | 只審固定欄位 |
| 程式碼專項升級 | Qwen2.5-Coder 7B | 不授權自由重寫整份 patch |
| 必要工具呼叫 | Agents-A1 4B | 精確 tool name、count 與 arguments |

Devstral Q6_K 能在 8K／16K 載入，但比 Q4 約慢 26%。其 Rust Cargo gate 為 6 errors／1 warning，compiler repair 又產生錯誤驗證，因此不取代 Q4。

### Repo 結構

```text
data/
  systems.json              # 去識別 reference system
  models.json               # 模型狀態與角色邊界
  benchmark-suites.json     # 可比較 lane 與客觀 gate
  results.json              # 正規化單模型、容量與 checker 結果
  topologies.json           # 多模型組合實測
  decisions.json            # 現行路由與禁止事項
  provenance.json           # 蒸餾政策與來源統計
  source-files.json         # 119 檔逐檔 SHA-256 與 disposition
docs/
  methodology.md
  findings.md
  data-model.md
  limitations.md
  localization.md
  local-coding-contract.md
schemas/
  submission.schema.json
submissions/
  _template/submission.json
tools/
  validate.ps1
  scan-secrets.ps1
```

### 使用資料

Reference JSON 使用穩定 ID 與外鍵。自然語言的英文放在基本欄位，繁中放在對應的 `*_zh_tw` 欄位。不同 `suite_id` 或 runtime lane 的吞吐量不可直接比較或平均。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

新增結果時，請將 `submissions/_template/` 複製到 `submissions/<submitter>/<YYYY-MM-DD--run-slug>/`。只新增自己的不可變 submission，不修改共享 reference arrays。詳見 [CONTRIBUTING.md](CONTRIBUTING.md)。

### 授權

- 文件與資料：CC BY 4.0。
- 程式、schema、CI 與工具：MIT。

精確範圍見 [LICENSE](LICENSE)。本 repo 不發布模型權重；第三方模型與資料仍受其原始授權約束。
