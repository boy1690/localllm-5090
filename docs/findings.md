# Findings

Snapshot：2026-07-16；相容性追蹤至 2026-07-17。

## 24GB sweet spot

- Devstral Small 2 24B Q4_K_M：目前最穩的一般 TypeScript／施工 worker。
- Qwen3.6 35B-A3B Q4_K_M：32K thinking 高風險 Rust 主力，但一定要接 Cargo repair loop。
- Qwen3 4B：效率優先 bounded checker；code-specific 模糊項升級 Qwen2.5-Coder 7B。
- Agents-A1 4B：required tool call 與極窄 compiler 摩擦，不作長文字施工。
- GPT-OSS120 25% GPU／75% RAM：能跑但約四分鐘，只適合 batch／overnight。

## 失敗比排名更重要

- Devstral Q6_K：容量 PASS、品質不升級；禁止 Rust worker／repair／judge。
- DeepSeek 32B 8K：載入後只剩 1,777 MiB，低於 headroom gate。
- North Mini Code 32K：容量可放入，但 300 秒仍沒有 final。
- Gemma 4 31B QAT Q4_0：兩個 llama.cpp build 都在 tokenizer assert；這是 runtime compatibility block，不是品質判定。
- Gemma 4 26B-A4B QAT Q4_0：只有部分下載，沒有完整性、載入或品質結果。
- Laguna XS 2.1：當時 LM Studio backend 不支援該 architecture。

## Topology

固定 `1+1`、固定多葉、模型投票與固定 judge 都沒有穩定提升品質。成功的 Rust repair sequence 是：強模型骨架 → Cargo diagnostics → 各小葉只審一種摩擦 → 強 judge 最小修補 → 反覆重跑 gate，最後 5 passed／0 failed。

因此本 repo 不提供「模型總分榜」。`data/results.json` 按 suite 保存 observation；`data/decisions.json` 才是目前角色路由，而且每個決策都帶 guardrails 與 limitations。
