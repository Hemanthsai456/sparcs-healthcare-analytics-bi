# Business Requirements Document (BRD)

## Project Title

**Healthcare Analytics & Business Intelligence System Using New York SPARCS Hospital Inpatient Discharge Data**

---

# 1. Executive Summary

Healthcare organizations generate millions of inpatient discharge records that contain valuable information related to hospital utilization, patient demographics, clinical outcomes, financial performance, and operational efficiency.

Raw healthcare datasets are difficult to analyze directly due to their size, complexity, and lack of business-oriented structure. Decision-makers require a centralized analytics platform capable of transforming healthcare discharge data into meaningful business intelligence.

This project implements a Healthcare Analytics & Business Intelligence System using the New York State SPARCS (Statewide Planning and Research Cooperative System) Hospital Inpatient Discharge dataset.

The solution leverages PostgreSQL, dimensional data modeling, SQL analytics, and Power BI to transform raw healthcare discharge records into actionable insights for business users.

The final platform enables stakeholders to:

* Monitor hospital performance
* Analyze patient demographics
* Evaluate clinical outcomes
* Assess financial performance
* Track operational efficiency
* Identify regional healthcare trends
* Support data-driven decision-making

---

# 2. Business Problem

Healthcare organizations collect large volumes of patient discharge data every year.

Although this data contains valuable information, several challenges limit its usefulness:

* Data exists in raw operational formats
* Reporting processes are fragmented
* Business users require summarized information rather than transaction-level records
* Large datasets are difficult to analyze efficiently
* KPI calculations are often inconsistent across reports
* Stakeholders require insights from multiple business perspectives

Without a centralized analytics platform, organizations face difficulties in:

* Measuring hospital performance
* Understanding patient populations
* Monitoring clinical outcomes
* Evaluating financial efficiency
* Analyzing payer performance
* Identifying geographic healthcare trends
* Improving operational decision-making

---

# 3. Project Objectives

The primary objective of this project is to design and implement a Healthcare Analytics & Business Intelligence System that transforms raw inpatient discharge records into a dimensional data warehouse capable of supporting analytical reporting and business intelligence.

Specific objectives include:

* Build a structured healthcare data warehouse
* Implement a scalable star schema design
* Centralize healthcare discharge data
* Create business-ready analytical assets
* Support KPI-driven reporting
* Enable multidimensional healthcare analysis
* Deliver interactive Power BI dashboards
* Generate actionable business insights
* Demonstrate end-to-end data warehousing and BI capabilities

---

# 4. Business Goals

## Goal 1: Improve Executive Visibility

Provide healthcare leadership with consolidated performance metrics and operational indicators.

Key Areas:

* Admission volume
* Financial performance
* Hospital utilization
* Clinical complexity
* Regional healthcare trends

---

## Goal 2: Enhance Financial Analysis

Enable comprehensive analysis of:

* Total charges
* Total costs
* Payer mix
* Financial efficiency
* Charge-to-cost relationships

---

## Goal 3: Support Clinical Analysis

Provide visibility into:

* Diagnoses
* Procedures
* Severity levels
* Mortality risk
* Patient outcomes

---

## Goal 4: Improve Operational Monitoring

Support monitoring of:

* Admissions
* Emergency utilization
* Length of stay
* Patient disposition
* Resource utilization

---

## Goal 5: Enable Geographic Analysis

Identify healthcare utilization patterns across:

* Health Service Areas
* Counties
* Hospitals
* Regional healthcare systems

---

# 5. Stakeholders

## Executive Leadership

### Interests

* Overall healthcare performance
* Strategic planning
* Capacity management
* Regional healthcare trends
* Organizational performance

---

## Finance Team

### Interests

* Total charges
* Total costs
* Payer analysis
* Financial efficiency
* Revenue distribution

---

## Clinical Leadership

### Interests

* Diagnosis trends
* Procedure utilization
* Severity analysis
* Mortality risk
* Patient outcomes

---

## Operations Team

### Interests

* Admission patterns
* Emergency utilization
* Length of stay
* Resource utilization
* Patient flow analysis

---

## Data & Analytics Teams

### Interests

* Data quality
* Warehouse performance
* Reporting consistency
* KPI standardization
* Business intelligence delivery

---

# 6. Project Scope

## In Scope

