# KPI Definitions

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document defines the Key Performance Indicators (KPIs) used throughout the Healthcare Analytics & Business Intelligence System.

The KPIs are used across Power BI dashboards, SQL analytics, and business reporting to provide consistent performance measurement across hospital operations, patient demographics, clinical outcomes, financial performance, geographic utilization, and risk analysis.

All KPI calculations are derived from the dimensional warehouse model centered around:

```text
warehouse.fact_discharge
```

---

# 2. Executive Dashboard KPIs

## Total Admissions

### Definition

Total number of inpatient discharge records.

### Business Purpose

Measures overall healthcare utilization and patient volume.

### Formula

```text
SUM(admission_count)
```

---

## Total Charges

### Definition

Total billed charges for inpatient services.

### Business Purpose

Measures overall healthcare revenue generation.

### Formula

```text
SUM(total_charges)
```

---

## Total Costs

### Definition

Total estimated costs incurred by hospitals.

### Business Purpose

Measures healthcare resource consumption.

### Formula

```text
SUM(total_costs)
```

---

## Average Length of Stay (LOS)

### Definition

Average number of inpatient days per discharge.

### Business Purpose

Measures operational efficiency and patient complexity.

### Formula

```text
AVG(length_of_stay_days)
```

---

## Charge-to-Cost Ratio

### Definition

Relationship between hospital charges and estimated costs.

### Business Purpose

Measures financial efficiency.

### Formula

```text
SUM(total_charges) / SUM(total_costs)
```

---

## Emergency Admission Rate

### Definition

Percentage of admissions arriving through the Emergency Department.

### Business Purpose

Measures hospital dependence on emergency services.

### Formula

```text
(Emergency Admissions / Total Admissions) × 100
```

---

## Extreme Severity Rate

### Definition

Percentage of admissions classified as Extreme Severity.

### Business Purpose

Measures prevalence of highly complex patient cases.

### Formula

```text
(Extreme Severity Admissions / Total Admissions) × 100
```

---

## Extreme Mortality Rate

### Definition

Percentage of admissions classified as Extreme Mortality Risk.

### Business Purpose

Measures prevalence of critically high-risk patients.

### Formula

```text
(Extreme Mortality Admissions / Total Admissions) × 100
```

---

# 3. Hospital Analytics KPIs

## Total Hospitals

### Definition

Total distinct hospitals in the warehouse.

### Business Purpose

Measures reporting coverage across healthcare facilities.

### Formula

```text
DISTINCTCOUNT(facility_id)
```

---

## Total Admissions

### Definition

Total inpatient admissions across hospitals.

### Business Purpose

Measures hospital utilization.

### Formula

```text
SUM(admission_count)
```

---

## Average LOS

### Definition

Average patient length of stay.

### Business Purpose

Measures hospital operational efficiency.

### Formula

```text
AVG(length_of_stay_days)
```

---

## Average Charge per Admission

### Definition

Average charges generated per admission.

### Business Purpose

Measures revenue intensity.

### Formula

```text
SUM(total_charges) / SUM(admission_count)
```

---

## Charge-to-Cost Ratio

### Definition

Ratio between charges and costs.

### Business Purpose

Measures financial efficiency across hospitals.

### Formula

```text
SUM(total_charges) / SUM(total_costs)
```

---

# 4. Patient Analytics KPIs

## Total Admissions

### Definition

Total admissions across patient populations.

### Formula

```text
SUM(admission_count)
```

---

## Average LOS

### Definition

Average length of stay by demographic group.

### Formula

```text
AVG(length_of_stay_days)
```

---

## Average Charge per Admission

### Definition

Average charge generated per admission.

### Formula

```text
SUM(total_charges) / SUM(admission_count)
```

---

## Average Cost per Admission

### Definition

Average cost incurred per admission.

### Formula

```text
SUM(total_costs) / SUM(admission_count)
```

---

# 5. Clinical Analytics KPIs

## Diagnosis Categories

### Definition

Total distinct diagnosis categories available for analysis.

### Formula

```text
DISTINCTCOUNT(ccsr_diagnosis_code)
```

---

## Procedure Categories

### Definition

Total distinct procedure categories available for analysis.

### Formula

```text
DISTINCTCOUNT(ccsr_procedure_code)
```

---

## Average Charge per Admission

### Definition

Average charges generated per clinical encounter.

### Formula

```text
SUM(total_charges) / SUM(admission_count)
```

---

## Average Cost per Admission

### Definition

Average costs incurred per clinical encounter.

### Formula

```text
SUM(total_costs) / SUM(admission_count)
```

---

# 6. Financial Analytics KPIs

## Total Charges

### Definition

Total billed healthcare charges.

### Formula

```text
SUM(total_charges)
```

---

## Total Costs

### Definition

Total estimated healthcare costs.

### Formula

```text
SUM(total_costs)
```

---

## Charge-to-Cost Ratio

### Definition

Financial efficiency ratio.

### Formula

```text
SUM(total_charges) / SUM(total_costs)
```

---

## Average Charge per Admission

### Definition

Average charge generated per admission.

### Formula

```text
SUM(total_charges) / SUM(admission_count)
```

---

## Average Cost per Admission

### Definition

Average cost incurred per admission.

### Formula

```text
SUM(total_costs) / SUM(admission_count)
```

---

# 7. Geographic Analytics KPIs

## Total Admissions

### Definition

Total admissions across geographic regions.

### Formula

```text
SUM(admission_count)
```

---

## Health Service Areas

### Definition

Total distinct Health Service Areas represented in the warehouse.

### Formula

```text
DISTINCTCOUNT(health_service_area)
```

---

## Hospital Counties

### Definition

Total distinct counties represented in the warehouse.

### Formula

```text
DISTINCTCOUNT(hospital_county)
```

---

## Average Cost per Admission

### Definition

Average healthcare cost per admission across geographic regions.

### Formula

```text
SUM(total_costs) / SUM(admission_count)
```

---

# 8. Risk & Severity Analytics KPIs

## Extreme Severity Rate

### Definition

Percentage of admissions classified as Extreme Severity.

### Formula

```text
(Extreme Severity Admissions / Total Admissions) × 100
```

---

## Extreme Mortality Rate

### Definition

Percentage of admissions classified as Extreme Mortality Risk.

### Formula

```text
(Extreme Mortality Admissions / Total Admissions) × 100
```

---

## Average LOS

### Definition

Average inpatient stay by severity category.

### Formula

```text
AVG(length_of_stay_days)
```

---

## Charge-to-Cost Ratio

### Definition

Financial efficiency ratio by severity category.

### Formula

```text
SUM(total_charges) / SUM(total_costs)
```

---

# 9. KPI Governance

All KPIs are calculated dynamically from the dimensional warehouse and are not physically stored.

KPI calculations are standardized across:

* Power BI Dashboards
* SQL Analytics
* Reporting Views
* Business Insights

This approach ensures consistency, transparency, and reproducibility across all reporting layers.

---

# 10. Summary

The KPI framework provides a standardized method for evaluating healthcare performance across operational, financial, demographic, clinical, geographic, and risk domains.

These KPIs serve as the foundation for Power BI dashboards, SQL reporting, and business insight generation throughout the Healthcare Analytics & Business Intelligence System.
