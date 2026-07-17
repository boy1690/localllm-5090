# Scope and limitations / 範圍與限制

## English

- The results represent one 24 GB RTX 5090 Laptop reference workstation, not a universal leaderboard.
- Cases emphasize agent coding, JSON contracts, Rust, TypeScript, and tool calls. They do not represent chat, creative writing, OCR, or multimodal quality.
- LM Studio and native llama.cpp metrics use separate lanes; the `max_tokens=1` warm-up proxy is not cold time-to-first-token.
- Raw prompts, wire payloads, original Rust crates, and complete compiler logs are not public. The distilled records are auditable but do not guarantee byte-for-byte replay.
- SHA-256 entries in `source-files.json` identify the source versions considered during distillation. They do not expose the source content or grant publication rights to third parties.
- Model names and versions are observations at the recorded date. Runtime compatibility, upstream weights, and licenses may later change.
- The public scanner detects common secret shapes but cannot replace manual review.

## 繁體中文

- 結果只代表一台 24 GB RTX 5090 Laptop reference workstation，不是通用排行榜。
- 題型偏向 agent coding、JSON contract、Rust、TypeScript 與工具呼叫；不代表聊天、創作、OCR 或多模態品質。
- LM Studio 與 native llama.cpp 指標分 lane；`max_tokens=1` 暖機 proxy 不是 cold time-to-first-token。
- Raw prompts、wire payloads、原始 Rust crates 與完整 compiler logs 未公開；distilled records 可稽核，但不保證逐 byte 重播。
- `source-files.json` 中的 SHA-256 識別蒸餾時採用的來源版本；它不揭露原始內容，也不授予第三方發布權。
- 模型名稱與版本是記錄日期當時的 observation。Runtime compatibility、上游權重與授權之後可能改變。
- 公開 scanner 只能偵測常見秘密形狀，不能取代人工審閱。
