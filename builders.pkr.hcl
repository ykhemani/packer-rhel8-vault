build {
  hcp_packer_registry {
    bucket_name = var.bucket_name
    description = var.bucket_description

    bucket_labels = {
      "os"         = "linux"
      "base_image" = var.base_image
    }
  }

  sources = ["sources.googlecompute.rhel8-vault-uscentral"]

  provisioner "shell" {
    inline = [
      "sudo yum -y update",
      "sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
      "sudo yum -y install jq",
      "sudo yum -y install htop",
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo",
      "sudo yum install -y vault-enterprise"
    ]
  }
}
