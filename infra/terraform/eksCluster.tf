resource "aws_eks_cluster" "eks-store" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks-cluster-policy.arn
    enabled_cluster_log_types = ["api", "audit", "scheduler", "controllerManager"]
    vpc_config {
        subnet_ids = [ 
            aws_subnet.public_subnet_1a.id,
            aws_subnet.public_subnet_1c.id,
            aws_subnet.private_subnet_1a.id,
            aws_subnet.private_subnet_1c.id
         ]
    }
    
}
