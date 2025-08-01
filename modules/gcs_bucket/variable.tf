variable "gcp_project_id" {
    type	= string
    description = "The GCP project ID where resources will be deployed."
}

variable "gcp_region" {
    type	= string
    description = "The primary GCP region for provider configuration."
}

variable "bucket_name" {
    type	= string
    description = "The globally unique name for the GCS bucket."
}

variable "bucket_location" {
    type	= string
    description = "The location for the GCS bucket."
}

