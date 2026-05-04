# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/lang_level_2_accented \
#   --output_prefix lang_level_2_accented \
#   --patient_persona /workspace/kareem/patient_persona/lang_level/lang_level_2_accented.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 16 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/lang_level_3_native \
#   --output_prefix lang_level_3_native \
#   --patient_persona /workspace/kareem/patient_persona/lang_level/lang_level_3_native.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 16 \
#   --verbose

python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
  --model_path Jarvis1111/DoctorAgent-RL \
  --input_file data/MTMedDialog_test.json \
  --output_dir outputs/persona_experiments/prof_manual_labor \
  --output_prefix prof_manual_labor \
  --patient_persona /workspace/kareem/patient_persona/profession/prof_manual_labor.txt \
  --max_iterations 10 \
  --temperature 0.7 \
  --top_p 0.9 \
  --batch_size 32 \
  --verbose

python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
  --model_path Jarvis1111/DoctorAgent-RL \
  --input_file data/MTMedDialog_test.json \
  --output_dir outputs/persona_experiments/prof_professional \
  --output_prefix prof_professional \
  --patient_persona /workspace/kareem/patient_persona/profession/prof_professional.txt \
  --max_iterations 10 \
  --temperature 0.7 \
  --top_p 0.9 \
  --batch_size 32 \
  --verbose