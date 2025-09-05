# COMMENTS

## Estrutura do Projeto
A estrtura global do projeto contempla a aplicação, automação de build, testes e deploy e o gerenciamento da infraestrutura como código.

### comments-api
Microserviço simples usando o framework Flask feito em Python, seguindo uma arquitetura para serviços RESTful.

## Decisões Arquiteturais
A aplicação possui uma arquitetura simples com separação de responsabilidades, onde o arquivo routes.py funciona quase como um controller e o models.py é um model convencional gerenciando dados e a lógica do negócio.

## Ambiente de Testes
Decidimos usar o banco de dados SQLite em memória apenas para os testes unitários. Essa abordagem garante que os testes sejam feitos rápidos, isolados e não dependam de conexão externa.

## 