# Scope and limitations

- 只代表一台 24GB RTX 5090 Laptop reference workstation，不是通用排行榜。
- 題型偏向 agent coding、JSON contract、Rust／TypeScript 與工具呼叫；不代表聊天、創作、OCR 或多模態。
- LM Studio 與 llama.cpp native 指標分 lane；`max_tokens=1` 暖機 proxy 不是 cold TTFT。
- Raw prompts、wire payloads、原始 Rust crates 與完整 compiler logs 未公開，因此 distilled records 可稽核但不保證逐字重播。
- `source-files.json` 的 SHA-256 證明蒸餾時考慮的來源版本；它不提供原始內容，也不表示第三方取得發布權。
- 模型名稱與版本是當時 observation。Runtime compatibility、上游權重與授權可能在之後改變。
- 公開 scanner 只能攔截常見秘密形狀，不能取代人工閱讀。
