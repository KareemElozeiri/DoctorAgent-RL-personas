#!/bin/bash

# List of inference commands for patient persona experiments.
# Run this script from the DoctorAgent-RL directory.

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/dr_elizabeth \
#   --output_prefix dr_elizabeth \
#   --patient_persona /workspace/kareem/patient_persona/dr_elizabeth.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/margaret_illiterate \
#   --output_prefix margaret_illiterate \
#   --patient_persona /workspace/kareem/patient_persona/margaret_illiterate.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/timmy_kid \
#   --output_prefix timmy_kid \
#   --patient_persona /workspace/kareem/patient_persona/timmy_kid.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/edu_level_1_illiterate \
#   --output_prefix edu_level_1_illiterate \
#   --patient_persona /workspace/kareem/patient_persona/education_level/edu_level_1_illiterate.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
  --model_path Jarvis1111/DoctorAgent-RL \
  --input_file data/MTMedDialog_test.json \
  --output_dir outputs/persona_experiments/edu_level_2_elementary \
  --output_prefix edu_level_2_elementary \
  --patient_persona /workspace/kareem/patient_persona/education_level/edu_level_2_elementary.txt \
  --max_iterations 10 \
  --temperature 0.7 \
  --top_p 0.9 \
  --batch_size 32 \
  --verbose




