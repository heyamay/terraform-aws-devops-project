# Terraform AWS VPC & EC2 Project

---

## 🚀 Project Overview

This project demonstrates the provisioning of a robust and scalable AWS infrastructure using **Terraform**. It focuses on creating a custom Virtual Private Cloud (VPC) with public and private subnets, an Internet Gateway (IGW), a NAT Gateway, and deploying EC2 instances (both public-facing and private) within this network. The infrastructure is designed using **Terraform Modules** for reusability and maintainability, with **remote state management on AWS S3** for collaborative development and state locking.

This project was built as a hands-on exercise to master core Terraform concepts and AWS networking essentials.

---

## ✨ Key Features

* **Custom VPC Network**: A fully configured VPC with a CIDR block of `10.0.0.0/16`.
* **Public and Private Subnets**: Creation of distinct subnets across multiple Availability Zones for secure and flexible deployments.
* **Internet Gateway (IGW)**: Enables communication between instances in public subnets and the internet.
* **NAT Gateway**: Allows instances in private subnets to initiate outbound connections to the internet while remaining isolated from inbound connections.
* **EC2 Instance Deployment**:
    * **Public EC2 Instances**: Deployed in public subnets, accessible via SSH and hosting a basic Nginx web server.
    * **Private EC2 Instance**: Deployed in a private subnet, accessible only from within the VPC (e.g., via a public bastion host).
* **Terraform Custom Modules**:
    * `vpc` module: Encapsulates all VPC-related resources (VPC, subnets, IGW, NAT Gateway, route tables).
    * `ec2` module: Manages EC2 instance creation, including security groups and user data.
    * Promotes code reusability and separation of concerns.
* **Remote State Management**: Terraform state is stored securely in an **AWS S3 bucket** with DynamoDB for **state locking**, crucial for team environments.
* **Security Best Practices**:
    * No hardcoded AWS credentials (relies on AWS CLI configuration).
    * `.gitignore` ensures sensitive files (`.tfstate`, `.terraform/`, `credentials`) are not committed to Git.
* **Scalability**: Uses `count` and `for_each` (implicitly via dynamic blocks for security groups) to provision multiple resources efficiently.

---

## 🛠️ Technologies Used

* **Terraform**: Infrastructure as Code tool
* **AWS (Amazon Web Services)**: Cloud Provider
    * VPC (Virtual Private Cloud)
    * EC2 (Elastic Compute Cloud)
    * S3 (Simple Storage Service) for remote state
    * DynamoDB (for state locking)
    * IAM (Identity and Access Management)
* **Bash/Shell Scripting**: For `user_data` to configure EC2 instances (e.g., Nginx installation).
* **Git & GitHub**: Version control and code hosting.

---

## 📂 Project Structure

Bahut khoob! Agar aapne pura project successfully complete kar liya hai, toh ab time hai isse duniya ko dikhane ka! Ek achha GitHub README aapke project ko showcase karne mein bahut help karega.

Aapka project recall karte hain: Aapne Terraform aur AWS ka use karke ek complete VPC network (public/private subnets, IGW, NAT Gateway) aur uske andar EC2 instances (public/private) provision kiye hain. Iske liye aapne custom modules ka use kiya hai, Terraform state ko AWS S3 par manage kiya hai, aur secure practices follow ki hain (like .gitignore).

Yahaan ek proper README.md ka code hai jo aap apne GitHub repository mein use kar sakte hain. Maine isko detailed aur easy-to-understand banaya hai:

Markdown

# Terraform AWS VPC & EC2 Project

---

## 🚀 Project Overview

This project demonstrates the provisioning of a robust and scalable AWS infrastructure using **Terraform**. It focuses on creating a custom Virtual Private Cloud (VPC) with public and private subnets, an Internet Gateway (IGW), a NAT Gateway, and deploying EC2 instances (both public-facing and private) within this network. The infrastructure is designed using **Terraform Modules** for reusability and maintainability, with **remote state management on AWS S3** for collaborative development and state locking.

This project was built as a hands-on exercise to master core Terraform concepts and AWS networking essentials.

---

## ✨ Key Features

