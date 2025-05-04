terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "my_app_image" {
  name         = "myapp:latest"
  build {
    context    = "${path.module}"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "my_app_container" {
  name  = "my_app_container"
  image = docker_image.my_app_image.name
  ports {
    internal = 80
    external = 8080
  }
}
