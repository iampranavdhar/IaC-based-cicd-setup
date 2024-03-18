terraform {
    backend "gcs" {
        bucket  = "tf-prac-proj-state-bucket"
        prefix  = "terraform/state"
    }
}