### Data Integration

* SPARCS 2024 Hospital Inpatient Discharge dataset
* Data profiling
* Data quality assessment

### Data Warehousing

* PostgreSQL data warehouse
* Staging layer
* Dimension tables
* Fact table
* Star schema implementation

### Analytics

* Executive analytics
* Hospital analytics
* Patient analytics
* Clinical analytics
* Financial analytics
* Geographic analytics
* Operational analytics
* Risk analytics

### Reporting

* SQL business analytics
* KPI reporting
* Power BI dashboards

### Documentation

* Business documentation
* Technical documentation
* Data dictionary
* Data lineage
* Architecture documentation

---

## Out of Scope

The following capabilities are intentionally excluded:

* Real-time data streaming
* Machine learning models
* Predictive healthcare forecasting
* Patient-level identification
* Electronic Health Record integration
* Hospital operational systems
* Clinical decision support systems
* Data governance implementation
* Master data management

---

# 7. Analytical Domains

The solution supports the following analytical domains:

## Executive Analytics

Enterprise-level healthcare performance reporting.

---

## Hospital Analytics

Hospital performance and utilization analysis.

---

## Patient Analytics

Demographic and population analysis.

---

## Clinical Analytics

Diagnosis and procedure analysis.

---

## Financial Analytics

Charges, costs, and payer analysis.

---

## Operational Analytics

Admissions, length of stay, and patient flow analysis.

---

## Geographic Analytics

Regional healthcare utilization analysis.

---

## Risk & Severity Analytics

Severity and mortality risk analysis.

---

# 8. Business Questions Answered

The platform is designed to answer questions such as:

### Executive

* How many admissions occurred?
* What are the total healthcare charges and costs?
* Which hospitals contribute most to healthcare activity?

### Financial

* Which payer groups generate the highest charges?
* Which payer groups generate the highest costs?
* What is the charge-to-cost ratio?

### Clinical

* What diagnoses drive utilization?
* Which diagnoses generate the highest costs?
* Which conditions have the highest mortality risk?

### Operational

* What is the average length of stay?
* How dependent are hospitals on emergency admissions?
* Which facilities have the highest utilization?

### Geographic

* Which regions generate the highest admission volume?
* Which regions incur the highest healthcare costs?

---

# 9. Success Criteria

## Data Warehouse Success

* Complete dimensional warehouse implementation
* Successful fact table loading
* Referential integrity maintained
* Data validation passed

---

## Analytics Success

* Business-ready analytics layer created
* KPI definitions documented
* SQL analytical queries validated

---

## Reporting Success

* Interactive Power BI dashboard suite developed
* Stakeholder-focused reporting implemented
* Business insights documented

---

## Documentation Success

* Complete project documentation delivered
* Data lineage documented
* Architecture documented
* KPI catalog documented

---

# 10. Expected Deliverables

## Technical Deliverables

* PostgreSQL Data Warehouse
* Star Schema Design
* Dimension Tables
* Fact Table
* Analytics Views
* Materialized Views
* SQL Analytics Queries

---

## Reporting Deliverables

* Executive Dashboard
* Hospital Analytics Dashboard
* Patient Analytics Dashboard
* Clinical Analytics Dashboard
* Financial Analytics Dashboard
* Geographic Analytics Dashboard
* Risk & Severity Dashboard

---

## Documentation Deliverables

* BRD
* Data Dictionary
* Data Lineage
* Data Profiling Report
* ETL Process Documentation
* KPI Definitions
* Project Architecture
* Star Schema Documentation
* Dashboard Design Documentation

---

# 11. Expected Outcomes

The completed solution will provide:

* Centralized healthcare analytics platform
* Consistent KPI reporting
* Interactive business intelligence dashboards
* Healthcare performance visibility
* Financial performance insights
* Clinical outcome analysis
* Operational efficiency monitoring
* Portfolio-ready healthcare BI project

---

# 12. Project Summary

The Healthcare Analytics & Business Intelligence System transforms over 2.1 million inpatient discharge records into a scalable dimensional data warehouse and business intelligence platform.

The solution demonstrates end-to-end data warehousing, dimensional modeling, SQL analytics, optimization, and dashboard development capabilities while delivering meaningful healthcare insights across executive, financial, clinical, operational, geographic, and risk domains.
