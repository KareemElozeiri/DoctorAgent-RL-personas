# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/edu_level_3_highschool \
#   --output_prefix edu_level_3_highschool \
#   --patient_persona /workspace/kareem/patient_persona/education_level/edu_level_3_highschool.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/edu_level_4_college \
#   --output_prefix edu_level_4_college \
#   --patient_persona /workspace/kareem/patient_persona/education_level/edu_level_4_college.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
  --model_path Jarvis1111/DoctorAgent-RL \
  --input_file data/MTMedDialog_test.json \
  --output_dir outputs/persona_experiments/edu_level_5_graduate \
  --output_prefix edu_level_5_graduate \
  --patient_persona /workspace/kareem/patient_persona/education_level/edu_level_5_graduate.txt \
  --max_iterations 10 \
  --temperature 0.7 \
  --top_p 0.9 \
  --batch_size 32 \
  --verbose

python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
  --model_path Jarvis1111/DoctorAgent-RL \
  --input_file data/MTMedDialog_test.json \
  --output_dir outputs/persona_experiments/edu_level_6_medical \
  --output_prefix edu_level_6_medical \
  --patient_persona /workspace/kareem/patient_persona/education_level/edu_level_6_medical.txt \
  --max_iterations 10 \
  --temperature 0.7 \
  --top_p 0.9 \
  --batch_size 32 \
  --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/emotion_anxious \
#   --output_prefix emotion_anxious \
#   --patient_persona /workspace/kareem/patient_persona/emotional_state/emotion_anxious.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/emotion_calm \
#   --output_prefix emotion_calm \
#   --patient_persona /workspace/kareem/patient_persona/emotional_state/emotion_calm.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 28 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/emotion_frustrated \
#   --output_prefix emotion_frustrated \
#   --patient_persona /workspace/kareem/patient_persona/emotional_state/emotion_frustrated.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose

# python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
#   --model_path Jarvis1111/DoctorAgent-RL \
#   --input_file data/MTMedDialog_test.json \
#   --output_dir outputs/persona_experiments/lang_level_1_broken \
#   --output_prefix lang_level_1_broken \
#   --patient_persona /workspace/kareem/patient_persona/lang_level/lang_level_1_broken.txt \
#   --max_iterations 10 \
#   --temperature 0.7 \
#   --top_p 0.9 \
#   --batch_size 32 \
#   --verbose