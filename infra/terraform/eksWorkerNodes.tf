# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes

resource "aws_iam_role" "eks-store-nodes" {
  name = "eks-store-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-store-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-store-nodes.name
}

resource "aws_iam_role_policy_attachment" "eks-store-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-store-nodes.name
}

resource "aws_iam_role_policy_attachment" "eks-store-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-store-nodes.name
}

resource "aws_eks_node_group" "eks-store-nodes" {
  cluster_name    = aws_eks_cluster.eks-store.name
  node_group_name = "eks-store-nodes"
  node_role_arn   = aws_iam_role.eks-store-nodes.arn
  subnet_ids = [ 
      aws_subnet.public_subnet_1a.id, 
      aws_subnet.public_subnet_1c.id, 
      aws_subnet.private_subnet_1a.id, 
      aws_subnet.private_subnet_1c.id, 
  ]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-store-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-store-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-store-nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}