* **Custom VPC Network**: A fully configured VPC with a CIDR block of `10.0.0.0/16`.
* **Public and Private Subnets**: Creation of distinct subnets across multiple Availability Zones for secure and flexible deployments.
* **Internet Gateway (IGW)**: Enables communication between instances in public subnets and the internet.
* **NAT Gateway**: Allows instances in private subnets to initiate outbound connections to the internet while remaining isolated from inbound connections.
* **EC2 Instance Deployment**:
    * **Public EC2 Instances**: Deployed in public subnets, accessible via SSH and hosting a basic Nginx web server.
    * **Private EC2 Instance**: Deployed in a private subnet, accessible only from within the VPC (e.g., via a public bastion host).
* **Terraform Custom Modules**:
    * `vpc` module: Encapsulates all VPC-related resources (VPC, subnets, IGW, NAT Gateway, route tables).
    * `ec2` module: Manages EC2 instance creation, including security groups and user data.
    * Promotes code reusability and separation of concerns.
* **Remote State Management**: Terraform state is stored securely in an **AWS S3 bucket** with DynamoDB for **state locking**, crucial for team environments.
* **Security Best Practices**:
    * No hardcoded AWS credentials (relies on AWS CLI configuration).
    * `.gitignore` ensures sensitive files (`.tfstate`, `.terraform/`, `credentials`) are not committed to Git.
* **Scalability**: Uses `count` and `for_each` (implicitly via dynamic blocks for security groups) to provision multiple resources efficiently.

---

## 🛠️ Technologies Used

* **Terraform**: Infrastructure as Code tool
* **AWS (Amazon Web Services)**: Cloud Provider
    * VPC (Virtual Private Cloud)
    * EC2 (Elastic Compute Cloud)
    * S3 (Simple Storage Service) for remote state
    * DynamoDB (for state locking)
    * IAM (Identity and Access Management)
* **Bash/Shell Scripting**: For `user_data` to configure EC2 instances (e.g., Nginx installation).
* **Git & GitHub**: Version control and code hosting.

---

## 📂 Project Structure

terraform-aws-project/
├── modules/
│   ├── vpc/
│   │   ├── main.tf             # Defines VPC resources
│   │   ├── variables.tf        # Input variables for VPC module
│   │   └── outputs.tf          # Outputs from VPC module
│   └── ec2/
│       ├── main.tf             # Defines EC2 and Security Group resources
│       ├── variables.tf        # Input variables for EC2 module
│       └── outputs.tf          # Outputs from EC2 module
├── main.tf                     # Root module: Calls VPC and EC2 modules, defines backend
├── variables.tf                # Root module: Top-level variables
├── outputs.tf                  # Root module: Top-level outputs from module calls
└── .gitignore                  # Specifies files to ignore in Git

---

## 🚀 Getting Started

Follow these steps to set up and provision the infrastructure on your AWS account.

### Prerequisites

* **AWS Account**: An active AWS account.
* **AWS CLI Configured**: Ensure your AWS CLI is configured with appropriate credentials and default region (`ap-south-1`).
    ```bash
    aws configure
    ```
    (Enter your Access Key ID, Secret Access Key, `ap-south-1` for region, and `json` for output format.)
* **Terraform Installed**: Terraform (v1.0+) installed on your local machine (e.g., WSL for Windows users).
* **SSH Key Pair**: An SSH key pair named `my-ssh-key` (or your preferred name) must exist in your `ap-south-1` AWS region.
    * You can create one via AWS Console (EC2 -> Key Pairs) or AWS CLI:
        ```bash
        aws ec2 create-key-pair --key-name my-ssh-key --query 'KeyMaterial' --output text > my-ssh-key.pem
        chmod 400 my-ssh-key.pem # Ensure proper permissions for SSH
        ```
        (Keep `my-ssh-key.pem` secure and accessible for SSH.)

### Setup Steps

