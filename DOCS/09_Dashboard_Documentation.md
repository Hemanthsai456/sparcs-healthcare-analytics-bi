# Dashboard Documentation

## 1. Overview

The Healthcare Analytics & Business Intelligence System includes eight interactive Power BI dashboard pages designed to support executive reporting and domain-specific healthcare analysis.

The dashboards are built directly on the dimensional warehouse using Power BI Import Mode, ensuring consistent KPI calculations and interactive filtering across all reports.

---

## 2. Dashboard Features

Common features available throughout the dashboard include:

- Interactive slicers
- Cross-filtering between visuals
- Dynamic KPI cards
- Drill-down capable visualizations
- Interactive tables
- Consistent navigation
- Bookmark-based interactions
- Page navigation buttons
- Year-based analysis

Navigation icons use **Power BI Bookmarks** and **Page Navigation** actions to provide a seamless reporting experience.

---

# Dashboard Pages

---

## 3. Executive Dashboard

![Executive Dashboard](../POWERBI/dashboard_images/01_Executive_Dashboard.png)

### Purpose

Provides a high-level summary of operational, financial, and clinical performance across all available years.

### Key KPIs

- Total Admissions
- Total Charges
- Total Costs
- Average Length of Stay
- Charge-to-Cost Ratio
- Emergency Admission Rate
- Extreme Severity Rate
- Extreme Mortality Rate

### Key Visuals

- KPI Cards
- Top Hospitals by Admissions
- Charges vs Costs by Payer
- Severity Distribution
- Mortality Distribution
- Admissions by Age Group

### Filters

- Year

### Business Value

Provides executives with a consolidated overview of healthcare utilization, financial performance, and patient complexity.

---

## 4. Hospital Analytics

![Hospital Analytics](../POWERBI/dashboard_images/02_Hospital_Analytics.png)

### Purpose

Analyzes hospital-level performance and operational efficiency.

### Key KPIs

- Total Hospitals
- Total Admissions
- Average Length of Stay
- Charge-to-Cost Ratio

### Key Visuals

- Average LOS by Hospital
- Top Hospitals by Charge-to-Cost Ratio
- Charges vs Costs by Hospital
- Hospital Performance Table

### Filters

- Year
- Health Service Area
- Hospital County
- Facility Name

### Business Value

Supports benchmarking, operational monitoring, and comparison of hospital performance.

---

## 5. Patient Demographics & Utilization

![Patient Analytics](../POWERBI/dashboard_images/03_Patient_Analytics.png)

### Purpose

Explores healthcare utilization across demographic groups.

### Key KPIs

- Total Admissions
- Average Length of Stay
- Average Charge per Admission
- Average Cost per Admission

### Key Visuals

- Admissions by Age Group & Gender
- Charges vs Costs by Age Group
- Admissions by Ethnicity
- Demographic Summary Table

### Filters

- Year
- Age Group
- Race
- Ethnicity

### Business Value

Helps understand demographic trends and healthcare utilization patterns.

---

## 6. Clinical Analytics

![Clinical Analytics](../POWERBI/dashboard_images/04_Clinical_Analytics.png)

### Purpose

Analyzes diagnosis and procedure distributions across inpatient admissions.

### Key KPIs

- Diagnosis Categories
- Procedure Categories
- Average Charge per Admission
- Average Cost per Admission

### Key Visuals

- Top Diagnosis Categories
- Top Procedure Categories
- Charges vs Costs by Diagnosis
- Clinical Detail Table

### Filters

- Year
- Diagnosis Category
- Procedure Category
- Major Diagnostic Category

### Business Value

Supports clinical reporting by identifying high-volume diagnoses and procedures.

---

## 7. Financial Analytics

![Financial Analytics](../POWERBI/dashboard_images/05_Financial_Analytics.png)

### Purpose

Evaluates healthcare financial performance across payer groups.

### Key KPIs

- Total Charges
- Total Costs
- Charge-to-Cost Ratio
- Average Charge per Admission
- Average Cost per Admission

### Key Visuals

- Admission Share by Payer
- Average Charge vs Cost by Payer
- Financial Efficiency by Payer
- Financial Summary Table

### Filters

- Year

### Business Value

Provides insight into payer mix, financial efficiency, and cost distribution.

---

## 8. Geographical Analytics

![Geographic Analytics](../POWERBI/dashboard_images/06_Geographic_Analytics.png)

### Purpose

Analyzes healthcare utilization across geographic regions.

### Key KPIs

- Total Admissions
- Health Service Areas
- Hospital Counties
- Average Cost per Admission

### Key Visuals

- Admissions by Health Service Area
- Average LOS by Region
- Admissions by County
- Charges vs Costs by Region
- Geographic Summary Table

### Filters

- Year
- Health Service Area
- Hospital County

### Business Value

Supports regional healthcare planning and geographic performance analysis.

---

## 9. Risk & Severity Analytics

![Risk & Severity Analytics](../POWERBI/dashboard_images/07_Risk_Severity_Analytics.png)

### Purpose

Examines patient severity, mortality risk, and treatment complexity.

### Key KPIs

- Extreme Severity Rate
- Extreme Mortality Rate
- Average Length of Stay
- Charge-to-Cost Ratio

### Key Visuals

- Average LOS by Severity
- Charges vs Costs by Mortality Risk
- Charges vs Costs by Severity
- Risk Summary Table

### Filters

- Year
- Medical/Surgical Type
- Severity Category
- Mortality Risk

### Business Value

Helps identify high-risk patient populations and evaluate their impact on healthcare resources.

---

## 10. Healthcare Evolution & Trend Analytics

![Healthcare Evolution & Trends](../POWERBI/dashboard_images/08_Healthcare_Evolution_Trends.png)

### Purpose

Analyzes long-term trends across the seven integrated dataset years.

### Key KPIs

- Total Years
- Admission Change %
- Charge/Cost Change %
- Extreme Severity Change %
- Extreme Mortality Change %

### Key Visuals

- Admissions by Year
- Charges & Costs by Year
- Severity Evolution
- Yearly Trend Summary Table

### Filters

- Year

### Business Value

Provides historical trend analysis, enabling comparison of healthcare utilization, financial performance, and patient complexity over time.

---

## 11. Dashboard Navigation

The reporting interface includes:

- Home navigation
- Previous/Next page navigation
- Dashboard refresh button
- Bookmark-based navigation
- Consistent page layout
- Shared KPI definitions
- Interactive filtering across all visuals

These features provide a consistent and user-friendly analytical experience.

---

## 12. Summary

The Power BI reporting layer transforms the dimensional warehouse into an interactive decision-support platform.

Together, the eight dashboards provide executive, operational, financial, clinical, demographic, geographic, and historical insights while maintaining consistent business definitions across the reporting environment.