resource "docker_image" "rust-testfire" {
  name         = "njames/testfire:latest"
  keep_locally = true
}

resource "docker_image" "custom-nginx" {
  name         = "njames/custom-nginx:latest"
  keep_locally = true
}

resource "docker_network" "private_network" {
  name = "private"
}

resource "docker_container" "rust" {
  image = docker_image.rust-testfire.latest
  name  = "rust-testfire"
  networks_advanced {
    name = "private"
    aliases = ["rust"]
  }
  ports {
    internal = 4000
    external = 4000
  }
}

resource "docker_container" "nginx" {
  image = docker_image.custom-nginx.latest
  name  = "nginx"
  restart = "on-failure"
  networks_advanced {
    name = "private"
    aliases = ["nginx"]
  }
  ports {
    internal = 80
    external = 80
  }
}
