terraform {
    backend "s3" {
        bucket         = "my-terraform-state-bucket-ashmit"
        key            = "dev/ec2/terraform.tfstate"
        region         = "ap-south-1"
        use_lockfile   = true
        encrypt        = true
    }
}