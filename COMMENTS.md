# COMMENTS

## Estrutura do Projeto
A estrtura global do projeto contempla a aplicação, automação de build, testes e deploy e o gerenciamento da infraestrutura como código.

### comments-api
Microserviço simples usando o framework Flask feito em Python, seguindo uma arquitetura para serviços RESTful.

## Decisões Arquiteturais
A aplicação possui uma arquitetura simples com separação de responsabilidades, onde o arquivo routes.py funciona quase como um controller e o models.py é um model convencional gerenciando dados e a lógica do negócio.

## Ambiente de Testes
Decidimos usar o banco de dados SQLite em memória apenas para os testes unitários. Essa abordagem garante que os testes sejam feitos rápidos, isolados e não dependam de conexão externa.

## Melhorias futuras

### Módulos do terraform em repositórios separados
O código da infra modulado, permitindo a construção de novos módulos dentro de um padrão e com sua própria gestão de atualizações. 

### Um job para cada recurso de infra
Alguns recurso de infra podem ser disponibilizados para construção a parte. Por exemplo, o provisionamento de um cluster EKS em determinada conta existente. Isso pode ser parametrizável e acessível a usuários com permissão.

### Deploy através do ArgoCD
O mesmo está sendo provisionado, mas ainda não faz a gestão de mudanças no kubernetes.

### Autoscaling
A melhoria de performance com a inclusão de uma estratégia de autoscaling.

### Estratégia de deploy
Atualmente estamos usando a estratégia de deploy padrão, Rolling Update, mas apesar de segura, é lenta e tem um processo de rollback complexo. A evolução dessa infra deve contemplar a escolha de uma estratégia mais avançada como Canary.