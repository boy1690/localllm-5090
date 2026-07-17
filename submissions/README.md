# Submissions / 投稿

## English

Copy `_template` to `submissions/<submitter>/<YYYY-MM-DD--run-slug>/`. Update the submitter directory, run directory, `submitter_slug`, and `submission_id` together.

Each PR should add only the contributor's own run. Write English in base natural-language fields and Traditional Chinese in the matching `*_zh_tw` fields. If `suite_id` is absent from `data/benchmark-suites.json`, first propose a versioned suite definition. Do not place results produced with different prompts, runtimes, or gates into an existing suite.

## 繁體中文

將 `_template` 複製到 `submissions/<submitter>/<YYYY-MM-DD--run-slug>/`，並同步修改投稿者目錄、run 目錄、`submitter_slug` 與 `submission_id`。

每個 PR 只新增投稿者自己的 run。自然語言的英文放在基本欄位，繁中放在對應的 `*_zh_tw` 欄位。若 `suite_id` 不在 `data/benchmark-suites.json`，請先提出版本化 suite definition；不要把不同 prompt、runtime 或 gate 的結果塞進既有 suite。
