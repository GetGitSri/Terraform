terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"

    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"

}

resource "random_string" "randomname" {
  length  = 5
  special = false
  upper   = false
}

resource "random_string" "randomname1" {
  length  = 5
  special = false
  upper   = false
}
resource "docker_container" "nodered-container" {
  name  = join("-", ["nodered",random_string.randomname.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

resource "docker_container" "nodered-container2" {
  name  = join("-",["nodered", random_string.randomname1.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}

output "ip-address" {
  value       = join(":", [docker_container.nodered-container.ip_address, docker_container.nodered-container.ports[0].external])
  description = "IP address of the container"
}

output "container-name" {
  value       = docker_container.nodered-container.name
  description = "name of the container"
}