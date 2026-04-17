# Restrições de Integridade (Constraints)

## O que é

Constraints (restrições) são regras aplicadas às colunas ou tabelas de um banco de dados para garantir a **integridade e consistência dos dados**. Elas impedem que valores inválidos, duplicados ou inconsistentes sejam inseridos, protegendo o banco de erros que seriam difíceis de detectar e corrigir depois.

As principais constraints são:

| Constraint | Função |
|------------|--------|
| `NOT NULL` | O campo não pode ser vazio — obrigatório em todo INSERT |
| `PRIMARY KEY` | Identifica unicamente cada registro; implica NOT NULL e unicidade |
| `FOREIGN KEY` | Garante que o valor referenciado exista na tabela de origem (integridade referencial) |
| `UNIQUE` | Impede valores duplicados na coluna, sem ser PK |
| `ENUM` | Restringe os valores possíveis a uma lista pré-definida |
| `DEFAULT` | Define um valor automático quando o campo não é informado |
| `CHECK` | Valida uma condição antes de aceitar o dado (ex: idade > 0) |

## Como é usado neste projeto

O `ddl.sql` aplica constraints em todas as tabelas. Algumas escolhas notáveis:

**`NOT NULL` em todos os campos** — a atividade exigiu que nenhum campo aceitasse nulos, garantindo que nenhum registro seja inserido incompleto.

**`ENUM` para campos com valores fixos** — em vez de `VARCHAR` livre (que aceitaria qualquer texto, inclusive erros de digitação), `ENUM` restringe os valores possíveis:

```sql
estado ENUM('Disponível','Alugado','Manutenção')  -- Veiculo
forma  ENUM('Cartão','Pix','Dinheiro')             -- Pagamento
estado ENUM('Pago','Pendente')                     -- Pagamento
```

**`FOREIGN KEY` com `REFERENCES`** — garante que não seja possível inserir uma locação com um `idCliente` que não existe na tabela `Cliente`, nem deletar um cliente que tenha locações vinculadas.

## Exemplo do projeto

```sql
CREATE TABLE Locacao (
    idLocacao   INT  NOT NULL,               -- NOT NULL: campo obrigatório
    idCliente   INT  NOT NULL,               -- NOT NULL: campo obrigatório
    idPagamento INT  NOT NULL,               -- NOT NULL: campo obrigatório
    dataInicio  DATE NOT NULL,
    dataFim     DATE NOT NULL,
    PRIMARY KEY (idLocacao),                 -- PRIMARY KEY: unicidade + NOT NULL
    FOREIGN KEY (idCliente)   REFERENCES Cliente   (idCliente),   -- integridade referencial
    FOREIGN KEY (idPagamento) REFERENCES Pagamento  (idPagamento)  -- integridade referencial
);
```

## Recursos para aprofundamento

- [W3Schools — SQL Constraints](https://www.w3schools.com/sql/sql_constraints.asp) — guia completo com exemplos de cada tipo
- [MySQL Docs — ENUM Type](https://dev.mysql.com/doc/refman/8.0/en/enum.html) — comportamento e limitações do ENUM no MySQL
