resource "docker_network" "private_network" {
  name = "private"
}

resource "docker_image" "pg" {
  name         = "postgres"
  keep_locally = true
}

resource "docker_image" "rocket" {
  name         = "njames/testfire"
  keep_locally = true
}

resource "docker_image" "custom-nginx" {
  name         = "njames/custom-nginx"
  keep_locally = true
}

resource "docker_container" "rocket" {
  image     = docker_image.rocket.latest
  name      = "testfire"
  restart   = "unless-stopped"
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
  image   = docker_image.custom-nginx.latest
  name    = "nginx"
  restart = "unless-stopped"
  networks_advanced {
    name = "private"
    aliases = ["nginx"]
  }
  ports {
    internal = 80
    external = 80
  }
}

resource "docker_container" "pg" {
  image    = docker_image.pg.latest
  name     = "pg"
  restart  = "no"
  env      = ["POSTGRES_DB=testfire", "POSTGRES_USER=user", "POSTGRES_PASSWORD=pass"]
  networks_advanced {
    name = "private"
    aliases = ["pg"]
  }
  ports {
    internal = 5432
    external = 5444
  }
}
