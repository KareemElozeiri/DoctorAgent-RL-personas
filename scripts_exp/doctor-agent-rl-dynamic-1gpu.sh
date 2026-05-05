#!/bin/bash

# Single-GPU training script (adapted from doctor-agent-rl-dynamic.sh)
# Requires ~40GB VRAM (e.g. A40 48GB). Both 7B models share the single GPU.

WANDB_API_KEY=${WANDB_API_KEY:-"YOUR_API_KEY"}
wandb login $WANDB_API_KEY

export RAY_DEBUG_POST_MORTEM=0
export VLLM_ATTENTION_BACKEND=XFORMERS
export CUDA_VISIBLE_DEVICES="0"

clip_ratio_low=0.2
clip_ratio_high=0.28
entropy_coeff=0.001

model_path=DoctorAgent-RL-SFT-1k-Thinking
exp_name=exp-medical-1gpu-etb
project_name=RAGEN

python -m ragen.trainer.main_ppo \
  hydra.run.dir=outputs/exp_configs/logs/$(date +%Y-%m-%d)/$(date +%H-%M-%S) \
  data.train_files=data/MTMedDialog_RL.parquet \
  data.val_files=data/MTMedDialog_RL.parquet \
  data.train_data_num=null \
  data.val_data_num=8 \
  data.train_batch_size=8 \
  data.val_batch_size=8 \
  data.max_prompt_length=6528 \
  data.max_response_length=256 \
  data.max_start_length=512 \
  data.max_obs_length=256 \
  data.shuffle=True \
  algorithm.adv_estimator=grpo \
  actor_rollout_ref.model.path=${model_path} \
  actor_rollout_ref.model.enable_gradient_checkpointing=true \
  actor_rollout_ref.actor.optim.lr=1e-6 \
  actor_rollout_ref.actor.ppo_mini_batch_size=8 \
  actor_rollout_ref.actor.ppo_micro_batch_size=1 \
  actor_rollout_ref.rollout.tensor_model_parallel_size=1 \
  actor_rollout_ref.rollout.gpu_memory_utilization=0.25 \
  actor_rollout_ref.rollout.log_prob_micro_batch_size=1 \
  actor_rollout_ref.ref.log_prob_micro_batch_size=1 \
  actor_rollout_ref.actor.clip_ratio_low=${clip_ratio_low} \
  actor_rollout_ref.actor.clip_ratio_high=${clip_ratio_high} \
  critic.ppo_micro_batch_size=1 \
  critic.optim.lr=1e-5 \
  critic.model.path=${model_path} \
  algorithm.use_kl_in_reward=False \
  algorithm.kl_penalty=low_var_kl \
  algorithm.kl_ctrl.kl_coef=0.001 \
  +algorithm.no_ref_policy=False \
  +actor_rollout_ref.actor.use_ref_policy=True \
  actor_rollout_ref.actor.use_kl_loss=False \
  actor_rollout_ref.actor.kl_loss_coef=0.001 \
  actor_rollout_ref.actor.kl_loss_type=low_var_kl \
  actor_rollout_ref.actor.entropy_coeff=${entropy_coeff} \
  +algorithm.no_think_rl=False \
  +algorithm.reward_norm_type=grpo \
  +actor_rollout_ref.actor.optim.betas=[0.9,0.95] \
  +critic.optim.betas=[0.9,0.95] \
  actor_rollout_ref.rollout.n_agent=4 \
  actor_rollout_ref.rollout.temperature=0.7 \
  actor_rollout_ref.actor.state_masking=True \
  trainer.logger=['console'] \
  +trainer.val_only=false \
  trainer.val_before_train=true \
  trainer.default_hdfs_dir=null \
  trainer.n_gpus_per_node=1 \
  trainer.nnodes=1 \
  trainer.save_freq=20 \
  trainer.test_freq=10 \
  trainer.project_name=${project_name} \
  trainer.experiment_name=${exp_name} \
  trainer.total_epochs=1 \
  trainer.total_training_steps=null \
  +trainer.ref_update_steps=null \
  env.name=medical_consultation_patient_llm \
  env.use_env_llm=True \
  +env.max_turns=-1 \
  env.env_llm.fsdp_config.fsdp_size=1 \
  env.env_llm.fsdp_config.param_offload=True \
  env.env_llm.vllm_config.tensor_parallel_size=1 \
  env.env_llm.vllm_config.gpu_memory_utilization=0.3 \
  env.env_llm.vllm_config.max_num_batched_tokens=2048 \
  env.env_llm.vllm_config.max_num_seqs=64 \
  env.env_llm.model.path=Qwen/Qwen2.5-7B-Instruct \
  env.env_llm.model.trust_remote_code=True \
  env.env_llm.model.use_liger=True \
  env.env_llm.generation.prompt_length=2272 \
  env.env_llm.generation.response_length=256 \
  env.env_llm.generation.max_model_len=2528 \
  env.env_llm.generation.temperature=0.01 \
  env.env_llm.generation.top_p=1.0 \
  env.env_llm.generation.top_k=-1 \
  env.env_llm.generation.repetition_penalty=1.0 \
  env.env_llm.generation.do_sample=False \
  env.env_llm.generation.num_beams=1 \
  env.env_llm.generation.best_of=1 \
  env.env_llm.generation.min_p=0.0 \
  env.env_llm.generation.n=1 \
  env.env_llm.generation.use_cache=True \
  env.env_llm.generation.use_beam_search=False \
  env.env_llm.generation.detokenize=False \
  env.env_llm.generation.ignore_eos=False \
  env.env_llm.generation.free_cache_engine=True \
  env.env_llm.generation.prompt_logprobs=0 \
  env.env_llm.generation.generation_logprobs=1 \
  env.env_llm.generation.disable_log_stats=True \
  env.env_llm.generation.dtype=bfloat16 \
  env.env_llm.generation.enforce_eager=True \
  env.env_llm.generation.enable_chunked_prefill=True \
  env.env_llm.generation.tensor_model_parallel_size=1 \
  env.env_llm.generation.gpu_memory_utilization=0.3 \
  env.env_llm.generation.max_tokens_per_batch=2048 \
  env.env_llm.generation.load_format=dummy_dtensor \
  env.env_llm.ulysses_sequence_parallel_size=1 \
  max_turns=10 \
  logging.log_images=false \
  2>&1

target_model=DoctorLLM-7B-ETB-1GPU
base_model=$model_path
max_step=$(head -n 1 checkpoints/${project_name}/${exp_name}/latest_checkpointed_iteration.txt)
ckpt_path=checkpoints/${project_name}/${exp_name}/global_step_${max_step}/actor

bash merger.sh $base_model $ckpt_path $target_model
