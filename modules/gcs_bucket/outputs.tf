output "storage_bucket_url" {
    description = "The URL of the created GCS bucket."
    value	= google_storage_bucket.learning_bucket.url
}

output "storage_bucket_id" {
    description = "The unique ID of the GCS bucket."
    value	= google_storage_bucket.learning_bucket.id
}


