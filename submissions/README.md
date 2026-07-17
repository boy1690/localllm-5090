# Submissions

複製 `_template` 到 `submissions/<submitter>/<YYYY-MM-DD--run-slug>/`，同步修改父目錄、run 目錄、`submitter_slug` 與 `submission_id`。

每個 PR 只新增自己的 run。若 `suite_id` 不在 `data/benchmark-suites.json`，先提出版本化 suite definition；不要把不同 prompt/runtime/gate 的結果塞進既有 suite。
