# Contributing

新增結果時，複製：

```text
submissions/_template/
```

到：

```text
submissions/<submitter-slug>/<YYYY-MM-DD--run-slug>/
└── submission.json
```

規則：

- 只新增自己的 run，不修改 `data/` reference arrays 或其他投稿者資料。
- 一個 submission 只代表一組固定 system/runtime/model/evaluation 條件。
- 關鍵條件改變就建立新 run，不覆蓋舊結果。
- PASS/FAIL 必須有 parser、compiler、test 或 tool contract；模型自評不算。
- 不提交模型權重、binary、cache、私有路徑、帳號資料或未審查 raw logs。
- 新 benchmark 若不能對應現有 suite，先用 PR 新增版本化 suite definition，再提交結果。

驗證：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

提交 PR 代表你有權發布內容，並同意文件／資料採 CC BY 4.0、程式／工具採 MIT。
