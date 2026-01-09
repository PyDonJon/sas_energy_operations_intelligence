# sas_energy_operations_intelligence
Data Engineering and Business Intelligence with SAS

# Energy Consumption & Production  
### Data Engineering & Business Intelligence Project

## Project Overview
This project implements an end-to-end **data engineering and business intelligence (BI) pipeline** to analyze energy consumption and production patterns. The goal is to transform raw energy data into analytics-ready datasets, generate descriptive business insights, and produce predictive outputs that support energy trend analysis.

The project was developed using **SAS Studio for Academics**, and the pipeline design explicitly accounts for the platform’s technical constraints.

---

## Tools & Environment
- **Platform:** SAS Studio (OnDemand for Academics)  
- **Language:** Base SAS  
- **Domain:** Energy consumption and production analytics  

Platform limitations (e.g., restricted file system access and limited dataset schema operations) were treated as design constraints and addressed through structured pipeline logic.

---

## Pipeline Architecture
The workflow is implemented as a **modular SAS data pipeline**, with each stage isolated into its own program file:

```
01_import.sas – Data ingestion
02_process.sas – Data cleaning & transformation
03_analyze.sas – Business intelligence & analytics
run_all.sas – Pipeline orchestration
```
## Pipeline Stages

### 1. Data Import
Raw energy datasets are imported into SAS Studio without modification to preserve source integrity.

**Output:** Raw datasets (`raw_*`)

---

### 2. Data Processing
Data is cleaned and standardized for analysis. This includes:
- Converting Excel-style numeric date/time values into valid SAS `DATETIME` variables
- Removing intermediate or obsolete variables after transformation
- Enforcing consistent schemas for downstream analysis

Due to SAS Studio Academics limitations, dataset cleanup is performed using DATA step overwrites rather than `PROC DATASETS`.

**Output:** Analytics-ready datasets (`*_processed`)

---

### 3. Business Intelligence & Analysis
Processed data is used to:
- Generate descriptive statistics
- Analyze temporal patterns in energy consumption and production
- Support business-oriented insights and trend identification

**Output:** Summary tables and analytical insights

---

---

## Data Engineering Principles Applied
- Modular pipeline design  
- Clear separation between raw and processed data  
- Reproducible execution via a master script  
- Explicit handling of data types and schema transformations  
- Consistent naming conventions (`raw_*`, `*_processed`)

---

## Key Outcomes
- Clean, standardized energy datasets  
- Actionable insights into energy consumption and production trends  
- Predictive outputs supporting forward-looking analysis  
- A reproducible SAS-based pipeline aligned with real-world data engineering and BI practices

---

## How to Run
Upload all `.sas` files into the same SAS Studio directory and run `run_all.sas` to execute the full pipeline.

---
