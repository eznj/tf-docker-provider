resource "docker_image" "rust-testfire" {
  name         = "njames/testfire:latest"
  keep_locally = false
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
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
  image = docker_image.nginx.latest
  name  = "nginx"
  networks_advanced {
    name = "private"
    aliases = ["nginx"]
  }
  ports {
    internal = 80
    external = 8000
  }
}
