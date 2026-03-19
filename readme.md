🏦 Banking Regulatory Reporting Data Platform (GCP)

## 🏗️ System Architecture

```mermaid
flowchart LR

    A[Kaggle Dataset - Czech Financial Data] --> B[GCS Raw Layer]

    B --> C[BigQuery External Tables]
    C --> D[BigQuery Bronze Raw Tables]
    D --> E[BigQuery Silver Cleaned Layer]
    E --> F[BigQuery Gold Reporting Layer]

    F --> G[BI Analytics Reporting]

    H[Cloud Composer Airflow] --> C
    H --> D
    H --> E
    H --> F

    I[Terraform IaC] --> B
    I --> D
    I --> E
    I --> F
    I --> H

🔷 ARCHITECTURE

GCS → Raw data layer

BigQuery → Bronze, Silver, Gold layers

Cloud Composer (Airflow) → Orchestration

Terraform → Infrastructure as Code

🔷 DATASET

Czech Financial Dataset (Kaggle)

Banking domain: accounts, transactions, loans, clients

🔷 KEY FEATURES

Medallion Architecture (Bronze → Silver → Gold)

External Table → Raw Table ingestion pattern

Partitioned BigQuery tables

Data Quality Checks

Regulatory Reporting Layer

🔷 PIPELINE FLOW

Data ingestion → GCS

External table validation

Bronze layer load

Silver transformation

Gold reporting

🔷 TECH STACK

Cloud: GCP (BigQuery, GCS, Composer)

Infrastructure: Terraform

Processing: SQL

Orchestration: Airflow

Language: Python
