# Project Management Scripts

This repository contains shell scripts for project management and data synchronization.

## Scripts

### 1. project-template.sh

A shell script that creates a standardized project structure for bioinformatic projects.

#### Features
- Creates a standardized directory structure with:
  - `data/` (raw and processed)
  - `scripts/`
  - `results/`
  - `notebooks/`
  - `docs/`
  - `logs/`
- Generates README files for project and data directories
- Creates a `.gitignore` file with common patterns
- Optionally initializes a git repository

#### Usage
```bash
./project-template.sh <project-name>
```

Example:
```bash
./project-template.sh my-new-project
```

### 2. rsync_hpc.sh

A shell script for efficient data synchronization between local and HPC environments.

#### Features
- Secure file transfer using rsync
- Preserves file permissions and timestamps
- Handles large datasets efficiently
- Supports incremental updates

## Naming Convention

### File Structure
```
project-root/
├── data/
│   ├── raw/           # Raw sequencing data
│   │   ├── sample_01/
│   │   ├── sample_02/
│   │   └── ...
│   ├── qc/           # Quality control results
│   │   ├── sample_01/
│   │   ├── sample_02/
│   │   └── ...
│   ├── aligned/      # Aligned reads
│   │   ├── sample_01/
│   │   ├── sample_02/
│   │   └── ...
│   └── metadata/     # Sample metadata
├── scripts/
│   ├── 20250713_v1_fastqc.sh
│   ├── 20250713_v1_alignment.sh
│   └── 20250713_v1_variant_calling.sh
├── results/
│   ├── qc/           # Quality control results
│   │   ├── tables/   # QC metrics and statistics
│   │   └── figures/  # QC plots and visualizations
│   ├── alignment/    # Alignment results
│   │   ├── tables/   # Alignment statistics
│   │   └── figures/  # Alignment plots
│   └── variant_calling/  # Variant calling results
│       ├── tables/   # Variant statistics
│       └── figures/  # Variant plots
├── notebooks/
└── docs/
```

### File Naming Rules

#### Scripts
Format: `YYYYMMDD_vX_function.sh`

- `YYYYMMDD`: Date of script creation (e.g., 20250713)
- `vX`: Version number (starts from v1, increments if modified on same day)
- `function`: Brief description of script's purpose

Example: `20250713_v1_fastqc.sh` - FastQC quality control script created on July 13, 2025

#### Data Files
Format: `sample_ID_stage_type.YYYYMMDD`

- `sample_ID`: Unique sample identifier (e.g., sample_01)
- `stage`: Data processing stage (raw, qc, aligned)
- `type`: File type or analysis
- `YYYYMMDD`: Date of data generation

Example: `sample_01_aligned_bam.20250713` - Aligned BAM file for sample 01

#### Results
Format: `sample_ID_analysis_type.YYYYMMDD`

- `sample_ID`: Unique sample identifier
- `analysis`: Type of analysis performed
- `type`: Result file type
- `YYYYMMDD`: Date of analysis

Example: `sample_01_variant_calling_vcf.20250713` - VCF file from variant calling

### Sample Metadata
Format: `sample_metadata.YYYYMMDD`

- Contains metadata for all samples
- Updated with new date when changes occur

Example: `sample_metadata.20250713` - Metadata file created/updated on July 13, 2025

## Requirements
- bash
- git (optional, for git repository initialization)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
