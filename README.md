# packer-rhel8-vault

This repo contains a [HashiCorp](https://hashicorp.com) [Packer](https://packer.io) Image Template for building a machine image for [RedHat Enterprise Linux (RHEL)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) 8 on [Google Cloud](https://cloud.google.com).

## Use

### HCP Packer
This Packer Image Template registers the machine image built in the [HCP](http://cloud.hashicorp.com) Packer Image Registry.

In order to do this, you will need to generate a Service Principal in your HCP organization with a Contributor role and set the `HCP_CLIENT_ID` and `HCP_CLIENT_SECRET` environment variables with the values from that Service Principal.

If you are not integrating with HCP Packer, you will want to comment out or remove the `hcp_packer_registry` stanza in [builders.pkr.hcl](builders.pkr.hcl).

### Google Cloud Project
You will need to set the `gcp_project_id` Packer variable to indicate your Google Cloud Project. 

You can do this by creating a `.pkrvars.hcl` file with this variable. For example:

```
gcp_project_id = "ab-cdefghijklmnopqrstuvwxyz123"
```

You can also pass the variable using the `-var` flag. For example:
```
-var gcp_project_id=ab-cdefghijklmnopqrstuvwxyz123
```

### Google Cloud Credentials
Set your Google Cloud Credentials to enable Packer to authenticate with Google Cloud. You may do this by setting the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to point to the path of the service account key. Please see documentation on the [Google Compute Builder](https://developer.hashicorp.com/packer/plugins/builders/googlecompute#running-outside-of-google-cloud) for more information.

### Initialize Packer

```
packer init [-var-file=<pkrvars.hcl file>] .
```

For example:

```
packer init -var-file=yash.pkrvars.hcl .
```

### Format Packer Template

```
packer fmt [-var-file=<pkrvars.hcl file>] .
```

For example:

```
packer fmt -var-file=yash.pkrvars.hcl .
```

### Validate Packer Template

```
packer validate [-var-file=<pkrvars.hcl file>] .
```

For example:

```
packer validate -var-file=yash.pkrvars.hcl .
```

### Build Packer Template

```
packer build [-var-file=<pkrvars.hcl file>] .
```

For example:

```
packer build -var-file=yash.pkrvars.hcl .
```

---

## Using the resulting machine image from the HCP Packer Registry

If you have registered the machine image in the HCP Packer Registry, you may use it as follows in your Terraform configuration.

```
variable "google_zone" {
  type        = string
  description = "Google Cloud zone."
  default     = "us-central1-c"
}

variable "hcp_packer_bucket_name" {
  type        = string
  description = "Name of HCP Packer Bucket for bastion host image."
  default     = "rhel8-hashicorp-vault"
}

variable "hcp_packer_channel" {
  type        = string
  description = "Name of HCP Packer Channel for bastion host image."
  default     = "demo"
}

data "hcp_packer_image" "rhel8-hashicorp-vault" {
  bucket_name    = var.hcp_packer_bucket_name
  channel        = var.hcp_packer_channel
  cloud_provider = "gce"
  region         = var.google_zone
}

resource "google_compute_instance" "instance" {
  # ...
  boot_disk {
    initialize_params {
      image = data.hcp_packer_image.rhel8-hashicorp-vault.cloud_image_id
    }
  }
}  
```

---
