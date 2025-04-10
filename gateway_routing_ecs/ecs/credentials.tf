resource "aws_secretsmanager_secret" "dockerhub" {
  name = "dockerhub-credentials"
}

resource "aws_secretsmanager_secret_version" "dockerhub_version" {
  secret_id     = aws_secretsmanager_secret.dockerhub.id
  secret_string = jsonencode({
    username = var.docker_hub_credentials.username
    password = var.docker_hub_credentials.password
  })
}
