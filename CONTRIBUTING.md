# Contributing / 貢獻指南

## English

Copy:

```text
submissions/_template/
```

to:

```text
submissions/<submitter-slug>/<YYYY-MM-DD--run-slug>/
└── submission.json
```

Rules:

- Add only your own run. Do not modify `data/` reference arrays or another contributor's submission.
- One submission represents one fixed system, runtime, model, and evaluation configuration.
- Create a new run whenever a material condition changes; never overwrite an older result.
- PASS/FAIL requires an external parser, compiler, test, or tool-contract gate. Model self-assessment is not evidence.
- Do not submit model weights, binaries, caches, private paths, account data, or unreviewed raw logs.
- Write English in base natural-language fields and Traditional Chinese in matching `*_zh_tw` fields. Maintainers may help review translations, but both fields must be present.
- If a new benchmark cannot map to an existing suite, first propose a versioned suite definition in a separate PR.

Validate before opening a PR:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

By opening a PR, you confirm that you have the right to publish the material and agree to CC BY 4.0 for documentation/data and MIT for software/tools.

## 繁體中文

將：

```text
submissions/_template/
```

複製到：

```text
submissions/<submitter-slug>/<YYYY-MM-DD--run-slug>/
└── submission.json
```

規則：

- 只新增自己的 run，不修改 `data/` reference arrays 或其他投稿者資料。
- 一個 submission 只代表一組固定的 system、runtime、model 與 evaluation 條件。
- 關鍵條件改變就建立新 run，不覆蓋舊結果。
- PASS/FAIL 必須有外部 parser、compiler、test 或 tool-contract gate；模型自評不算證據。
- 不提交模型權重、binary、cache、私有路徑、帳號資料或未審查 raw logs。
- 自然語言的英文寫在基本欄位，繁中寫在對應的 `*_zh_tw` 欄位。維護者可協助審查翻譯，但兩者都必須存在。
- 新 benchmark 若不能對應現有 suite，請先用另一個 PR 提出版本化 suite definition。

開 PR 前執行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

提交 PR 代表你確認有權發布內容，並同意文件／資料採 CC BY 4.0、程式／工具採 MIT。
