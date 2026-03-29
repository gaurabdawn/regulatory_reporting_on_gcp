## 🏦 Banking Regulatory Reporting Data Platform | GCP Medallion Architecture

## ⚙️ System Architecture

```mermaid
flowchart TB
    %% ── INGESTION ──────────────────────────────────────
    A([🗄️ Source Systems\nDatabases, APIs]) --> B[📨 Pub/Sub\nMessage broker]
    B --> CF[⚡ Cloud Function\nSubscribe → Transform → Write]
    CF --> C[🪣 GCS Raw Bucket]

    %% ── BIGQUERY MEDALLION ─────────────────────────────
    subgraph BQ["☁️ BigQuery — Medallion"]
        direction LR
        D1[🥉 Bronze\nRaw ingestion]
        D2[🥈 Silver\nCleaned & joined]
        D3[🥇 Gold\nBusiness-ready]
        D1 --> D2 --> D3
    end
    C --> D1

    %% ── SERVING ────────────────────────────────────────
    D3 --> E([📊 Looker Studio\nRegulatory reporting])

    %% ── ORCHESTRATION ──────────────────────────────────
    subgraph ORC["⚙️ Orchestration"]
        F[🎼 Cloud Composer\nAirflow DAGs]
    end
    F -.->|triggers dbt| D1
    F -.->|triggers dbt| D2
    F -.->|triggers dbt| D3
    F -.->|triggers| C

    %% ── OBSERVABILITY ──────────────────────────────────
    subgraph OBS["📊 Observability"]
        direction LR
        L[🪵 Cloud Logging\nAll pipeline events] --> M[📈 Log-based metrics\nDerived signals]
        M --> A1[🚨 Alert policies\nThreshold notifications]
        M -.-> DSH[📊 Dashboard\nReal-time visibility]
    end
    CF --> L
    B --> L
    C --> L
    D1 --> L
    D2 --> L
    D3 --> L

    %% ── INFRASTRUCTURE ─────────────────────────────────
    subgraph IaC["🏗️ Infrastructure"]
        H[🔧 Terraform\nProvisions all resources]
    end
    H -.->|provisions| B
    H -.->|provisions| BQ
    H -.->|provisions| ORC
    H -.->|provisions| C
    H -.->|provisions| OBS

    %% ── STYLING ────────────────────────────────────────
    classDef ingestion  fill:#ede9fe,stroke:#7c3aed,color:#3b0764
    classDef functions  fill:#fef9c3,stroke:#ca8a04,color:#713f12
    classDef bronze     fill:#fef3c7,stroke:#d97706,color:#78350f
    classDef silver     fill:#dbeafe,stroke:#2563eb,color:#1e3a8a
    classDef gold       fill:#dcfce7,stroke:#16a34a,color:#14532d
    classDef serving    fill:#ffe4e6,stroke:#e11d48,color:#881337
    classDef orch       fill:#ede9fe,stroke:#7c3aed,color:#3b0764
    classDef infra      fill:#f1f5f9,stroke:#64748b,color:#1e293b
    classDef observ     fill:#ecfeff,stroke:#0891b2,color:#0c4a6e

    class A,B,C ingestion
    class CF functions
    class D1 bronze
    class D2 silver
    class D3 gold
    class E serving
    class F orch
    class H infra
    class L,M,A1,DSH observ
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
