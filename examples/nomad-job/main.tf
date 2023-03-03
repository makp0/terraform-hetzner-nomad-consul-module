terraform {
  required_providers {
    nomad = {
      source = "hashicorp/nomad"
      version = "1.4.19"
    }
  }
  backend "remote" {
    organization = "Tradent"

    workspaces {
      name = "pure-terraform-hetzner-nomad-consul-user"
    }
  }
}

data "terraform_remote_state" "cloud" {
  backend = "remote"
  config = {
    organization = "Tradent"
    workspaces = {
      name = "pure-terraform-hetzner-nomad-consul"
    }
  }
}


provider "nomad" {
  address = data.terraform_remote_state.cloud.outputs.nomad_address
  secret_id = data.terraform_remote_state.cloud.outputs.nomad_token
}

resource "nomad_job" "monitoring" {
  jobspec = file("${path.module}/mockoon.hcl")
}


