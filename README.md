# AWS ECS - Terraform

O ECS é um recurso da AWS que permite executar containers, um pouco parecido com o funcionamento do próprio kubernetes.

### Conceitos
No ECS, temos alguns conceitos:
- Cluster: responsável por gerenciar quais são as máquinas que irão executar de fato as aplicações.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/ecs/cluster.tf)
- Services: responsável por executar uma determinada definição de tarefa.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/ecs/service.tf)
- Task definition: responsável por conter informações sobre o seu container de fato, como imagem, mapeamento de portas, variavéis de ambiente, etc.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/ecs/task-definition.tf)

### Infraestrutura
Para executar um ECS, precisamos de alguns requisitos disponíveis na arquitetura dos serviços AWS. São eles:
- VPC: Virtual Private Cloud. [Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/vpc/main.tf)
- Subnet: rede interna da VPC.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/vpc/main.tf)
- Internet gateway: responsável por providenciar a comunicação externa (internet) ao seu serviço.[Arquivo]([https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/vpc/main.tf](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/internet-gateway/main.tf))
- NAT gateway: responsável por providencer que seu serviço possa realizar comunicações externas (internet). Aqui é necessário vincular um IP Elástico e uma subnet pública.[Arquivo]([[https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/vpc/main.tf](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/internet-gateway/main.tf)](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/nat/main.tf))
- Route table: tabela de roteamento, onde as subnet privadas irão ser vinculadas ao NAT Gateway e as subnetes pública vinculadas ao Internet Gateway.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/route-table/main.tf)
- Security group: responsável por conter regras que permitem a entrada e saída de tráfego.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/security-group/main.tf)
- Cloud watch: responsável por armazenar os logs dos seus serviços.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/ecs/cloudwatch.tf)
- Secret Manager: responsável por armazenar as credenciais de seguras para o Docker Hub (neste cenário), contendo o usuário e senha. Será necessário para realizar o download da imagem necessárias.[Arquivo](https://github.com/fabiomartineli/aws-ecs-terraform/blob/master/gateway_routing_ecs/ecs/credentials.tf)
