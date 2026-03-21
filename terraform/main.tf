# ---------------------------
# Enable APIs
# ---------------------------
resource "google_project_service" "services" {
  for_each = toset([
    "storage.googleapis.com",
    "bigquery.googleapis.com",
    "pubsub.googleapis.com"
  ])
  service = each.key
}

# ---------------------------
# GCS (Raw Layer)
# ---------------------------
resource "google_storage_bucket" "raw" {
  name     = "${var.project_id}-${var.env}-raw"
  location = var.region

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

# ---------------------------
# BigQuery (Medallion)
# ---------------------------
resource "google_bigquery_dataset" "bronze" {
  dataset_id = "${var.env}_bronze"
  location   = var.region
}

resource "google_bigquery_dataset" "silver" {
  dataset_id = "${var.env}_silver"
  location   = var.region
}

resource "google_bigquery_dataset" "gold" {
  dataset_id = "${var.env}_gold"
  location   = var.region
}

# ---------------------------
# Pub/Sub (Ingestion)
# ---------------------------
resource "google_pubsub_topic" "ingestion" {
  name = "${var.env}-ingestion-topic"
}

resource "google_pubsub_subscription" "sub" {
  name  = "${var.env}-ingestion-sub"
  topic = google_pubsub_topic.ingestion.name
}

# ---------------------------
# Composer
# ---------------------------
# resource "google_composer_environment" "composer" {
#   name   = "${var.env}-composer"
#   region = var.region
#
#   config {
#     node_count = 3
#
#     software_config {
#       image_version = "composer-2-airflow-2.6.3"
#     }
#   }
# }