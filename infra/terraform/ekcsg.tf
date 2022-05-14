resource "aws_security_group" "eks-sg" {
  name = "sgroup-for-eks"
  vpc_id = aws_vpc.vpc-for-eks.id

  ingress = [
    {
        description = "http inbound to EKS"
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        security_groups = []
        self = false
        prefix_list_ids = []
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }, 
    {
        description = "https inbound to EKS"
        from_port = var.https_port
        to_port = var.https_port
        protocol = "tcp"
        security_groups = []
        self = false
        prefix_list_ids = []
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }, 
    {
        description = "DB inbound to EKS"
        from_port = var.db_port
        to_port = var.db_port
        protocol = "tcp"
        security_groups = [aws_security_group.eks-sg.arn]
        self = false
        prefix_list_ids = []
        cidr_blocks = []
        ipv6_cidr_blocks = []
    },
    ]

  egress {
    description = "outbound from Web server"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  lifecycle {
    create_before_destroy = true
  }

  tags = {
      Name = "eks-security-group"
  }
}
