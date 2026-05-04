#!/bin/bash

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/lang_level_2_accented/lang_level_2_accented.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/lang_level_2_accented/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/lang_level_3_native/lang_level_3_native.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/lang_level_3_native/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
  --simulation_data outputs/persona_experiments/prof_manual_labor/prof_manual_labor.json \
  --reference_data data/MTMedDialog_test.json \
  --output outputs/persona_experiments/prof_manual_labor/eval_scores.json \
  --batch_size 16 \
  --alpha 1.0 \
  --beta 0.01

python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
  --simulation_data outputs/persona_experiments/prof_professional/prof_professional.json \
  --reference_data data/MTMedDialog_test.json \
  --output outputs/persona_experiments/prof_professional/eval_scores.json \
  --batch_size 16 \
  --alpha 1.0 \
  --beta 0.01
