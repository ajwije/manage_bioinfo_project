#!/bin/bash

# Usage: ./project-template.sh <project-name>

# === 1. Input Validation ===
if [ -z "$1" ]; then
  echo "❗ Please provide a project name."
  echo "Usage: ./project-template.sh my-project"
  exit 1
fi

PROJECT_NAME=$1
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# === 2. Create Folder Structure ===
echo "📁 Creating directory structure for: $PROJECT_NAME"

# Create basic directories
mkdir -p data/raw
mkdir -p data/processed
mkdir -p scripts
mkdir -p notebooks
mkdir -p docs
mkdir -p logs

# Create results directories with user input
ANALYSIS_STEPS=("qc" "alignment" "variant_calling")

# Ask user for analysis steps
read -p "Enter analysis steps (comma-separated, default: qc,alignment,variant_calling): " USER_STEPS

# If user didn't provide steps, use default
if [ -z "$USER_STEPS" ]; then
    USER_STEPS="qc,alignment,variant_calling"
fi

# Split user input into array
IFS=',' read -r -a ANALYSIS_STEPS <<< "$USER_STEPS"

# Create results directories for each analysis step
echo "
📊 Creating results directories for analysis steps: ${ANALYSIS_STEPS[@]}"
for STEP in "${ANALYSIS_STEPS[@]}"; do
    mkdir -p "results/$STEP/tables"
    mkdir -p "results/$STEP/figures"
    echo "- Created: results/$STEP/tables"
    echo "- Created: results/$STEP/figures"
done

# === 3. Create README Files ===
echo "# $PROJECT_NAME" > README.md
echo "## Data Folder" > data/README.md
echo "- raw/: original, untouched datasets" >> data/README.md
echo "- processed/: cleaned/filtered data used for analysis" >> data/README.md

# === 4. Add .gitignore ===
cat <<EOL > .gitignore
# Ignore raw data and intermediate results
data/raw/
results/
logs/
.Rhistory
.RData
.Rproj.user/
__pycache__/
.ipynb_checkpoints/
*.log
*.tmp
EOL

# === 5. Optional: Initialize Git Repo ===
if command -v git &> /dev/null; then
  git init
  git add .
  git commit -m "Initial commit: project scaffold"
  echo "✅ Git repository initialized."
else
  echo "⚠️ Git not installed. Skipping git init."
fi

echo "✅ Project '$PROJECT_NAME' initialized successfully."
