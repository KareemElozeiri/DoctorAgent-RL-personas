#!/usr/bin/env python3

import argparse
import json
from pathlib import Path


def load_average_metrics(path: Path, max_turns: int = 10) -> dict:
    with path.open("r", encoding="utf-8") as f:
        data = json.load(f)

    avg = data.get("average_result", {})
    diag = avg.get("diagnostic_performance", {})
    diagnosis = diag.get("diagnosis", {})
    recommendation = diag.get("recommendation", {})
    interaction = avg.get("interaction_efficiency", {})
    info = avg.get("information_retrieval", {})

    # Use pre-computed ETB if available (from new eval runs), else compute from case_results
    etb = avg.get("early_termination_bonus")
    if etb is None:
        case_results = data.get("case_results", [])
        if case_results:
            etb_values = []
            for case in case_results:
                total_turns = case.get("interaction_efficiency", {}).get("total_turns", max_turns)
                combined_score = case.get("diagnostic_performance", {}).get("combined_score", 0.0)
                turns_remaining = max(0, max_turns - total_turns)
                etb_values.append((turns_remaining / max_turns) * combined_score)
            etb = sum(etb_values) / len(etb_values)

    return {
        "persona": path.parent.name,
        "combined_score": diag.get("combined_score"),
        "diagnosis_score": diagnosis.get("semantic_score"),
        "recommendation_score": recommendation.get("semantic_score"),
        "dei": avg.get("diagnostic_efficiency_index"),
        "etb": etb,
        "info_model_score": info.get("model_score"),
        "info_precision": info.get("precision"),
        "avg_turns": interaction.get("total_turns"),
        "avg_tokens": interaction.get("avg_tokens"),
        "path": str(path),
    }


def format_value(value) -> str:
    if value is None:
        return "NA"
    if isinstance(value, float):
        return f"{value:.4f}"
    return str(value)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Summarize persona evaluation outputs from outputs/persona_experiments."
    )
    parser.add_argument(
        "--root",
        type=str,
        default="outputs/persona_experiments",
        help="Root directory containing persona subdirectories with eval_scores.json files",
    )
    parser.add_argument(
        "--sort-by",
        type=str,
        default="combined_score",
        choices=[
            "persona",
            "combined_score",
            "diagnosis_score",
            "recommendation_score",
            "dei",
            "etb",
            "info_model_score",
            "info_precision",
            "avg_turns",
            "avg_tokens",
        ],
        help="Column to sort by",
    )
    parser.add_argument(
        "--descending",
        action="store_true",
        help="Sort in descending order",
    )
    parser.add_argument(
        "--max-turns",
        type=int,
        default=10,
        help="Max dialogue turns used during inference (for early termination bonus calculation)",
    )
    args = parser.parse_args()

    root = Path(args.root)
    files = sorted(root.glob("*/eval_scores.json"))

    if not files:
        print(f"No eval_scores.json files found under {root}")
        return

    rows = [load_average_metrics(path, max_turns=args.max_turns) for path in files]

    if args.sort_by == "persona":
        rows.sort(key=lambda row: row["persona"], reverse=args.descending)
    else:
        rows.sort(
            key=lambda row: (row[args.sort_by] is None, row[args.sort_by]),
            reverse=args.descending,
        )

    headers = [
        "persona",
        "combined_score",
        "diagnosis_score",
        "recommendation_score",
        "dei",
        "etb",
        "info_model_score",
        "info_precision",
        "avg_turns",
        "avg_tokens",
    ]

    widths = {
        header: max(
            len(header),
            max(len(format_value(row[header])) for row in rows),
        )
        for header in headers
    }

    header_line = "  ".join(header.ljust(widths[header]) for header in headers)
    separator = "  ".join("-" * widths[header] for header in headers)

    print(header_line)
    print(separator)
    for row in rows:
        print("  ".join(format_value(row[header]).ljust(widths[header]) for header in headers))


if __name__ == "__main__":
    main()
