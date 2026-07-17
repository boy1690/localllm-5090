# Localization policy / 雙語維護政策

## English

The repository is maintained in English and Traditional Chinese (`zh-TW`). English is the canonical machine-readable base language; Traditional Chinese is an equal human-readable translation.

- Markdown documents contain complete `English` and `繁體中文` sections.
- JSON natural-language fields use an English base field and an adjacent `*_zh_tw` translation.
- Parallel string arrays use the same convention, for example `limitations` and `limitations_zh_tw`.
- IDs, enum codes, model and product names, versions, dates, paths, hashes, filenames, commands, and measurements remain language-neutral.
- Official license texts in `LICENSES/` are not translated or modified. `LICENSE` explains the split-license scope bilingually.
- A change to one language must update the corresponding translation in the same pull request. If meaning differs, the English field controls machine interpretation until the inconsistency is corrected.

The validator checks the required bilingual fields. Reviewers must still compare meaning manually; field presence cannot prove translation quality.

## 繁體中文

本 repo 以英文與繁體中文（`zh-TW`）共同維護。英文是機器可讀基本欄位的 canonical 語言；繁中是同等的人類可讀翻譯。

- Markdown 文件包含完整的 `English` 與 `繁體中文` 章節。
- JSON 自然語言欄位使用英文基本欄位，並在相鄰的 `*_zh_tw` 放置繁中翻譯。
- 平行字串陣列使用同一規則，例如 `limitations` 與 `limitations_zh_tw`。
- ID、enum code、模型與產品名稱、版本、日期、路徑、雜湊、檔名、命令及度量均視為語言中立資料。
- `LICENSES/` 中的官方授權全文不翻譯、不修改；`LICENSE` 以雙語說明 split-license 範圍。
- 修改任一語言時，必須在同一個 PR 同步更新對應翻譯。若語意不一致，在修正前由英文欄位控制機器解讀。

Validator 會檢查必要雙語欄位是否存在；reviewer 仍須人工比較語意，因為欄位存在不代表翻譯品質正確。
