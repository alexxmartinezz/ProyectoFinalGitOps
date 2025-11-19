terraform {
  backend "s3" {
    bucket       = "alejandro-gitops-bucket"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
