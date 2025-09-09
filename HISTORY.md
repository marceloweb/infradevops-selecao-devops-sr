# HISTORY

# HISTORY

## 0.0.1 - 2025-09-03
### Added
- Novas rotas para API de comentários: PUT /api/comment/update/{id} e DELETE /api/comment/delete/{id}.
- Integração de métricas com Prometheus no endpoint /metrics.
- Adicionado campo 'email' ao modelo de comentário.
- Implementado health check no endpoint /health.

### Changed
- Atualização da rota POST /api/comment/new para incluir o campo 'email'.
- Rota GET /api/comment/list/{id} ajustada para novo padrão.
- Refatorado código para conformidade com SQLAlchemy 2.0 (usando text()).

### Added
- Configuração inicial do projeto com Flask e Docker.
- Conexão com banco de dados PostgreSQL.
- Testes unitários para as rotas iniciais.

### Added
- Configuração inicial do arquivo .gitlab-ci.yml.

### Changed
- Mudança da plataforma de CI/CD para o Github Actions pelo fato da função "pull" no Gitlab só está disponível para planos pagos.

## 0.0.1 - 2025-09-04
### Added
- Provisionamento da infra na AWS.

### Added
- Provisionamento do ArgoCD via Terraform.

## 0.0.1 - 2025-09-05
### Added
- Preparando yml para fazer o provisionamento da infra via Github Action.

## 0.0.1 - 2025-09-09
### Added
- Adicionado Jaeger para monitoramento de trace.

### Change
- Otimização do Dockerfile.