resource "aws_instance" "my_server" {
    ami           = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name        = "MyFirstTerraformServer"
        Environment = "dev"
        ManagedBy   = "Terraform"
    }
}

resource "aws_dynamodb_table" "practice_table" {
    name         = var.dynamodb_table_name
    billing_mode = "PAY_PER_REQUEST"  # No capacity planning needed, pay per use
    hash_key     = "UserID"           # Primary key (Partition key)

    attribute {
        name = "UserID"
        type = "S"    # S = String, N = Number, B = Binary
    }

    tags = {
        Name        = "PracticeTable"
        Environment = "dev"
        ManagedBy   = "Terraform"
    }
}