1.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/your-username/terraform-aws-devops-project.git](https://github.com/your-username/terraform-aws-devops-project.git) # Replace with your repo URL
    cd terraform-aws-devops-project
    ```

2.  **Create S3 Bucket for Terraform State**:
    Go to your AWS S3 console in `ap-south-1` region and create a **globally unique** bucket.
    * **Bucket Name**: `your-terraform-state-bucket-unique-name` (e.g., `my-devops-project-tfstate-12345`)
    * **Region**: `ap-south-1`
    * Leave other settings as default.

3.  **Create DynamoDB Table for State Locking (Recommended)**:
    Go to your AWS DynamoDB console in `ap-south-1` region and create a new table.
    * **Table Name**: `your-terraform-lock-table-unique-name` (e.g., `my-devops-project-tf-locks`)
    * **Partition Key**: `LockID` (Type: String)
    * Leave other settings as default.

4.  **Update `main.tf`**:
    Open `main.tf` in the root directory and update the `backend "s3"` block with your actual S3 bucket and DynamoDB table names:
    ```terraform
    # main.tf
    backend "s3" {
      bucket         = "your-terraform-state-bucket-unique-name" # <--- UPDATE THIS
      key            = "terraform-aws-project/terraform.tfstate"
      region         = "ap-south-1"
      encrypt        = true
      dynamodb_table = "your-terraform-lock-table-unique-name" # <--- UPDATE THIS
    }
    ```
    Also, ensure the `ami_id` in `main.tf` (for both `ec2_public` and `ec2_private` modules) is updated with a valid Amazon Linux 2 AMI for `ap-south-1`. You can find it using:
    ```bash
    aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" --query "sort_by(Images, &CreationDate)[-1].ImageId" --region ap-south-1
    ```

### Terraform Workflow

Navigate to the root of the project directory (`terraform-aws-project/`) in your terminal.

1.  **Initialize Terraform**:
    This command downloads the necessary providers and initializes the S3 backend.
    ```bash
    terraform init
    ```

2.  **Format Terraform Code**:
    Ensures consistent formatting across all `.tf` files.
    ```bash
    terraform fmt
    ```

3.  **Validate Terraform Configuration**:
    Checks the configuration for syntax errors and internal consistency.
    ```bash
    terraform validate
    ```

4.  **Review the Plan**:
    This command shows you exactly what Terraform will do to your AWS infrastructure (what resources will be created, modified, or destroyed) without making any changes. **Always review this carefully!**
    ```bash
    terraform plan
    ```

5.  **Apply the Configuration**:
    Executes the planned changes to provision your AWS resources. Type `yes` when prompted to confirm.
    ```bash
    terraform apply
    ```
    This process may take several minutes as resources like NAT Gateway can take time to become available.

---

## ✅ Verification

After `terraform apply` completes:

1.  **AWS Console**: Log in to your AWS console and navigate to the VPC and EC2 dashboards in the `ap-south-1` region.
    * Verify the creation of `devops-project-vpc` with its subnets, Internet Gateway, NAT Gateway, and route tables.
    * Check for `devops-project-public-ec2-1`, `devops-project-public-ec2-2`, and `devops-project-private-ec2-1` instances.
2.  **Access Public EC2**: Copy the Public IP address of a public EC2 instance from the AWS console or using `terraform output public_instance_ips`. Paste it into your web browser. You should see a simple Nginx welcome page, "Hello from Terraform EC2 Instance X!".
3.  **SSH to Public EC2**:
    ```bash
    ssh -i /path/to/my-ssh-key.pem ec2-user@<Public_IP_of_Public_EC2>
    ```
4.  **SSH to Private EC2 (via Public EC2/Bastion)**: First SSH into a public EC2 instance, then from there SSH into the private instance. You'll need your `.pem` key on the public EC2 or use SSH agent forwarding.
    ```bash
    # On your local machine:
    ssh -A -i /path/to/my-ssh-key.pem ec2-user@<Public_IP_of_Public_EC2>

    # Once logged into Public EC2 (and if key is on Public EC2 or agent forwarded):
    ssh -i /path/to/my-ssh-key.pem ec2-user@<Private_IP_of_Private_EC2>
    ```

---

## 🗑️ Cleaning Up

To avoid incurring ongoing AWS costs, it's crucial to destroy all provisioned resources after you're done.

1.  **Destroy Terraform Resources**:
    Navigate to the root of the project directory (`terraform-aws-project/`) and run:
    ```bash
    terraform destroy
    ```
    Type `yes` when prompted to confirm the destruction.

2.  **Manually Delete S3 State Bucket and DynamoDB Lock Table**:
    `terraform destroy` does not delete the S3 bucket or DynamoDB table used for remote state. You must delete these manually from the AWS Console to ensure no lingering costs.
    * **S3**: Go to S3, select `your-terraform-state-bucket-unique-name`, and delete it.
    * **DynamoDB**: Go to DynamoDB, select `your-terraform-lock-table-unique-name`, and delete the table.

---

## 🤝 Contribution

Feel free to fork this repository, experiment, and contribute to make it even better!

---

## 📜 License

This project is open-sourced under the [MIT License](LICENSE) (You might want to create a `LICENSE` file if you plan to share this broadly).
