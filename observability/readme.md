# 📊 Observability Layer – GCP Data Ingestion Pipeline

## 🔷 Overview

This module implements **end-to-end observability** for the ingestion pipeline:

```
Pub/Sub → Cloud Function → GCS
```

It enables:

* 📈 Monitoring (metrics)
* 🚨 Alerting (failures, no data)
* 📊 Dashboard (system visibility)

---

## 🧱 Architecture

```
Logs → Log-based Metrics → Alert Policies → Dashboard
```


## 🔷 3. Create Log-based Metrics

> ⚠️ For Gen2 functions, use `cloud_run_revision`

### ✅ Success Metric

```bash
gcloud logging metrics create cf_success \
  --description="Successful ingestion" \
  --log-filter='resource.type="cloud_run_revision" AND textPayload:"SUCCESS:"'
```

---

### ❌ Error Metric

```bash
gcloud logging metrics create cf_ingestion_error \
  --description="Ingestion errors" \
  --log-filter='resource.type="cloud_run_revision" AND textPayload:"ERROR:"'
```

---

### 📩 Pub/Sub Publish Metric

```bash
gcloud logging metrics create ingestion_pubsub_publish \
  --description="Messages published" \
  --log-filter='resource.type="pubsub_topic" AND protoPayload.methodName="google.pubsub.v1.Publisher.Publish"'
```

---

## 🔷 4. Create Alert Policies

Use JSON-based policy creation.

---

### 🚨 Cloud Function Error Alert

`alert-cf-error.json`

```json
{
  "displayName": "CF Errors Alert",
  "conditions": [
    {
      "displayName": "Errors > 0",
      "conditionThreshold": {
        "filter": "metric.type=\"logging.googleapis.com/user/cf_ingestion_error\" AND resource.type=\"cloud_run_revision\"",
        "comparison": "COMPARISON_GT",
        "thresholdValue": 0,
        "duration": "0s",
        "aggregations": [
          {
            "alignmentPeriod": "60s",
            "perSeriesAligner": "ALIGN_SUM"
          }
        ]
      }
    }
  ],
  "combiner": "OR",
  "notificationChannels": [
    "projects/reg-reporting-490417/notificationChannels/CHANNEL_ID"
  ]
}
```

---

### 🚨 No Success Alert (Pipeline Stuck)

```json
{
  "displayName": "No Ingestion Success",
  "conditions": [
    {
      "displayName": "No success in 15 mins",
      "conditionThreshold": {
        "filter": "metric.type=\"logging.googleapis.com/user/cf_success\" AND resource.type=\"cloud_run_revision\"",
        "comparison": "COMPARISON_LT",
        "thresholdValue": 1,
        "duration": "900s"
      }
    }
  ],
  "combiner": "OR",
  "notificationChannels": [
    "projects/reg-reporting-490417/notificationChannels/CHANNEL_ID"
  ]
}
```

---

## 🔷 5. Create Alerts via CLI

```bash
gcloud alpha monitoring policies create \
  --policy-from-file=alert-cf-error.json
```

---

## 🔷 6. Verify Metrics

Go to:

```
Monitoring → Metrics Explorer
```

Search:

* `cf_success`
* `cf_ingestion_error`
* `ingestion_pubsub_publish`

---

## 🔷 7. Build Dashboard

Create dashboard:

```
Monitoring → Dashboards → Create
```

### 📊 Recommended Widgets

| Widget           | Metric                   |
| ---------------- | ------------------------ |
| Pub/Sub Activity | ingestion_pubsub_publish |
| Success Count    | cf_success               |
| Error Count      | cf_ingestion_error       |
| Backlog          | pubsub num_undelivered   |

---

## 🔷 8. Testing

### ✅ Success

```bash
gcloud pubsub topics publish dev-ingestion-topic \
  --message='{"file_name":"test.csv","content":"Y29sMSxjb2wyCjEsMg=="}'
```

---

### ❌ Failure

```bash
gcloud pubsub topics publish dev-ingestion-topic --message="bad"
```

---

## 🔷 Key Learnings

* Gen2 Functions use `cloud_run_revision`
* Metrics depend on **exact log matching**
* Alerts require:

  * correct metric
  * correct resource type
  * correct duration

---

## 🔷 Final Outcome

✔ End-to-end visibility
✔ Real-time alerting
✔ Root cause identification

