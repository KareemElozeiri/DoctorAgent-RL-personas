#!/bin/bash

# List of evaluation commands for patient persona experiment outputs.
# Run this script from the DoctorAgent-RL directory.

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/dr_elizabeth/dr_elizabeth.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/dr_elizabeth/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/margaret_illiterate/margaret_illiterate.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/margaret_illiterate/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/timmy_kid/timmy_kid.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/timmy_kid/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
  --simulation_data outputs/persona_experiments/edu_level_1_illiterate/edu_level_1_illiterate.json \
  --reference_data data/MTMedDialog_test.json \
  --output outputs/persona_experiments/edu_level_1_illiterate/eval_scores.json \
  --batch_size 32 \
  --alpha 1.0 \
  --beta 0.01

python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
  --simulation_data outputs/persona_experiments/edu_level_2_elementary/edu_level_2_elementary.json \
  --reference_data data/MTMedDialog_test.json \
  --output outputs/persona_experiments/edu_level_2_elementary/eval_scores.json \
  --batch_size 32 \
  --alpha 1.0 \
  --beta 0.01
