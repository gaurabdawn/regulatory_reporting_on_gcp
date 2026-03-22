## 🏦 Banking Regulatory Reporting Data Platform | GCP Medallion Architecture

## ⚙️ System Architecture
```mermaid
flowchart TB
    %% ── INGESTION ──────────────────────────────────────
    A([🗄️ Source Systems]) --> B[📨 Pub/Sub]
    B -->|triggers| CF[⚡ Cloud Function\nSubscribe → Transform → Write]
    CF --> C[🪣 GCS Raw Bucket]

    %% ── BIGQUERY MEDALLION ─────────────────────────────
    subgraph BQ["☁️ BigQuery Data Platform"]
        direction LR
        D1[🥉 Bronze\nRaw Ingestion]
        D2[🥈 Silver\nCleaned & Joined]
        D3[🥇 Gold\nBusiness-Ready]
        D1 --> D2 --> D3
    end
    C --> D1

    %% ── SERVING ────────────────────────────────────────
    D3 --> E([📊 Looker Studio\nRegulatory Reporting])

    %% ── ORCHESTRATION ──────────────────────────────────
    subgraph ORC["⚙️ Orchestration"]
        F[🎼 Cloud Composer\nAirflow DAGs]
    end
    F -.->|triggers| C
    F -.->|triggers dbt| D1
    F -.->|triggers dbt| D2
    F -.->|triggers dbt| D3

    %% ── INFRA ──────────────────────────────────────────
    subgraph IaC["🏗️ Infrastructure"]
        H[🔧 Terraform]
    end
    H -.->|provisions| C
    H -.->|provisions| BQ
    H -.->|provisions| ORC
    H -.->|provisions| CF

    %% ── STYLING ────────────────────────────────────────
    classDef ingestion  fill:#e8d5f5,stroke:#7c3aed,color:#3b0764
    classDef functions  fill:#fef9c3,stroke:#ca8a04,color:#713f12
    classDef bronze     fill:#fef3c7,stroke:#d97706,color:#78350f
    classDef silver     fill:#dbeafe,stroke:#2563eb,color:#1e3a8a
    classDef gold       fill:#dcfce7,stroke:#16a34a,color:#14532d
    classDef serving    fill:#ffe4e6,stroke:#e11d48,color:#881337
    classDef orch       fill:#ede9fe,stroke:#7c3aed,color:#3b0764
    classDef infra      fill:#f1f5f9,stroke:#64748b,color:#1e293b

    class A,B,C ingestion
    class CF functions
    class D1 bronze
    class D2 silver
    class D3 gold
    class E serving
    class F orch
    class H infra
```

GCS → Raw data layer

BigQuery → Bronze, Silver, Gold layers

Cloud Composer (Airflow) → Orchestration

Terraform → Infrastructure as Code

## 📊 DATASET

Czech Financial Dataset (Kaggle) https://www.kaggle.com/datasets/mariammariamr/1999-czech-financial-dataset

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
