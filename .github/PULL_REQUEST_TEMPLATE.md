## Scope / 範圍

- [ ] New immutable submission / 新增不可變投稿
- [ ] Versioned suite, schema, or tool change / 版本化 suite、schema 或工具變更
- [ ] Documentation or reference correction / 文件或參考資料修正

Describe what changed and what stayed unchanged. / 請說明變更內容及保持不變的部分。

## Reproducibility / 可重現性

- [ ] New results are under `submissions/<submitter>/<run-id>/submission.json`. / 新結果位於指定投稿路徑。
- [ ] Hardware, model asset, quantization, runtime, context, and output budget are recorded. / 已記錄硬體、模型資產、量化、runtime、context 與 output budget。
- [ ] PASS/FAIL uses an external parser, compiler, test, or tool gate. / PASS／FAIL 使用外部 parser、compiler、test 或 tool gate。
- [ ] Shared reference arrays and other submissions were not overwritten. / 未覆寫共享 reference arrays 或其他投稿。

## Bilingual content / 雙語內容

- [ ] English base fields and matching Traditional Chinese `*_zh_tw` fields were updated together. / 英文基本欄位與對應繁中 `*_zh_tw` 已同步更新。
- [ ] Markdown changes contain equivalent `English` and `繁體中文` sections. / Markdown 變更包含語意對等的英文與繁中章節。

## Public safety and rights / 公開安全與權利

- [ ] No weights, binaries, credentials, private paths, account identifiers, or unreviewed raw logs. / 不含權重、binary、憑證、私有路徑、帳號識別碼或未審查 raw logs。
- [ ] I have the right to publish this material. / 我有權發布此材料。
- [ ] I accept CC BY 4.0 for data/docs and MIT for code/tools. / 我同意資料／文件採 CC BY 4.0，程式／工具採 MIT。

## Validation / 驗證

Paste the final output from the command below. / 請貼上下列命令的最終輸出。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```
