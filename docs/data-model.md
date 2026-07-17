# Data model

所有 JSON 都有 `schema_version` 與穩定、repo-local ID。

## Reference entities

- `systems.json.systems[].id`：去識別硬體/runtime 基線。
- `models.json.models[].id`：模型、量化與測試狀態；相同模型的不同量化是不同 ID。
- `benchmark-suites.json.suites[].id`：可比較 lane。Prompt、runtime、metric 或 gate 變動時建立新 suite ID。
- `results.json.results[].id`：單一模型在一個 suite/context 下的 observation，外鍵為 `system_id`、`model_id`、`suite_id`。
- `topologies.json.topologies[].id`：多模型組合；`model_ids` 必須存在於 models catalog。
- `decisions.json.routes[]`：目前使用建議。它不是模型能力的永久真相，必須帶 `as_of`。

## Missing values

未知或未執行使用 JSON `null`，並用 `status`／`notes` 說明。不得以 0 代替未測數據。

## Comparison

只有 `suite_id`、system/runtime、model asset、context、output budget、reasoning/chat template 與 gate 相同時才可直接比較。不同 lane 應並列，不平均。

## Community submissions

社群 PR 不編輯 reference arrays，而是在 `submissions/<submitter>/<run-id>/submission.json` 新增一個完整、不可變 record。Validator 檢查命名、必要欄位、reference suite、禁止檔案與公開安全形狀。
