# ETL Pipeline & Star Schema

## 1. Overview

The Healthcare Analytics & Business Intelligence System uses a dimensional ETL pipeline to transform raw SPARCS inpatient discharge datasets into a centralized analytical warehouse.

The ETL process follows a layered architecture that separates data ingestion, transformation, warehouse loading, validation, and reporting. This approach improves maintainability, supports multi-year data integration, and enables consistent business reporting across SQL and Power BI.

---

## 2. ETL Architecture

```
SPARCS CSV Dataset

↓

staging.sparcs_raw

↓

Data Quality Validation

↓

Dimension Loading

↓

Fact Loading

↓

Warehouse Validation

↓

Analytics Views

↓

Materialized Views

↓

Power BI
```

---

## 3. Extraction

The extraction phase imports each yearly SPARCS dataset into the staging layer without modifying the source data.

Characteristics:

- One dataset loaded at a time.
- Source files remain unchanged.
- Raw values are preserved.
- Standardized loading process for all supported years.

---

## 4. Transformation

Data transformation occurs during ETL rather than during extraction.

Major transformations include:

- Data type conversion.
- Whitespace removal.
- Blank value standardization.
- Numeric conversion.
- Length of Stay normalization.
- Surrogate key resolution.
- Unknown Member assignment.

---

## 5. Dimension Loading

Dimension tables are refreshed before loading the fact table.

Each execution inserts only previously unseen business entities while preserving existing surrogate keys.

Implemented Dimensions:

- dim_hospital
- dim_patient
- dim_diagnosis
- dim_procedure
- dim_severity
- dim_payment
- dim_admission
- dim_date

---

## 6. Fact Loading

The fact table stores one row per inpatient discharge.

During loading:

- Dimension business keys are resolved.
- Surrogate keys are assigned.
- Measures are populated.
- Referential integrity is maintained.
- ETL timestamps are recorded.

The completed warehouse contains more than **16.3 million inpatient discharge records**.

---

## 7. Unknown Member Strategy

Each dimension contains an Unknown Member record with a surrogate key of **0**.

If a source record cannot be matched to a dimension member, the fact table references the Unknown Member instead of rejecting the record.

Benefits:

- Preserves referential integrity.
- Prevents data loss.
- Simplifies ETL processing.
- Makes unmatched records measurable.

---

## 8. ETL Audit

Each ETL execution records operational metadata including:

- Dataset year
- Source file
- Load start time
- Load end time
- Rows loaded to staging
- Rows loaded to fact
- Current fact table size
- Load status
- Rejected rows
- Error message

This provides basic operational traceability for warehouse loads.

---

## 9. Star Schema

The warehouse follows a Star Schema centered around a single transaction fact table.

```
                 dim_hospital
                      │
dim_patient ── fact_discharge ── dim_diagnosis
                      │
                dim_procedure
                      │
                 dim_severity
                      │
                  dim_payment
                      │
                 dim_admission
                      │
                    dim_date
```

The design minimizes query complexity while supporting flexible analytical reporting.

---

## 10. Design Decisions

The following implementation choices guided the warehouse design:

- Star Schema instead of Third Normal Form.
- Single transaction fact table.
- Surrogate keys across all dimensions.
- Unknown Member strategy.
- Separate staging and warehouse schemas.
- Reusable ETL pipeline for all supported dataset years.
- Direct Power BI integration with the dimensional model.

---

## 11. Incremental Loading Considerations

The ETL pipeline processes one dataset year at a time.

For each execution:

1. Load the selected dataset into staging.
2. Refresh dimensions.
3. Load the corresponding fact records.
4. Validate warehouse integrity.
5. Record ETL audit information.

This approach allows future SPARCS releases to be integrated without redesigning the warehouse.

---

## 12. Summary

The implemented ETL pipeline provides a repeatable process for integrating multi-year healthcare datasets into a centralized dimensional warehouse.

The combination of layered architecture, Star Schema design, surrogate keys, and ETL validation ensures consistent reporting across SQL analytics and Power BI while remaining scalable for future dataset additions.