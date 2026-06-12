# Dashboard Design

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Overview

This document describes the design, objectives, KPIs, visualizations, and business questions addressed by the Power BI dashboard suite.

The dashboard solution consists of seven analytical pages designed to support executive reporting, operational analysis, financial monitoring, clinical assessment, geographic analysis, and risk evaluation.

The dashboards consume data directly from the dimensional warehouse using a Star Schema model.

---

# 2. Dashboard Design Principles

The dashboard suite was designed using the following principles:

* Business-focused reporting
* Minimal visual redundancy
* Consistent KPI definitions
* Clear analytical storytelling
* Interactive filtering
* Domain-specific reporting pages
* Efficient use of dashboard space
* Executive-friendly design

---

# 3. Dashboard Navigation

The Power BI solution contains seven dashboard pages.

| Page | Dashboard                 |
| ---- | ------------------------- |
| 1    | Executive Dashboard       |
| 2    | Hospital Analytics        |
| 3    | Patient Analytics         |
| 4    | Clinical Analytics        |
| 5    | Financial Analytics       |
| 6    | Geographic Analytics      |
| 7    | Risk & Severity Analytics |

Navigation is implemented using custom image buttons:

* Home
* Previous Page
* Next Page
* Refresh

---

# 4. Executive Dashboard

## Purpose

Provide a high-level overview of healthcare utilization, financial performance, patient complexity, and demographic distribution.

---

## KPIs

* Total Admissions
* Total Charges
* Total Costs
* Average LOS
* Charge-to-Cost Ratio
* Emergency Admission Rate
* Extreme Severity Rate
* Extreme Mortality Rate

---

## Visualizations

### Top Hospitals by Admissions

Business Question:

Which hospitals contribute the highest patient volume?

---

### Charges vs Costs by Payer

Business Question:

How do financial resources vary across payer categories?

---

### Severity Distribution

Business Question:

What is the overall severity profile of the patient population?

---

### Mortality Risk Distribution

Business Question:

What is the overall mortality risk profile of admissions?

---

### Admissions by Age Group

Business Question:

Which age groups contribute the highest admission volume?

---

# 5. Hospital Analytics

## Purpose

Evaluate hospital performance across utilization, operational efficiency, and financial outcomes.

---

## KPIs

* Total Hospitals
* Total Admissions
* Average LOS
* Charge-to-Cost Ratio

---

## Slicers

* Health Service Area
* Hospital County
* Facility Name

---

## Visualizations

### Average LOS by Hospital

Business Question:

Which hospitals have the longest patient stays?

---

### Top Hospitals by Charge-to-Cost Ratio

Business Question:

Which hospitals demonstrate the highest financial efficiency?

---

### Charges vs Costs by Hospital

Business Question:

How do hospital financial outcomes compare across facilities?

---

### Hospital Detail Table

Metrics:

* Admissions
* Total Charges
* Total Costs
* Average LOS

Purpose:

Provide detailed hospital-level analysis.

---

# 6. Patient Analytics

## Purpose

Analyze healthcare utilization across demographic groups.

---

## KPIs

* Total Admissions
* Average LOS
* Average Charge per Admission
* Average Cost per Admission

---

## Slicers

* Age Group
* Race
* Ethnicity

---

## Visualizations

### Admissions by Age Group and Gender

Business Question:

How do admission patterns vary across age and gender groups?

---

### Charges vs Costs by Age Group

Business Question:

Which age groups consume the most healthcare resources?

---

### Admissions by Ethnicity with Race Breakdown

Business Question:

How do admissions vary across ethnic and racial populations?

---

### Demographic Detail Table

Metrics:

* Admissions
* Total Charges
* Total Costs
* Average LOS

Purpose:

Provide detailed demographic analysis.

---

# 7. Clinical Analytics

## Purpose

Analyze diagnoses, procedures, and clinical resource utilization.

---

## KPIs

* Diagnosis Categories
* Procedure Categories
* Average Charge per Admission
* Average Cost per Admission

---

## Slicers

* Diagnosis Description
* Procedure Description
* Major Diagnostic Category

---

## Visualizations

