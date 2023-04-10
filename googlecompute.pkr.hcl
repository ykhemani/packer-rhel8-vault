source "googlecompute" "rhel8-vault-uscentral" {
  project_id          = var.gcp_project_id
  source_image_family = var.base_image
  ssh_username        = "packer"
  zone                = var.gcp_zone
  image_name          = "${var.base_image}-hashicorp-vault-{{timestamp}}"
}
