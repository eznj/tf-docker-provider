resource "docker_image" "rust-testfire" {
  name         = "njames/rust-custom:latest"
  keep_locally = false
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "rust" {
  image = docker_image.rust-testfire.latest
  name  = "testfire-rust"
  ports {
    internal = 4499
    external = 4499
  }
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "nginx"
  ports {
    internal = 80
    external = 8000
  }
}
