# Extending DoctorAgent-RL: Patient Personas, Structured Memory, and Efficiency-Aware Reward Shaping

**Youssef Mohamed · Kareem El Ozeiri · Mervat Abassy**
Mohamed Bin Zayed University of Artificial Intelligence, Abu Dhabi, UAE

> This repository extends [DoctorAgent-RL](https://github.com/JarvisUSTC/DoctorAgent-RL) (Feng et al., 2025) with three additions: patient persona injection, structured JSON schema memory, and an early termination bonus reward. We build on their codebase and evaluation pipeline without modifying the original training objective.

---

## What We Added

### 1. Patient Persona Injection
The original patient agent treats all patients identically. We prepend a persona descriptor to the patient agent's system prompt, varying education level and profession type. Personas adjust communication style only and never override case-level attributes (age, gender, condition).

**Education levels:** Illiterate · Elementary · High School · Graduate

**Profession types:** Manual Labor · Professional (White-Collar)

Key finding: diagnostic quality follows a monotonic gradient with education level — graduate personas yield the highest combined score (0.4256) and illiterate the lowest (0.3584), while average turns remain stable across all conditions (8.37–8.58).

| Persona | Score | Turns |
|---|---|---|
| No persona (baseline) | 0.3906 | 8.56 |
| Illiterate | 0.3584 | 8.50 |
| Elementary | 0.3792 | 8.57 |
| High School | 0.3916 | 8.58 |
| **Graduate** | **0.4256** | **8.37** |
| Manual Labor | 0.3618 | 8.54 |
| Professional | 0.4107 | 8.56 |

### 2. Structured JSON Schema Memory
The doctor agent's context is augmented with an 11-slot JSON schema that is updated each turn with newly elicited patient information (symptoms, medications, history, etc.). This reduces redundant questioning and provides explicit state tracking across turns.

| Setup | Score | Turns |
|---|---|---|
| No schema (baseline) | 0.3906 | 8.56 |
| **Schema** | **0.4105** | **8.50** |

### 3. Early Termination Bonus (ETB)
We add a reward shaping term that incentivizes correct diagnosis *before* the turn budget is exhausted:

```
R_early = ((T - t) / T) × diagnosis_score × 5
```

where `T` is the max turns and `t` is the turn at which the diagnosis is issued. A wrong early diagnosis earns no bonus (scaled by accuracy). The reward is integrated into both training environments and the evaluation pipeline. Due to GPU constraints (1× A40 vs. 8× A100), full training convergence was not achieved; the formulation and implementation are contributed as future work.

---

## Setup

### 1. Clone and initialize submodules
```bash
git clone https://github.com/KareemElozeiri/DoctorAgent-RL-personas.git
cd DoctorAgent-RL-personas
git submodule update --init --recursive
```

### 2. Install dependencies
```bash
bash scripts/setup_ragen.sh
pip install -e verl/
```

### 3. Download models
- [Qwen2.5-7B-Instruct](https://huggingface.co/Qwen/Qwen2.5-7B-Instruct) — patient agent
- [DoctorAgent-RL-SFT-1k-Thinking](https://huggingface.co/Jarvis1111/DoctorAgent-RL-SFT-1k-Thinking) — SFT base for RL training

---

## Running Experiments

### Persona Evaluation (no retraining needed)

```bash
# Run inference for all persona conditions
bash persona_infer.sh <path_to_model>

# Evaluate and print summary table
bash persona_eval.sh
```

Results are written to `outputs/persona_experiments/`.

### Persona Evaluation with ETB Model

```bash
# Step 1: inference
bash persona_infer_early_term.sh <path_to_model> [patient_model_path] [persona_dir]

# Step 2: evaluate and summarize with ETB column
bash persona_eval_early_term.sh
```

Results are written to `outputs/persona_experiments_etb/`.

### Train with Early Termination Bonus (single GPU)

```bash
# Edit WANDB_API_KEY in the script first, then:
bash scripts_exp/doctor-agent-rl-dynamic-1gpu.sh
```

For the original 8-GPU training:
```bash
bash scripts_exp/doctor-agent-rl-dynamic.sh
```

### Standard Evaluation

```bash
bash ragen/env/medical_consultation/evaluation/run_eval_patientllm_category.sh <model_path>
```

---

## Credits

This work builds directly on **DoctorAgent-RL** by Feng et al. (2025). Please cite their work if you use this repository:

```bibtex
@article{feng2025doctoragent,
  title={DoctorAgent-RL: A Multi-Agent Collaborative Reinforcement Learning System for Multi-Turn Clinical Dialogue},
  author={Feng, Yichun and Wang, Jiawei and Zhou, Lu and Li, Yixue},
  journal={arXiv preprint arXiv:2505.19630},
  year={2025}
}
```

Dataset: MTMedDialog (Sviridov et al., 2025) — the first English multi-turn medical consultation dataset designed for dynamic patient simulation.
