# localllm-5090

RTX 5090 Laptop GPU（24GB dedicated VRAM）上的本機 LLM 實測蒸餾資料集。

這個 repo 發布的是正規化結果，不是私人研究工作區的鏡像：119 個來源檔已逐一分類與雜湊，但重複長報告、raw prompts、wire payloads、編譯工作目錄與專案耦合 runner 不進公開 tree。

## 一頁結論

| 工作 | Reference route | 必要 gate |
|---|---|---|
| Strict JSON materialization | Qwen3.6 35B-A3B Q4_K_M，non-thinking 8K | JSON parse + schema |
| TypeScript／一般施工 | Devstral Small 2 24B Q4_K_M | type-check + targeted tests |
| 高風險 Rust／不變量 | Qwen3.6 35B-A3B Q4_K_M，thinking 32K | Cargo diagnostics + adaptive repair loop |
| Bounded checker | Qwen3 4B | 只審固定欄位 |
| Code-specific escalation | Qwen2.5-Coder 7B | 不授權自由重寫整份 patch |
| Required tool call | Agents-A1 4B | exact tool name/count/arguments |

Devstral Q6_K 能在 8K／16K 載入，但比 Q4 約慢 26%，Rust Cargo gate 為 6 errors／1 warning，compiler repair 又產生 false verification，因此不取代 Q4。

## 目錄

```text
data/
  systems.json              # 去識別 reference system
  models.json               # 模型狀態與角色邊界
  benchmark-suites.json     # 可比較 lane 與客觀 gate
  results.json              # 正規化單模型／容量／checker 結果
  topologies.json           # 多模型組合實測
  decisions.json            # 現行路由與禁止事項
  provenance.json           # 蒸餾政策與來源統計
  source-files.json         # 119 檔逐檔 SHA-256/disposition
docs/
  methodology.md
  findings.md
  data-model.md
  limitations.md
schemas/
  submission.schema.json
submissions/
  _template/submission.json
tools/
  validate.ps1
  scan-secrets.ps1
```

## 使用資料

所有 reference JSON 都使用 `schema_version: "1.0"`、穩定 ID 與外鍵。不要直接比較不同 `suite_id` 或 runtime lane 的 tok/s。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

新增結果請複製 `submissions/_template/` 到 `submissions/<submitter>/<YYYY-MM-DD--run-slug>/`，只新增自己的 submission，不修改共享 reference arrays。詳見 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 授權

- 文件與資料：CC BY 4.0。
- 程式、schema、CI 與工具：MIT。

精確範圍見 [LICENSE](LICENSE)。模型權重不隨 repo 發布，第三方模型與資料仍受原授權約束。
