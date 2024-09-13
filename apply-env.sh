#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [[ ! -f $INPUT_FILE ]]; then
    echo "Error: Input file $INPUT_FILE does not exist."
    exit 1
fi

function check_env_vars {
    local missing_vars=()

    while read -r var; do
        if [[ -z "${!var}" ]]; then
            missing_vars+=("$var")
        fi
    done < <(grep -oP '\$\{\K[A-Z_][A-Z0-9_]*(?=\})' "$INPUT_FILE")

    if [[ ${#missing_vars[@]} -gt 0 ]]; then
        echo "Error: The following environment variables are missing:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        exit 1
    fi
}

check_env_vars

cp "$INPUT_FILE" "$OUTPUT_FILE"

while IFS='=' read -r var val; do
    if [[ -n $var && -n $val ]]; then
        sed -i "s|\${$var}|$val|g" "$OUTPUT_FILE"
    fi
done < <(env)

echo "Output file $OUTPUT_FILE created with replaced environment variable values."
