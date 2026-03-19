## 🏦 Banking Regulatory Reporting Data Platform | GCP Medallion Architecture

## ⚙️ System Architecture
```mermaid
flowchart TB

    %% ----------- INGESTION -----------
    A[Source Systems] --> B[Pub/Sub]
    B --> C[GCS Raw Bucket]

    %% ----------- BIGQUERY MEDALLION -----------
    subgraph D[BigQuery Data Platform]
        D1[Bronze Layer]
        D2[Silver Layer]
        D3[Gold Layer]

        D1 --> D2 --> D3
    end

    C --> D1

    %% ----------- SERVING -----------
    D3 --> E[Looker Studio Reporting]

    %% ----------- ORCHESTRATION -----------
    F[Cloud Composer Airflow] --> C
    F --> D1
    F --> D2
    F --> D3

    %% ----------- GOVERNANCE -----------
    G[Data Quality Checks] --> D1
    G --> D2
    G --> D3

    %% ----------- INFRA -----------
    H[Terraform IaC] --> C
    H --> D
    H --> F
```

GCS → Raw data layer
BigQuery → Bronze, Silver, Gold layers
Cloud Composer (Airflow) → Orchestration
Terraform → Infrastructure as Code

## 📊 DATASET

Czech Financial Dataset (Kaggle)

Banking domain: accounts, transactions, loans, clients

## ✨ KEY FEATURES

Medallion Architecture (Bronze → Silver → Gold)

External Table → Raw Table ingestion pattern

Partitioned BigQuery tables

Data Quality Checks

Regulatory Reporting Layer

## 🔄 PIPELINE

```mermaid
flowchart LR
    A[Data Ingestion] --> B[GCS Raw Layer]
    B --> C[External Table Validation]
    C --> D[Bronze Layer]
    D --> E[Silver Layer]
    E --> F[Gold Reporting]
```

## 🛠️  TECH STACK

Cloud: GCP (BigQuery, GCS, Composer)

Infrastructure: Terraform

Processing: SQL

Orchestration: Airflow

Language: Python
