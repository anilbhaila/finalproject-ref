variable "credentials" {
  description = "Path to Google Cloud service account credentials"
  default     = "/terraform/keys/gcp-credentials.json"
}

variable "location" {
  description = "Google Cloud project location"
  default     = "us-south1"
}

variable "project" {
  description = "Google Cloud project ID"
  default     = "dtc-ab-de-2026"
}

variable "region" {
  description = "Google Cloud region"
  default     = "us-south1"
}

variable "bq_dataset_name" {
  description = "BigQuery dataset name"
  default     = "etl_dataset"
}

variable "gcs_bucket_name" {
  description = "Google Cloud Storage bucket name"
  default     = "dtc_project_bucket"
}

variable "gcs_storage_class" {
  description = "Storage class for GCS bucket"
  default     = "STANDARD"
}