🏦 Banking Regulatory Reporting Data Platform (GCP)

## 🏗️ System Architecture
```mermaid
flowchart LR
    A[Kaggle Dataset] --> B[GCS Raw Layer]

    B --> C[Pub/Sub Ingestion]
    C --> D[BigQuery Bronze Layer]
    D --> E[BigQuery Silver Layer]
    E --> F[BigQuery Gold Layer]

    F --> G[Looker Studio Reporting]

    H[Cloud Composer Airflow] --> B
    H --> D
    H --> E
    H --> F

    I[Terraform IaC] --> B
    I --> D
    I --> E
    I --> F
    I --> H
```

## 🔷 ARCHITECTURE

GCS → Raw data layer

BigQuery → Bronze, Silver, Gold layers

Cloud Composer (Airflow) → Orchestration

Terraform → Infrastructure as Code

## 🔷 DATASET

Czech Financial Dataset (Kaggle)

Banking domain: accounts, transactions, loans, clients

## 🔷 KEY FEATURES

Medallion Architecture (Bronze → Silver → Gold)

External Table → Raw Table ingestion pattern

Partitioned BigQuery tables

Data Quality Checks

Regulatory Reporting Layer

## 🔷 PIPELINE FLOW

Data ingestion → GCS

External table validation

Bronze layer load

Silver transformation

Gold reporting

## 🔷 TECH STACK

Cloud: GCP (BigQuery, GCS, Composer)

Infrastructure: Terraform

Processing: SQL

Orchestration: Airflow

Language: Python
