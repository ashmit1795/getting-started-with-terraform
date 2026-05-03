# 🚀 Getting Started with Terraform

A hands-on learning repository documenting my journey with Terraform as part of a **DevOps course (Day 16+)**. This repo covers Infrastructure as Code concepts, practical AWS resource provisioning, remote state management, and real errors encountered along the way.

---

## 📁 Repository Structure

```
.
├── provider.tf            # AWS provider configuration
├── variables.tf           # Input variable declarations
├── terraform.tfvars       # Actual variable values (not committed if sensitive)
├── main.tf                # Core resources — EC2, DynamoDB
├── outputs.tf             # Output values after apply
├── backend.tf             # Remote state backend — S3
└── .terraform.lock.hcl    # Provider version lock file (always committed)
```

---

## 📚 What I Learned

### 1. Infrastructure as Code (IaC)
Instead of manually clicking through the AWS Console, infrastructure is defined as code — repeatable, version-controlled, and auditable.

### 2. Core Terraform Workflow
```bash
terraform init      # Download providers, set up backend
terraform validate  # Check for syntax errors
terraform plan      # Dry run — see what WILL happen
terraform apply     # Actually create/update resources
terraform destroy   # Tear down resources
```

### 3. Terraform Block Types
| Block | Purpose |
|---|---|
| `terraform` | Configure Terraform itself and backend |
| `provider` | Configure which cloud and credentials |
| `resource` | **Create** infrastructure |
| `data` | **Read** existing infrastructure (no creation) |
| `variable` | Accept input values |
| `output` | Expose values to terminal or other modules |
| `locals` | Reuse computed values within codebase |
| `module` | Reuse groups of resources |

### 4. Remote State with S3
State file is stored remotely in an S3 bucket instead of locally — prevents loss, enables team collaboration.

```hcl
terraform {
  backend "s3" {
    bucket       = "my-terraform-state-bucket"
    key          = "dev/ec2/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true   # S3-native locking (provider v6+)
    encrypt      = true
  }
}
```

### 5. State Locking — Old vs New
| Approach | How |
|---|---|
| Old (provider v5 and below) | S3 + DynamoDB table with `LockID` key |
| New (provider v6+) | S3 only — `use_lockfile = true` creates a `.tflock` file |

---

## ⚠️ Real Errors Encountered

**`permission denied` on state file**
Caused by running `sudo terraform apply` previously. Fix: `sudo chown -R ubuntu:ubuntu /home/ubuntu/terraform/`. Never use `sudo` with Terraform.

**`Missing the key UserID in the item`**
Pointed the backend's `dynamodb_table` at the practice table (which had `UserID` as key). The lock table must have `LockID` as its partition key — it is a dedicated resource, not a general-purpose table.

**`dynamodb_table` deprecated warning**
AWS provider v6 replaced `dynamodb_table` with `use_lockfile = true`. Always check provider version docs when upgrading.

---

## 🗂️ What NOT to Commit

```gitignore
terraform.tfstate        # Contains sensitive infrastructure data
terraform.tfstate.backup # Same
.terraform/              # Auto-generated provider plugins
*.tfvars                 # May contain secrets
```

`.terraform.lock.hcl` **should** be committed — it locks provider versions like `package-lock.json`.

---

## 🛠️ Resources Provisioned

- **EC2 Instance** — Amazon Linux 2023, `t2.micro`, `ap-south-1`
- **DynamoDB Table** — `PAY_PER_REQUEST` billing, `UserID` partition key (practice)

---

## 📖 References

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
