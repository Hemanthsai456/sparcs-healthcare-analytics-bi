# Business Requirements Document (BRD)

## 1. Business Background

Healthcare organizations generate large volumes of operational, clinical, and financial data through daily patient care activities. While this data contains valuable insights, raw transactional datasets are difficult to analyze directly due to their size, complexity, and lack of a reporting-oriented structure.

The New York State SPARCS (Statewide Planning and Research Cooperative System) dataset provides publicly available de-identified inpatient discharge records that enable healthcare utilization and performance analysis across multiple hospitals and years.

This project transforms raw SPARCS data into a centralized analytical platform designed to support business reporting, operational monitoring, and strategic decision-making.

---

## 2. Problem Statement

The raw SPARCS datasets are designed for data distribution rather than business analytics.

Key challenges include:

- Large volumes of raw records spread across multiple years.
- Repeated and denormalized information.
- Complex SQL required for reporting.
- Inconsistent business logic across analytical queries.
- Limited support for interactive business intelligence.

Without a structured analytical warehouse, answering common healthcare business questions becomes time-consuming and difficult to maintain.

---

## 3. Business Objectives

The project aims to:

- Consolidate multi-year inpatient discharge data into a centralized analytical warehouse.
- Standardize healthcare reporting across operational, financial, clinical, demographic, and geographic domains.
- Enable interactive business intelligence through Power BI dashboards.
- Provide reusable SQL assets for business reporting.
- Support trend analysis across multiple years.
- Demonstrate an industry-style healthcare analytics solution using dimensional modeling.

---

## 4. Project Scope

### Included

- Multi-year healthcare data warehouse.
- Historical healthcare analytics.
- SQL analytical reporting.
- Business intelligence dashboards.
- KPI reporting.
- Performance optimization.
- Documentation.

### Excluded

- Real-time reporting.
- Predictive analytics.
- Clinical decision support.
- Patient-level identification.
- Electronic Health Record (EHR) integration.
- Billing and claims processing.

---

## 5. Stakeholders

| Stakeholder | Business Interest |
|--------------|------------------|
| Hospital Executives | Monitor overall healthcare performance and utilization. |
| Operations Teams | Analyze admissions, patient flow, and resource utilization. |
| Financial Analysts | Evaluate charges, costs, and payer performance. |
| Clinical Analysts | Study diagnosis, procedure, severity, and mortality trends. |
| Public Health Researchers | Explore demographic and geographic healthcare patterns. |

---

## 6. Key Business Questions

The platform is designed to answer questions such as:

- Which hospitals treat the highest number of patients?
- How have admissions changed over time?
- Which diagnoses contribute most to healthcare utilization?
- Which payer groups generate the highest financial impact?
- How does patient severity influence costs and length of stay?
- Which geographic regions experience the greatest healthcare demand?
- How do healthcare trends evolve across multiple years?

---

## 7. Business KPIs

Primary KPIs include:

- Total Admissions
- Total Charges
- Total Costs
- Average Length of Stay
- Average Charge per Admission
- Average Cost per Admission
- Charge-to-Cost Ratio
- Emergency Admission Rate
- Severity Distribution
- Mortality Risk Distribution
- Year-over-Year Admission Growth

Detailed KPI definitions are documented separately in **07_KPI_Definitions.md**.

---

## 8. Expected Business Benefits

The completed platform provides:

- A centralized source for healthcare analytics.
- Consistent KPI calculations across reports.
- Faster access to operational and financial insights.
- Historical trend analysis using seven years of inpatient data.
- Reusable reporting assets for SQL and Power BI.
- A scalable warehouse capable of incorporating future SPARCS releases.

---

## 9. Success Criteria

The project is considered successful when it:

- Successfully integrates seven SPARCS datasets into a single analytical warehouse.
- Maintains data integrity throughout the ETL process.
- Produces consistent results across SQL queries and Power BI dashboards.
- Supports interactive reporting over more than 16 million inpatient discharge records.
- Delivers reusable analytical assets suitable for business reporting and future expansion.