#!/bin/bash

set -euo pipefail

OUTPUT_ROOT="outputs/persona_experiments_etb"
REFERENCE_DATA="data/MTMedDialog_test.json"
MAX_TURNS=10

PERSONAS=(
    no_persona
    edu_level_1_illiterate
    edu_level_2_elementary
    edu_level_3_highschool
    edu_level_5_graduate
)

# Create output directories
for PERSONA in "${PERSONAS[@]}"; do
    mkdir -p "$OUTPUT_ROOT/$PERSONA"
done

# Run evaluation sequentially
for PERSONA in "${PERSONAS[@]}"; do
    echo "=========================================="
    echo "Evaluating: $PERSONA"
    echo "=========================================="
    python ragen/env/medical_consultation/evaluation/evaluation_for_patientllm_category.py \
        --simulation_data "$OUTPUT_ROOT/$PERSONA/${PERSONA}_${MAX_TURNS}.json" \
        --reference_data "$REFERENCE_DATA" \
        --output "$OUTPUT_ROOT/$PERSONA/eval_scores.json" \
        --max_turns $MAX_TURNS
    echo "Done: $PERSONA"
done

# Summarize all results
echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
python summarize_persona_eval_scores.py \
    --root "$OUTPUT_ROOT" \
    --sort-by etb \
    --descending \
    --max-turns $MAX_TURNS
