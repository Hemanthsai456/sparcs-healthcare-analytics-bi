# KPI Definitions

## 1. Overview

This document defines the Key Performance Indicators (KPIs) used throughout the Healthcare Analytics & Business Intelligence System.

Each KPI has a standardized definition to ensure consistent calculations across SQL analytics, materialized views, and Power BI dashboards.

---

## 2. KPI Summary

| KPI | Category |
|------|----------|
| Total Admissions | Operational |
| Total Charges | Financial |
| Total Costs | Financial |
| Average Length of Stay | Operational |
| Average Charge per Admission | Financial |
| Average Cost per Admission | Financial |
| Charge-to-Cost Ratio | Financial |
| Emergency Admission Rate | Operational |
| Extreme Severity Rate | Clinical |
| Extreme Mortality Rate | Clinical |
| Year-over-Year Admission Growth | Trend |

---

## 3. KPI Definitions

### Total Admissions

**Definition**

Total number of inpatient discharge records.

**Formula**

```
SUM(admission_count)
```

**Business Value**

Measures overall healthcare utilization.

**Used In**

Executive, Hospital, Patient, Geographic, Trends

---

### Total Charges

**Definition**

Total billed charges for inpatient services.

**Formula**

```
SUM(total_charges)
```

**Business Value**

Measures total financial activity.

**Used In**

Executive, Financial, Hospital, Trends

---

### Total Costs

**Definition**

Total estimated treatment costs.

**Formula**

```
SUM(total_costs)
```

**Business Value**

Measures healthcare resource consumption.

**Used In**

Executive, Financial, Hospital, Trends

---

### Average Length of Stay

**Definition**

Average inpatient stay.

**Formula**

```
AVG(length_of_stay_days)
```

**Business Value**

Measures operational efficiency and patient complexity.

**Used In**

Executive, Hospital, Patient, Clinical

---

### Average Charge per Admission

**Definition**

Average billed charge for each admission.

**Formula**

```
SUM(total_charges)
/ SUM(admission_count)
```

**Business Value**

Measures average financial impact per patient.

**Used In**

Financial, Patient, Hospital

---

### Average Cost per Admission

**Definition**

Average estimated treatment cost per admission.

**Formula**

```
SUM(total_costs)
/ SUM(admission_count)
```

**Business Value**

Measures average resource utilization.

**Used In**

Financial, Patient, Hospital

---

### Charge-to-Cost Ratio

**Definition**

Relationship between billed charges and estimated costs.

**Formula**

```
SUM(total_charges)
/ SUM(total_costs)
```

**Business Value**

Measures financial efficiency.

**Used In**

Executive, Financial, Hospital

---

### Emergency Admission Rate

**Definition**

Percentage of admissions originating from the Emergency Department.

**Formula**

```
Emergency Admissions
/
Total Admissions
×100
```

**Business Value**

Measures dependence on emergency services.

**Used In**

Executive

---

### Extreme Severity Rate

**Definition**

Percentage of admissions classified as Extreme Severity.

**Formula**

```
Extreme Severity Admissions
/
Total Admissions
×100
```

**Business Value**

Measures prevalence of highly complex cases.

**Used In**

Executive, Risk & Severity

---

### Extreme Mortality Rate

**Definition**

Percentage of admissions classified as Extreme Mortality Risk.

**Formula**

```
Extreme Mortality Admissions
/
Total Admissions
×100
```

**Business Value**

Measures prevalence of high-risk patient encounters.

**Used In**

Executive, Risk & Severity

---

### Year-over-Year Admission Growth

**Definition**

Percentage change in admissions between available dataset years.

**Formula**

```
(Current Year Admissions
-
Previous Year Admissions)

/

Previous Year Admissions
×100
```

**Business Value**

Measures long-term healthcare utilization trends.

**Used In**

Healthcare Evolution & Trends

---

## 4. KPI Design Principles

All KPIs follow these principles:

- Calculated from the dimensional warehouse.
- Consistent across SQL and Power BI.
- Business-friendly definitions.
- Reusable across multiple reports.
- Calculated dynamically rather than stored in the warehouse.

---

## 5. Summary

The KPI layer provides standardized business metrics used throughout the analytics platform, ensuring consistent reporting regardless of whether the data is accessed through SQL queries, materialized views, or Power BI dashboards.