# Invoices Generator

## Configuração

### Dependências de ambiente

- Ruby `>= 3.1.0`
  - bundler `>= 2.3.4`
  - rails `>= 7`
- Node.js `>= 16.13.2`
  - npm `>= 8.0`
  - yarn `>= 1.22.0`
- Postgresql
- wkhtmltopdf
  `sudo apt get wkhtmltopdf` For Debian based OS, or:
  https://wkhtmltopdf.org/ Download here. 

### Preparando ambiente de desenvolvimento

1) Instale as dependências de ambiente.

2) Crie o arquivo `config/master.key`.

```sh
echo '2500af7274898ae80b2c62be1bbbb64f' > config/master.key

chmod 600 config/master.key
```

3) Crie o aquivo `config/database.yml` a partir do `config/database.yml.sample`.

4) Configure o arquivo `config/database.yml`.

5) Execute `bin/setup`

## Desenvolvimento

### Executando a aplicação

```sh
bin/dev
```

### Executando os testes

```sh
bin/rails spec
```

### TODO

- Criptografia no link de validar token
- Filtragem
- Paginação
- Specs para:
  - ApplicationHelper
  - InvoiceMailer & TokenMailer
  - ApplicationService
  - sessions routes
  - tokens routes
  - request (InvoicesController, TokensController, SessionsController)
  - testes Fuzzy
- API
  - padronizar retornos da API
  - retornar códigos HTTP corretos
  - documentar com rswag
- Usar monetize para lidar com valores monetários (?)
- + Programação defensiva
- Webhook para subscrever invoices emitidas p/ meu email.
- Caching
- Melhorar o front-end (Tailwind? Bulma?)
- Utilizar AJAX na listagem de invoices
- Delegar geração do PDF para front-end no caso de download.