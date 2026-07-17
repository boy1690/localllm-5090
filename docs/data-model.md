# Data model / 資料模型

## English

Every JSON document has a `schema_version`, `content_languages`, and stable repository-local IDs.

### Reference entities

- `systems.json.systems[].id`: de-identified hardware and runtime baseline.
- `models.json.models[].id`: model, quantization, and test status. Different quantizations of the same model use different IDs.
- `benchmark-suites.json.suites[].id`: a comparable lane. Create a new suite ID when the prompt, runtime, metric, or gate changes.
- `results.json.results[].id`: one model observation under one suite and context. Foreign keys are `system_id`, `model_id`, and `suite_id`.
- `topologies.json.topologies[].id`: a multi-model composition. Every `model_ids` entry must exist in the model catalog.
- `decisions.json.routes[]`: current usage guidance. It is not a permanent statement of model capability and therefore carries an `as_of` date.

### Localization contract

English is canonical in a base natural-language field such as `summary`, `purpose`, `finding`, `rule`, or `notes`. Traditional Chinese is stored in the adjacent `summary_zh_tw`, `purpose_zh_tw`, `finding_zh_tw`, `rule_zh_tw`, or `notes_zh_tw` field. Parallel arrays use the same suffix, for example `limitations` and `limitations_zh_tw`. Proper nouns, IDs, enum codes, dates, hashes, filenames, and measurements are not duplicated.

### Missing values and comparison

Use JSON `null` for unknown or unexecuted values and explain with `status` or `notes`; never substitute zero for missing data. Direct comparison requires the same suite, system/runtime, model asset, context, output budget, reasoning/chat template, and gate. Present different lanes side by side; do not average them.

### Community submissions

Community PRs do not edit reference arrays. They add one complete, immutable record at `submissions/<submitter>/<run-id>/submission.json`. The validator checks naming, bilingual natural-language fields, required fields, reference suite, prohibited artifacts, and public-safety shapes.

## 繁體中文

每份 JSON 都有 `schema_version`、`content_languages` 與穩定的 repo-local ID。

### Reference entities

- `systems.json.systems[].id`：去識別硬體與 runtime 基線。
- `models.json.models[].id`：模型、量化與測試狀態；相同模型的不同量化使用不同 ID。
- `benchmark-suites.json.suites[].id`：可比較 lane。Prompt、runtime、metric 或 gate 改變時建立新 suite ID。
- `results.json.results[].id`：單一模型在一個 suite/context 下的 observation；外鍵為 `system_id`、`model_id` 與 `suite_id`。
- `topologies.json.topologies[].id`：多模型組合；每個 `model_ids` 項目都必須存在於 model catalog。
- `decisions.json.routes[]`：目前使用建議。它不是模型能力的永久真相，因此帶有 `as_of` 日期。

### 雙語契約

英文是自然語言基本欄位的 canonical 內容，例如 `summary`、`purpose`、`finding`、`rule` 或 `notes`；繁中放在相鄰的 `summary_zh_tw`、`purpose_zh_tw`、`finding_zh_tw`、`rule_zh_tw` 或 `notes_zh_tw`。平行陣列也使用相同 suffix，例如 `limitations` 與 `limitations_zh_tw`。專有名詞、ID、enum code、日期、雜湊、檔名及度量不重複儲存。

### 缺值與比較

未知或未執行使用 JSON `null`，並用 `status` 或 `notes` 說明；不得以 0 代替未測數據。只有 suite、system/runtime、model asset、context、output budget、reasoning/chat template 與 gate 均相同時才可直接比較。不同 lane 應並列，不可平均。

### 社群投稿

社群 PR 不編輯 reference arrays，而是在 `submissions/<submitter>/<run-id>/submission.json` 新增一個完整、不可變 record。Validator 會檢查命名、雙語自然語言欄位、必要欄位、reference suite、禁止產物與公開安全形狀。
