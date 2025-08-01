terraform {
  backend "gcs" {
    bucket = "dpacg-tf-mastery-state-bucket"
    prefix = "terraform/state"
  }
}
