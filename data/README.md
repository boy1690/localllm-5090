# Reference data / 參考資料

## English

This directory contains a normalized snapshot distilled from 119 local source files.

Recommended reading order:

1. `systems.json`: comparison environment and runtime lanes.
2. `models.json`: model IDs, quantization, status, and authority boundaries.
3. `benchmark-suites.json`: methods and comparison boundaries.
4. `results.json`: single-model observations.
5. `topologies.json`: multi-model composition observations.
6. `decisions.json`: routes and prohibitions as of 2026-07-17.
7. `provenance.json` and `source-files.json`: distillation scope and per-file disposition for all 119 source files.

Natural-language base fields are English; matching `*_zh_tw` fields contain Traditional Chinese. Proper nouns, stable IDs, enum values, hashes, and measurements are language-neutral and are not duplicated. `null` means not measured or unknown, not zero. Similar metrics from different suites must not be directly averaged.

## 繁體中文

本目錄是從 119 個本機來源檔蒸餾出的正規化快照。

推薦讀取順序：

1. `systems.json`：比較環境與 runtime lanes。
2. `models.json`：模型 ID、量化、狀態與 authority 邊界。
3. `benchmark-suites.json`：測法與可比較範圍。
4. `results.json`：單模型 observations。
5. `topologies.json`：多模型組合 observations。
6. `decisions.json`：截至 2026-07-17 的路由與禁止事項。
7. `provenance.json` 與 `source-files.json`：蒸餾範圍與 119 檔逐檔 disposition。

自然語言的基本欄位使用英文；對應的 `*_zh_tw` 欄位使用繁中。專有名詞、穩定 ID、enum、雜湊及度量屬於語言中立資料，不重複儲存。`null` 表示未測或未知，不是 0；不同 suite 中即使名稱相似的 metric 也不得直接平均。
