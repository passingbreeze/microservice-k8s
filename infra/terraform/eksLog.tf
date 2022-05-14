resource "aws_cloudwatch_log_group" "eks-cluster-logs" {
    name = "/aws/eks/${var.cluster_name}/cluster"
    retention_in_days = 0
}