# Reference data

這裡是從 119 個本機來源檔蒸餾出的 normalized snapshot。

推薦讀取順序：

1. `systems.json`：比較環境與 runtime lanes。
2. `models.json`：模型 ID、量化、狀態與 authority 邊界。
3. `benchmark-suites.json`：測法與可比較範圍。
4. `results.json`：單模型 observations。
5. `topologies.json`：多模型組合 observations。
6. `decisions.json`：截至 2026-07-17 的路由與禁止事項。
7. `provenance.json`／`source-files.json`：蒸餾範圍與 119 檔逐檔 disposition。

`null` 表示未測或未知，不是 0。不同 suite 的 metric 名稱即使相似，也不得直接平均。
