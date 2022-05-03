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

## Apresentação

Estou utilizando este projeto para prototipar um framework de use cases para Ruby inspirado em linguagens funcionais como F#, ReasonML e Elixir. Com enfoque em composição de funções e visando preservar a performance através de se criar um contexto estático para as composições e evitar a necessidade de se instanciar classes.

Tentei usar o mínimo de gems o possível, apenas RSpec, FactoryBot e Faker são essenciais para os testes.
Wicked PDF também está sendo necessário, mas ele se mescla de uma forma intrusiva ao Rails, o que motiva a substituí-lo posteriormente.

Me movi em direção a uma arquitetura clean-like onde onde os controllers/views representam a camada de presentation e têm a responsabilidade apenas de coletar os parâmetros e repassar para a camada de application, obter um retorno e apresentar.

A camada de application é representada pelo diretório `services` e é dividida por resources, cada qual com sua pasta. Um resource por sua vez costuma conter um diretório `use_cases` com as ações principais do resource. Um Use Case aqui é entendido como uma ação que parte da camada externa e que causa efeitos (persistência de dados, trigger de eventos, enfileiramento de jobs, consumo de APIs externas). Cada Use Case também pode ter uma pasta a nível de resource com os services dependentes do Use Case, tal como Policies (autorização), Contracts (validação), e transformação de dados.
Já a nível de resource podem haver services diversos que sejam agnósticos a use case e que possam ser reusados tanto por outros services quanto pela camada de presentation.

A camada de entities é representada pelas models que devem manter a representação última dos dados em relação as regras de negócio, e podem conter validações, métodos e propriedades computadas que são independentes de qualquer caso de uso.

A arquitetura não pode ser considerada 100% aderente ao clean architecture pois o ActiveRecord força com que a camada de persistencia seja interna a camada de entity e não na camada externa junta aos controllers e presenters como a clean architecture, hexagonal e onion propõem. Porém é interessante buscar isolar classes que fazem operações externas (clients por exemplo) na camada externa e introduzir nos use cases via dependency injection (e é isto que pretendo fazer com o próximo renderizador de PDF).

Outro aspecto que pode ser melhorado, é empurrar todo parsing e validação de tipos para os controllers. Isto é algo que até hoje apenas vi o ASP.NET API fazer de forma transparente. Os use cases não deveriam se preocupar com tipagem, formatação e presença dos dados que são passados para eles, apenas com a validade da interdependência entre os dados em relação às regras de negócio.

Voltando ao framework de use cases, um case é chamado via `::[]` por mera questão estética (acho `.()` e `.call` meio feios). Um case pode ser definido por `self.is ‹callable›` onde o callable pode ser outro case ou um lambda, ou apenas se definindo um método `call()`. Os parametros aceitos pelo callable ou pelo método call() devem ser sempre parametros nomeados e espera se que o retorno seja um  `{ error: }` ou um `{ ok: data }`, onde `data` é um Hash. ok e error são representações de um monad `result = ok | error`. E embora seja possivel se retornar `{ ok: data, error: }`, isto não deve ser visto como um bug, mas sim como uma feature, pois pode haver ocasiões onde é desejável obter o resultado parcial e o erro. Decidi seguir com essa convenção como um hash ao invés de um array `[:ok, data] | [:error, error]` pois o pattern matching se mantém flexível e porque traduz diretamente para um JSON.

Os cases podem ser compostos através do operador `>>` que faz uma tratativa com o output do primeiro case. Se for retornado `{ ok: data }`, data é passado adiante em forma de named params, mas se é retornado `{ error: }`, o fluxo é interrompido e o erro é retornado pela composição em si. Esta tratativa se assemelha ao pattern Railway Oriented Programming (https://fsharpforfunandprofit.com/rop/). É possível compor cases com lambdas e fazer composições inline dentro de funções, o framework faz um memoizing da composição para não precisar reimplantar a tratativa toda vez que uma composição inline é chamada. Mas cuidado, não é interessante fazer uma composição inline entre um case e um lambda pois o lambda é recriado a cada chamada, neste caso, force um contexto estático para esta composição.

Como melhorias para o framework, pensei nas seguintes features:
 - Call Match: acumula o output de cada case em uma composição, mas chama o próximo apenas com os parametros que ele pede.
 - Contract Match: visa adicionar verificações estáticas ao estilo do SPARK (https://en.wikipedia.org/wiki/SPARK_(programming_language))
 - Rollback: permite um case implementar um método rollback que é executado quando em uma composição um case posterior falha, formando um Saga (https://microservices.io/patterns/data/saga.html)
 - Operadores diversos para tratativas diferentes na composição dos cases.

Fora o framework, estas melhorias podem ser aplicadas no projeto como um todo:

### TODO

- Criptografia asimétrica no link de validar token
- Criptografia hash no próprio token
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
- Mais programação defensiva
- Webhook para subscrever invoices emitidas p/ meu email.
- Caching
- Melhorar o UI/UX do front-end (Tailwind? Bulma?)
- Componentizar o front-end (github/view_component)
- Utilizar AJAX na listagem de invoices
- Delegar geração do PDF para front-end no caso de download.