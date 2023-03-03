job "mockoon" {
  datacenters = ["dc1"]

  group "mockoon-group" {
    network {
      port "http" {
        static = 3000
        to = 3000
      }
    }

    task "mockoon" {
      driver = "docker"

      config {
        image = "mockoon/cli:latest"

        ports = ["http"]

        args = [
          "start",
          "--data",
          "https://gist.githubusercontent.com/madvate/8142dd72a4cc1bb572dd3118780685ed/raw/53c003cd18d7c07d5ad285dfd8a2bf8d16390acf/mockoon.json",
          "--port",
          "3000"
        ]
      }
    }
  }
}