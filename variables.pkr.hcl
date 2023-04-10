variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID."
}

variable "gcp_zone" {
  type        = string
  description = "GCP Zone."
  default     = "us-central1-c"
}

variable "bucket_name" {
  type        = string
  description = "The image name when published to the HCP Packer registry. Will be overwritten if HCP_PACKER_BUCKET_NAME is set."
  default     = "rhel8-hashicorp-vault"
}

variable "bucket_description" {
  type        = string
  description = "The image description. Useful to provide a summary about the image. The description will appear at the image's main page and will be updated whenever it is changed and a new build is pushed to the HCP Packer registry. Should contain a maximum of 255 characters."
  default     = "This image is based on RHEL 8 and includes HashiCorp Vault Enterprise."
}

variable "base_image" {
  type        = string
  description = "Base image slug."
  default     = "rhel-8"
}