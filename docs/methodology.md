# Methodology / 方法

## English

### Reference system

Measurements came from one NVIDIA GeForce RTX 5090 Laptop GPU with 24,462–24,463 MiB of dedicated VRAM, 128 GB-class RAM, and Windows 11. The main current lane was llama.cpp b9946 with CUDA 12.4; earlier results used LM Studio. Results from these lanes are not directly mixed.

Workstation brand, CPU model, exact OS build, hostname, accounts, and absolute paths were not necessary for comparison and were excluded from the distilled dataset.

### Admission order

1. Model-asset integrity: byte count and SHA-256 when available.
2. Capacity: dedicated VRAM before/after loading, shared memory, and remaining headroom.
3. Output carrier: final content, finish reason, JSON carrier, and required tool calls.
4. Static contracts: schema, forbidden tokens, TypeScript strictness, and prohibited Rust constructs.
5. Objective execution: parser, compiler, and tests.
6. Speed: throughput and headroom decide only when quality is close.

Loading does not imply safe interaction; generation does not imply deliverability; model self-verification is not a gate.

### Performance lanes

- `native-llama-cpp-2026-07-16`: `pp512` prompt processing and `tg128` generation. Do not average these with end-to-end structured timing.
- `deepseek-e2e-2026-07-10`: an LM Studio end-to-end and capacity evaluation.
- `small-checker-2026-07-11`: the same ten-case exact checker suite. P5/P10 are request slots for one loaded weight, not independent opinions.
- `long-context-coding-2026-07-16`: requires a final answer within the time limit and a passing compiler/test gate; memory fit alone is insufficient.
- `topology-2026-07-07-to-16`: large models have sequential ownership; small-leaf authority is limited to predefined friction types.

### Capacity policy

The reference operating policy required at least 2,048 MiB of dedicated headroom after loading and no more than 512 MiB of shared-memory growth from one new inference process. Admission must be repeated when context, KV policy, or runtime changes.

### Quality cases

Fixed cases covered raw JSON materialization, TypeScript strict patches, Rust async/backoff, adversarial repair, and required tool calls. Raw prompts are excluded; `data/benchmark-suites.json` preserves only purpose, version, and external gates so private product scenarios are not presented as a universal benchmark.

## 繁體中文

### Reference system

測量來自單張 NVIDIA GeForce RTX 5090 Laptop GPU，dedicated VRAM 24,462–24,463 MiB、128 GB-class RAM、Windows 11。主要 current lane 是 llama.cpp b9946／CUDA 12.4；較早結果使用 LM Studio，兩種 lane 不直接混比。

工作站品牌、CPU 型號、精確 OS build、hostname、帳號與絕對路徑不是比較所需欄位，因此不進 distilled dataset。

### Admission 順序

1. 模型資產完整性：可取得時記錄 bytes 與 SHA-256。
2. 容量：載入前後 dedicated VRAM、shared memory 與剩餘 headroom。
3. 輸出載體：final content、finish reason、JSON carrier 與必要工具呼叫。
4. 靜態契約：schema、forbidden tokens、TypeScript strict 與 Rust 禁用構造。
5. 客觀執行：parser、compiler 與 tests。
6. 速度：只有品質接近時才用吞吐與 headroom 決勝。

能載入不代表能安全互動；能生成不代表能交付；模型自評不算 gate。

### Performance lanes

- `native-llama-cpp-2026-07-16`：`pp512` prompt processing 與 `tg128` generation，不可和 end-to-end structured timing 平均。
- `deepseek-e2e-2026-07-10`：LM Studio end-to-end／capacity 專項。
- `small-checker-2026-07-11`：同一組十題 exact checker suite；P5/P10 是一份載入權重的 request slots，不是獨立觀點。
- `long-context-coding-2026-07-16`：必須在時限內產生 final 並通過 compiler/test gate，不能只看記憶體 fit。
- `topology-2026-07-07-to-16`：大型模型採 sequential ownership；小葉 authority 限定在預先定義的摩擦類型。

### Capacity policy

Reference operation 要求載入後至少保留 2,048 MiB dedicated headroom，且單一新 inference process 的 shared-memory growth 不超過 512 MiB。Context、KV policy 或 runtime 改變時必須重新 admission。

### Quality cases

固定題涵蓋 raw JSON materialization、TypeScript strict patch、Rust async/backoff、adversarial repair 與 required tool call。Raw prompts 未公開；`data/benchmark-suites.json` 只保留目的、版本與外部 gate，避免把私人產品情境當成通用 benchmark。
