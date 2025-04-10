resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs_parameter_store_policy"
  description = "Permissões para acessar o Parameter Store"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ecs:*",
        "logs:*",
        "secretsmanager:*"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_parameter_store_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

resource "aws_ecs_task_definition" "estudos_gateway_routing_app_01" {
  family                   = "app-01"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name      = "app-01"
      image     = "fabiomartineli/estudos-gateway-routing"
      essential = true
      cpu       = 1024
      memory    = 2048
      environment = [
        {
          name  = "application_name",
          value = "app-01"
        },
        {
          name  = "aws_region",
          value = "${var.provider_aws_region}"
        }
        ,
        {
          name  = "aws_acesskey",
          value = "${var.provider_aws_access_key}"
        },
        {
          name  = "aws_secretKey",
          value = "${var.provider_aws_secret_key}"
        }
      ]
      portMappings = [
        {
          containerPort = 3000
        }
      ]
      repositoryCredentials = {
        credentialsParameter = aws_secretsmanager_secret.dockerhub.arn
      }
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : "ecs_tasks_custom",
          "awslogs-region" : "us-east-2",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "estudos_gateway_routing_app_02" {
  family                   = "app-02"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name      = "app-02"
      image     = "fabiomartineli/estudos-gateway-routing"
      essential = true
      cpu       = 1024
      memory    = 2048
      environment = [
        {
          name  = "application_name"
          value = "app-02"
        },
        {
          name  = "aws_region",
          value = "${var.provider_aws_region}"
        }
        ,
        {
          name  = "aws_acesskey",
          value = "${var.provider_aws_access_key}"
        },
        {
          name  = "aws_secretKey",
          value = "${var.provider_aws_secret_key}"
        }
      ]
      portMappings = [
        {
          containerPort = 3000
        }
      ]
      repositoryCredentials = {
        credentialsParameter = aws_secretsmanager_secret.dockerhub.arn
      }
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : "ecs_tasks_custom",
          "awslogs-region" : "us-east-2",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}

