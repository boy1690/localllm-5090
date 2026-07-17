# Methodology

## Reference system

測量來自單張 NVIDIA GeForce RTX 5090 Laptop GPU，dedicated VRAM 24,462–24,463 MiB，128GB-class RAM，Windows 11。主要 current lane 是 llama.cpp b9946／CUDA 12.4；較早結果使用 LM Studio，兩種 lane 不直接混比。

工作站品牌、CPU 型號、OS build、hostname、帳號與絕對路徑不是比較所需欄位，因此不進 distilled dataset。

## Admission order

1. 模型資產完整性：bytes 與 SHA-256（可取得時）。
2. 容量：載入前後 dedicated VRAM、shared memory、剩餘 headroom。
3. 輸出載體：final content、finish reason、JSON carrier、必要工具呼叫。
4. 靜態契約：schema、forbidden tokens、TypeScript strict、Rust 禁用構造。
5. 客觀執行：parser、compiler、tests。
6. 速度：只有品質接近時才用吞吐與 headroom 決勝。

能載入不代表能安全互動；能生成不代表能交付；模型自評不算 gate。

## Performance lanes

- `native-llama-cpp-2026-07-16`：`pp512` prompt processing 與 `tg128` generation，不能和 end-to-end structured timing 平均。
- `deepseek-e2e-2026-07-10`：LM Studio end-to-end／capacity 專項。
- `small-checker-2026-07-11`：同一 10 題 exact checker suite，P5/P10 是一份權重的 request slots，不是多個獨立觀點。
- `long-context-coding-2026-07-16`：是否在時限內產生 final 並通過 compiler/test，而非只看 fit。
- `topology-2026-07-07-to-16`：大型席 sequential ownership；小葉 authority 限定在預先定義摩擦。

## Capacity policy

Reference operation 曾採：載入後至少 2,048 MiB dedicated headroom，單一新 inference process shared growth 不超過 512 MiB。Context、KV policy 或 runtime 改變時必須重新 admission。

## Quality cases

固定題涵蓋 raw JSON materialization、TypeScript strict patch、Rust async/backoff、adversarial repair 與 required tool call。Raw case prompts 未收入 distilled repo；`data/benchmark-suites.json` 只保留目的、版本與外部 gate，避免把私人產品情境當成通用 benchmark。
