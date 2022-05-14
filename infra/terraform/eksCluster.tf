resource "aws_eks_cluster" "eks-store" {
    name = "eks-store"
    role_arn = aws_iam_role.eks-cluster-policy.arn
    vpc_config {
        subnet_ids = [ 
            aws_subnet.public_subnet_1a.id,
            aws_subnet.public_subnet_1c.id,
            aws_subnet.private_subnet_1a.id,
            aws_subnet.private_subnet_1c.id
         ]
    }
    
}
