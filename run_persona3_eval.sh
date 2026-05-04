#!/bin/bash

python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
  --simulation_data outputs/persona_experiments/edu_level_3_highschool/edu_level_3_highschool.json \
  --reference_data data/MTMedDialog_test.json \
  --output outputs/persona_experiments/edu_level_3_highschool/eval_scores.json \
  --batch_size 28 \
  --alpha 1.0 \
  --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/edu_level_4_college/edu_level_4_college.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/edu_level_4_college/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
  --simulation_data outputs/persona_experiments/edu_level_5_graduate/edu_level_5_graduate.json \
  --reference_data data/MTMedDialog_test.json \
  --output outputs/persona_experiments/edu_level_5_graduate/eval_scores.json \
  --batch_size 28 \
  --alpha 1.0 \
  --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/edu_level_6_medical/edu_level_6_medical.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/edu_level_6_medical/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/emotion_anxious/emotion_anxious.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/emotion_anxious/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/emotion_calm/emotion_calm.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/emotion_calm/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/emotion_frustrated/emotion_frustrated.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/emotion_frustrated/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01

# python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
#   --simulation_data outputs/persona_experiments/lang_level_1_broken/lang_level_1_broken.json \
#   --reference_data data/MTMedDialog_test.json \
#   --output outputs/persona_experiments/lang_level_1_broken/eval_scores.json \
#   --batch_size 6 \
#   --alpha 1.0 \
#   --beta 0.01
