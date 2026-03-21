# Terraform Infrastructure – GCP Data Platform

## 📌 Overview

This Terraform code provisions infrastructure on GCP for a data platform:

* GCS bucket (raw data)
* BigQuery datasets (Bronze, Silver, Gold)
* Pub/Sub 
* Composer

---

## 📁 Files

```
main.tf          → resources (GCS, BigQuery, Pub/Sub)
provider.tf      → GCP connection
versions.tf      → provider version
variables.tf     → input variables
dev.tfvars       → dev environment config
qa.tfvars        → qa environment config
prod.tfvars      → prod environment config
```

---

## 🚀 Run (Dev)

```bash
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

---

## 🔄 Environments

Use different files:

```bash
terraform apply -var-file="qa.tfvars"
terraform apply -var-file="prod.tfvars"
```

---

## ⚠️ Notes

* Resources are created per environment (dev/qa/prod)
* Do not commit `.tfstate` files
* Bucket names must be unique

---