### Top Diagnosis Categories by Admissions

Business Question:

Which diagnoses drive healthcare utilization?

---

### Charges vs Costs by Diagnosis

Business Question:

Which diagnoses consume the most healthcare resources?

---

### Top Procedure Categories by Admissions

Business Question:

Which procedures are most frequently performed?

---

### Clinical Detail Table

Metrics:

* Admissions
* Total Charges
* Total Costs
* Average LOS

Purpose:

Provide diagnosis-level performance analysis.

---

# 8. Financial Analytics

## Purpose

Evaluate payer performance and financial efficiency.

---

## KPIs

* Total Charges
* Total Costs
* Charge-to-Cost Ratio
* Average Charge per Admission
* Average Cost per Admission

---

## Slicers

* Primary Payer

---

## Visualizations

### Admission Share by Payer

Business Question:

Which payer categories account for the largest share of admissions?

---

### Average Charge and Cost per Admission by Payer

Business Question:

How do resource utilization patterns differ by payer?

---

### Financial Efficiency by Payer

Business Question:

Which payer categories demonstrate the strongest charge-to-cost ratios?

---

### Financial Detail Table

Metrics:

* Admissions
* Total Charges
* Total Costs
* Charge-to-Cost Ratio
* Average Charge per Admission
* Average Cost per Admission

Purpose:

Provide detailed payer-level financial analysis.

---

# 9. Geographic Analytics

## Purpose

Analyze healthcare utilization and financial performance across geographic regions.

---

## KPIs

* Total Admissions
* Health Service Areas
* Hospital Counties
* Average Cost per Admission

---

## Slicers

* Health Service Area
* Hospital County

---

## Visualizations

### Admissions by Health Service Area

Business Question:

Which regions generate the highest patient volume?

---

### Average LOS by Health Service Area

Business Question:

Which regions experience longer inpatient stays?

---

### Admissions by County

Business Question:

Which counties contribute the highest healthcare utilization?

---

### Charges vs Costs by Health Service Area

Business Question:

How do financial outcomes vary across regions?

---

### Geographic Detail Table

Metrics:

* Admissions
* Total Charges
* Total Costs
* Average LOS

Purpose:

Provide detailed regional analysis.

---

# 10. Risk & Severity Analytics

## Purpose

Evaluate clinical complexity, mortality risk, and their impact on healthcare utilization and costs.

---

## KPIs

* Extreme Severity Rate
* Extreme Mortality Rate
* Average LOS
* Charge-to-Cost Ratio

---

## Slicers

* Severity Category
* Mortality Risk
* Medical/Surgical Classification

---

## Visualizations

### Average LOS by Severity

Business Question:

How does severity impact inpatient stay duration?

---

### Average Charge and Cost per Admission by Mortality Risk

Business Question:

How does mortality risk influence resource utilization?

---

### Charges vs Costs by Severity

Business Question:

How does clinical severity impact healthcare spending?

---

### Risk & Severity Detail Table

Metrics:

* Admissions
* Total Charges
* Total Costs
* Average LOS
* Charge-to-Cost Ratio

Purpose:

Provide detailed risk and severity analysis.

---

# 11. Interactivity

All dashboards support interactive filtering through slicers and cross-filtering between visuals.

Users can:

* Filter dashboard content
* Explore specific business segments
* Drill into detailed records through tables
* Navigate between reporting domains

---

# 12. Design Outcomes

The dashboard suite provides analytical coverage across:

* Executive Reporting
* Hospital Performance
* Patient Demographics
* Clinical Utilization
* Financial Performance
* Geographic Analysis
* Risk & Severity Assessment

Each page focuses on a unique analytical domain, minimizing redundancy while maximizing business insight generation.

---

# 13. Summary

The Power BI dashboard suite transforms the dimensional healthcare warehouse into an interactive business intelligence solution capable of supporting executive decision-making, operational monitoring, financial analysis, demographic assessment, clinical evaluation, geographic reporting, and risk analysis.

The design emphasizes clarity, consistency, interactivity, and business value while leveraging the Star Schema architecture implemented within PostgreSQL.
