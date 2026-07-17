# Findings / 研究發現

Snapshot: 2026-07-16; compatibility follow-up through 2026-07-17.

## English

### 24 GB sweet spot

- Devstral Small 2 24B Q4_K_M: the most stable general TypeScript and implementation worker in this snapshot.
- Qwen3.6 35B-A3B Q4_K_M: the main high-risk Rust worker at 32K thinking, but it must be followed by a Cargo repair loop.
- Qwen3 4B: an efficiency-first bounded checker; escalate code-specific ambiguity to Qwen2.5-Coder 7B.
- Agents-A1 4B: useful for required tool calls and very narrow compiler friction, not long-form implementation.
- GPT-OSS 120B at 25% GPU and 75% RAM: completed the task but took roughly four minutes, making it suitable only for batch or overnight work.

### Failures matter more than rankings

- Devstral Q6_K: capacity passed but quality was not promoted; do not use it as a Rust worker, repair model, or judge.
- DeepSeek 32B at 8K: only 1,777 MiB remained after loading, below the headroom gate.
- North Mini Code at 32K: it fit in memory but produced no final answer within 300 seconds.
- Gemma 4 31B QAT Q4_0: two llama.cpp builds hit tokenizer assertions. This is a runtime compatibility block, not a quality judgment.
- Gemma 4 26B-A4B QAT Q4_0: only a partial download existed, so integrity, loading, and quality were not tested.
- Laguna XS 2.1: the observed LM Studio backend did not support its architecture.

### Topology

Fixed 1+1 chains, fixed multi-leaf chains, model voting, and fixed judges did not reliably improve quality. The successful Rust repair sequence was: strong-model skeleton → Cargo diagnostics → each small leaf reviews one bounded friction type → strong judge applies the smallest repair → rerun objective gates. It ended at 5 passed and 0 failed.

This repository therefore does not publish a single model leaderboard. `data/results.json` stores observations by suite; `data/decisions.json` stores current role routing with guardrails and limitations.

## 繁體中文

### 24 GB 甜蜜點

- Devstral Small 2 24B Q4_K_M：本快照中最穩定的一般 TypeScript／施工 worker。
- Qwen3.6 35B-A3B Q4_K_M：32K thinking 的高風險 Rust 主力，但後面一定要接 Cargo repair loop。
- Qwen3 4B：效率優先的 bounded checker；code-specific 模糊項升級至 Qwen2.5-Coder 7B。
- Agents-A1 4B：適合 required tool call 與極窄 compiler 摩擦，不作長文字施工。
- GPT-OSS 120B 採 25% GPU／75% RAM：能完成任務但約需四分鐘，只適合 batch／overnight。

### 失敗比排名更重要

- Devstral Q6_K：容量 PASS、品質不升級；禁止作 Rust worker、repair 或 judge。
- DeepSeek 32B 8K：載入後只剩 1,777 MiB，低於 headroom gate。
- North Mini Code 32K：容量可放入，但 300 秒內仍沒有 final。
- Gemma 4 31B QAT Q4_0：兩個 llama.cpp build 都遇到 tokenizer assertion。這是 runtime compatibility block，不是品質判定。
- Gemma 4 26B-A4B QAT Q4_0：只有部分下載，沒有完整性、載入或品質結果。
- Laguna XS 2.1：當時觀察到的 LM Studio backend 不支援該 architecture。

### Topology

固定 1+1、固定多葉、模型投票與固定 judge 均未穩定提升品質。成功的 Rust repair sequence 是：強模型骨架 → Cargo diagnostics → 各小葉只審一種有界摩擦 → 強 judge 作最小修補 → 反覆重跑客觀 gate；最後為 5 passed／0 failed。

因此本 repo 不發布單一模型總分榜。`data/results.json` 按 suite 保存 observations；`data/decisions.json` 保存目前角色路由及其 guardrails 與 limitations。
