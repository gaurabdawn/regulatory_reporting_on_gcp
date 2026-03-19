🏦 Banking Regulatory Reporting Data Platform (GCP)

## 🏗️ System Architecture
```mermaid
flowchart LR
A[Kaggle Dataset] --> B[GCS Raw Layer]
B --> C[External Tables]
C --> D[Bronze Layer]
D --> E[Silver Layer]
E --> F[Gold Layer]
F --> G[Reporting]

H[Airflow Composer] --> C
H --> D
H --> E
H --> F

I[Terraform] --> B
I --> D
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
