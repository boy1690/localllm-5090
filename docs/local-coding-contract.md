# Local Coding Contract Experiment / 本機 Coding Contract 實驗

Languages: English and Traditional Chinese / 語言：English 與繁體中文。

This document records a local quality experiment against the public benchmark methodology. It is an experiment addendum, not a replacement for the normalized reference data in `data/`.

這份文件記錄依照本 repo 公開方法進行的本機品質實驗；它是實驗附錄，不取代 `data/` 中的 normalized reference data。

## Configuration / 測試設定

- System: RTX 5090 Laptop GPU, 24 GB dedicated VRAM, Windows 11.
- Runtime: llama.cpp `b10069`, CUDA 13.3.
- Models: Qwen3.8-27B Q4_K_M and Devstral Small 2 24B Instruct Q4_K_M.
- Inference: full GPU offload, one slot, 8192 context, temperature 0, seed 42, reasoning off.
- Gates: JSON parser and value checks; TypeScript `tsc --strict` plus emitted-JavaScript self-tests; Rust `rustc --edition 2021` plus runtime assertions.

- 系統：RTX 5090 Laptop GPU，24 GB dedicated VRAM，Windows 11。
- Runtime：llama.cpp `b10069`，CUDA 13.3。
- 模型：Qwen3.8-27B Q4_K_M、Devstral Small 2 24B Instruct Q4_K_M。
- 推論：完整 GPU offload、單 slot、8192 context、temperature 0、seed 42、關閉 reasoning。
- Gate：JSON parser 與欄位值檢查；TypeScript `tsc --strict` 加上編譯後 JavaScript 自我測試；Rust `rustc --edition 2021` 加上 runtime assertions。

## Results / 結果

The standard suite contains 12 cases: three JSON cases, three TypeScript cases, three Rust implementation cases, and three repair cases.

標準 suite 共 12 題：3 題 JSON、3 題 TypeScript、3 題 Rust implementation、3 題 repair。

| Model | Standard suite | Hard suite |
|---|---:|---:|
| Qwen3.8-27B Q4_K_M | 12/12 | 5/6 |
| Devstral Small 2 24B Q4_K_M | 12/12 | 4/6 |

The hard suite adds six higher-risk cases: asynchronous concurrency limiting, asynchronous retry, transactional state updates, an LRU cache invariant, overflow-safe token-bucket refill, and sorted-merge repair.

Hard suite 另外加入六個高風險題型：非同步併發限制、非同步 retry、transactional state 更新、LRU cache invariant、避免 overflow 的 token bucket refill，以及 sorted merge repair。

Qwen3.8 failed the hard token-bucket case because the generated Rust source contained a `reffill` typo. Devstral failed the hard asynchronous-concurrency and transactional-TypeScript cases at the compiler/self-test gate. These are deliverability failures, not model self-assessments.

Qwen3.8 的 hard token bucket 題因生成的 Rust source 含有 `reffill` typo 而失敗。Devstral 的 hard asynchronous-concurrency 與 transactional-TypeScript 題未通過 compiler/self-test gate。這些是 deliverability failure，不是模型自評。

## Interpretation / 解讀

This single-seed hard-suite result favors Qwen3.8 by one case, while the standard suite is tied. It is not a normalized leaderboard and must not be averaged with throughput results from another `suite_id` or runtime lane. Repeating the hard suite with seeds 7 and 99 is the next stability check.

這次單一 seed 的 hard suite 結果，Qwen3.8 多通過一題；標準 suite 則平手。這不是 normalized leaderboard，也不應與其他 `suite_id` 或 runtime lane 的 throughput 結果直接平均。下一步穩定性檢查是用 seed 7 與 99 重跑 hard suite。

No model weights, raw logs, private paths, caches, or private prompts are included in this addendum.

本附錄不包含模型權重、raw logs、私人路徑、cache 或私人 prompts。
