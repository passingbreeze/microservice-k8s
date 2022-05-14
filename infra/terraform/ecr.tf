resource "aws_ecrpublic_repository" "store-repos" {
  repository_name = "store-repos"

  catalog_data {
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
  }
}