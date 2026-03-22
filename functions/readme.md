# 📡 Pub/Sub → Cloud Function → GCS Ingestion Pipeline

---

## 📌 Overview

This module implements an **event-driven ingestion pipeline** on GCP:

* Messages are published to **Pub/Sub**
* A **Cloud Function** is triggered
* CSV data is written to a **GCS bucket (raw layer)**

---

## 🧩 Architecture

```text
Publisher → Pub/Sub Topic → Cloud Function → GCS Bucket (Raw Layer)
```

---

## ⚙️ Components

### 📡 Pub/Sub

* Topic: `dev-ingestion-topic`
* Used for sending ingestion events

---

### ⚡ Cloud Function

* Name: `pubsub-to-gcs`
* Runtime: Python 3.10
* Trigger: Pub/Sub topic

---

### 🗄️ GCS Bucket

* Bucket: `reg-reporting-490417-dev-raw`
* Folder: `pub_sub_source_layer/`

---

## 📁 Project Structure

```text
functions/
└── pubsub-to-gcs/
    ├── main.py
    └── requirements.txt
```

---

## 🚀 Setup & Deployment

### 1️⃣ Enable APIs

```bash
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable pubsub.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

---

### 2️⃣ Deploy Cloud Function

```bash
gcloud functions deploy pubsub-to-gcs \
  --runtime python310 \
  --trigger-topic dev-ingestion-topic \
  --entry-point pubsub_to_gcs \
  --region us-central1
```

---

### 3️⃣ Grant Permissions

```bash
gcloud projects add-iam-policy-binding reg-reporting-490417 \
  --member="serviceAccount:reg-reporting-490417@appspot.gserviceaccount.com" \
  --role="roles/storage.objectAdmin"
```

---

## 📨 Message Format

Pub/Sub message must be **valid JSON**:

```json
{
  "file_name": "test.csv",
  "content": "BASE64_ENCODED_CSV"
}
```

---

## 🧪 Test the Pipeline

### Encode CSV

```bash
echo -n "col1,col2\n1,2" | base64
```

---

### Publish Message (Windows CMD)

```bash
gcloud pubsub topics publish dev-ingestion-topic ^
  --message="{\"file_name\":\"test.csv\",\"content\":\"Y29sMSxjb2wyCjEsMg==\"}"
```

---

## ✅ Expected Output

File will be created in GCS:

```text
reg-reporting-490417-dev-raw/
└── pub_sub_source_layer/
    └── test.csv
```

---

