## 🏦 Banking Regulatory Reporting Data Platform (GCP)

## 🏗️ System Architecture
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

## ⚙️ ARCHITECTURE

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

## 🔄 PIPELINE FLOW

Data ingestion → GCS

External table validation

Bronze layer load

Silver transformation

Gold reporting

## 🛠️  TECH STACK

Cloud: GCP (BigQuery, GCS, Composer)

Infrastructure: Terraform

Processing: SQL

Orchestration: Airflow

Language: Python
