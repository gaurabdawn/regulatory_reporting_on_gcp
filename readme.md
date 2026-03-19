🏦 Banking Regulatory Reporting Data Platform (GCP)

## 🏗️ System Architecture

```mermaid
flowchart LR

    A[Kaggle Dataset\n(Czech Financial Data)] --> B[GCS Bucket\nRaw Layer]

    B --> C[BigQuery External Tables\nSchema Validation]

    C --> D[BigQuery Bronze Layer\nRaw Tables]

    D --> E[BigQuery Silver Layer\nCleaned & Standardized]

    E --> F[BigQuery Gold Layer\nRegulatory Reporting]

    F --> G[BI / Analytics / Reporting]

    H[Cloud Composer\n(Airflow DAGs)] --> C
    H --> D
    H --> E
    H --> F

    I[Terraform\n(IaC)] --> B
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
