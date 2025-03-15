# Creating VPC
resource "aws_vpc" "eks_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="EKS Testing"
    }
}

# creating subnet from above VPC
resource "aws_subnet" "eks_subnet" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = false
    availability_zone = "ap-south-1b"  
    tags = {
      Name = "EKSSubnet"
    }
}

# creating subnet from above VPC
resource "aws_subnet" "eks_subnet1" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = "10.0.1.0/25"
    map_public_ip_on_launch = false
    availability_zone = "ap-south-1c"  
    tags = {
      Name = "EKSSubnet1"
    }
}

# creating subnet from above VPC
resource "aws_subnet" "eks_subnet2" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = "10.0.2.0/25"
    map_public_ip_on_launch = false
    availability_zone = "ap-south-1a"  
    tags = {
      Name = "EKSSubnet2"
    }
}

# creating cluster iam role with zero permissions but we mentioned only EKS can use this role
resource "aws_iam_role" "cluster_role" {
    name = "Eks_Cluster_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "sts:AssumeRole",
                    "sts:TagSession"
                ]
                Effect = "Allow"
                Principal = {
                    Service = "eks.amazonaws.com"
                }
            }
        ]
    })
}
# Attaching Below created policy to above cluster iam role
resource "aws_iam_role_policy_attachment" "EKS_Control_plan" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.cluster_role.name
}

# creating worker node iam role with zero permissions but we mentioned only EKS can use this role
resource "aws_iam_role" "worker_role" {
    name = "EKS_Workernode_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
                Action = ["sts:AssumeRole"]
            }
        ]
    })
}

# # Attaching Below3 created policy's to above worker nodes iam role
resource "aws_iam_role_policy_attachment" "EKS_Worker_nodepolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "EKS_Worker_dockerecs" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "EKS_Worker_CNI" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.worker_role.name
}

resource "aws_eks_cluster" "testing_cluster" {
    name = "test_eks"
    role_arn = aws_iam_role.cluster_role.arn
    version = "1.29"
    vpc_config {
        subnet_ids = [
            aws_subnet.eks_subnet.id,
            aws_subnet.eks_subnet1.id,
            aws_subnet.eks_subnet2.id
            ]
    }
    tags = {
      Name = "gopi_testing"
      Account = "Private"
    }
}

resource "aws_eks_node_group" "autoscaling" {
    cluster_name = aws_eks_cluster.testing_cluster.name
    node_group_name = "worker-node-grp"
    node_role_arn = aws_iam_role.worker_role.arn
    subnet_ids = [
        aws_subnet.eks_subnet.id,
        aws_subnet.eks_subnet1.id,
        aws_subnet.eks_subnet2.id
    ]
    scaling_config {
      desired_size = 2
      min_size = 1
      max_size = 2
    }
    instance_types = ["t3.medium"]
    remote_access {
      ec2_ssh_key = "aws_login"
    }
    tags = {
      Name = "EKS auto scaling"
    }
}
