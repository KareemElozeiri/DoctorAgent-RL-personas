#!/bin/bash

set -euo pipefail

MODEL_PATH=${1:?"Usage: bash persona_infer_early_term.sh <path_to_retrained_model>"}
PATIENT_MODEL_PATH=${2:-"Qwen/Qwen2.5-7B-Instruct"}
PERSONA_DIR=${3:-"/workspace/kareem/patient_persona"}
OUTPUT_ROOT="outputs/persona_experiments_etb"
INPUT_FILE="data/MTMedDialog_test.json"
MAX_ITERATIONS=10
BATCH_SIZE=8
TEMPERATURE=0.7
TOP_P=0.9

# ---------------------------------------------------------------------------
# Persona definitions: NAME -> persona file path (empty = no persona)
# ---------------------------------------------------------------------------
declare -A PERSONA_FILE

PERSONA_FILE[no_persona]=""
PERSONA_FILE[edu_level_1_illiterate]="$PERSONA_DIR/education_level/edu_level_1_illiterate.txt"
PERSONA_FILE[edu_level_2_elementary]="$PERSONA_DIR/education_level/edu_level_2_elementary.txt"
PERSONA_FILE[edu_level_3_highschool]="$PERSONA_DIR/education_level/edu_level_3_highschool.txt"
PERSONA_FILE[edu_level_5_graduate]="$PERSONA_DIR/education_level/edu_level_5_graduate.txt"

# ---------------------------------------------------------------------------
# Run inference sequentially for each persona
# ---------------------------------------------------------------------------
for PERSONA in no_persona edu_level_1_illiterate edu_level_2_elementary edu_level_3_highschool edu_level_5_graduate; do
    OUT_DIR="$OUTPUT_ROOT/$PERSONA"
    mkdir -p "$OUT_DIR"

    echo "=========================================="
    echo "Inference: $PERSONA"
    echo "Output:    $OUT_DIR/${PERSONA}_${MAX_ITERATIONS}.json"
    echo "=========================================="

    python ragen/env/medical_consultation/evaluation/inference_fast_for_patientllm.py \
        --model_path "$MODEL_PATH" \
        --patient_model_path "$PATIENT_MODEL_PATH" \
        --input_file "$INPUT_FILE" \
        --output_dir "$OUT_DIR" \
        --output_prefix "$PERSONA" \
        --max_iterations $MAX_ITERATIONS \
        --temperature $TEMPERATURE \
        --top_p $TOP_P \
        --batch_size $BATCH_SIZE \
        --patient_persona "${PERSONA_FILE[$PERSONA]}" \
        --verbose

    echo "Done: $PERSONA"
    echo ""
done

echo "All inference complete. Run bash persona_eval_early_term.sh to evaluate."
