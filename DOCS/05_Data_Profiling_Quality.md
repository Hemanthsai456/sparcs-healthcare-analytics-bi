# Data Profiling & Data Quality Report

## 1. Overview

Data profiling was performed before warehouse development to understand the structure, quality, and consistency of the SPARCS datasets.

Rather than assuming that datasets from different years were identical, each dataset was validated independently to ensure it could be integrated into a single dimensional warehouse without compromising data quality or warehouse integrity.

The findings from this phase directly influenced the ETL pipeline, Star Schema design, business key selection, and data quality validation strategy.

---

## 2. Datasets Profiled

| Dataset Year | Status |
|--------------|--------|
| 2011 | Profiled |
| 2012 | Profiled |
| 2014 | Profiled |
| 2018 | Profiled |
| 2021 | Profiled |
| 2023 | Profiled |
| 2024 | Profiled |

Total datasets analyzed: **7**

---

## 3. Profiling Objectives

The profiling process focused on answering the following questions:

- Are all supported years structurally compatible?
- Are column names and data types consistent?
- What business entities exist within the source data?
- Which attributes are suitable for dimensional modeling?
- What data quality issues require ETL handling?
- Which fields can serve as reliable business keys?
- What should be the grain of the fact table?

---

## 4. Profiling Activities

The following analyses were performed on each dataset:

### Dataset Structure

- Row count
- Column count
- Data types
- Schema validation

### Data Quality

- Missing value analysis
- Duplicate detection
- Null value assessment
- Invalid value identification

### Cardinality Analysis

- Distinct value counts
- Low-cardinality attributes
- High-cardinality attributes

### Business Key Validation

- Hospital identifier validation
- Dimension uniqueness analysis
- Fact grain validation

### Cross-Year Validation

- Schema comparison
- Data type comparison
- Compatibility assessment

---

## 5. Schema Validation

Each supported dataset was compared against the warehouse source schema before loading.

Validation included:

- Column names
- Column order
- Data types
- Number of columns

Result:

- All seven datasets were compatible with the standardized ETL process.
- Minor source differences were resolved during ETL transformation without requiring warehouse redesign.

This validation allowed a single ETL pipeline to process every supported dataset.

---

## 6. Data Quality Summary

Major observations from the profiling phase included:

- Birth Weight contained a high percentage of missing values.
- Secondary and tertiary payment fields were sparsely populated.
- Procedure information was unavailable for a portion of records.
- Hospital identifiers demonstrated high completeness.
- Demographic attributes were suitable for dimensional modeling.

Rather than imputing missing values, the warehouse preserves source fidelity and handles incomplete dimension values through the Unknown Member strategy.

---

## 7. Business Key Analysis

Multiple candidate business keys were evaluated before warehouse design.

Final selections include:

| Dimension | Business Key |
|-----------|--------------|
| Hospital | Permanent Facility ID |
| Patient | Age Group + Gender + Race + Ethnicity |
| Diagnosis | Diagnosis Code + APR DRG + APR MDC |
| Procedure | Procedure Code |
| Severity | Severity + Mortality Risk + Medical/Surgical |
| Payment | Payment Typologies |
| Admission | Admission Type + Disposition + ED Indicator |
| Date | Discharge Year |

These business keys were used to generate surrogate keys within the dimensional warehouse.

---

## 8. Fact Table Grain Validation

Profiling confirmed that the natural reporting grain is:

> **One inpatient discharge = One fact record**

This grain preserves the full analytical detail of the source system while supporting flexible aggregation across all reporting domains.

---

## 9. Data Quality Decisions

The following implementation decisions were made based on profiling results:

- Preserve raw source data within the staging layer.
- Perform transformations during ETL rather than during ingestion.
- Avoid artificial data imputation.
- Implement surrogate keys across all dimensions.
- Introduce Unknown Member records to preserve referential integrity.
- Validate warehouse integrity after every ETL execution.

---

## 10. Profiling Outcome

The profiling phase confirmed that the publicly available SPARCS datasets could be consolidated into a single dimensional warehouse using a standardized ETL pipeline.

The resulting warehouse integrates seven years of inpatient discharge data while maintaining consistent business definitions, reusable dimensions, and reliable analytical reporting across SQL and Power BI.