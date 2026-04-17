# Modelo Lógico para SQL (Logical Model to SQL)

## O que é

A transição do modelo lógico para a implementação SQL é o processo de converter uma representação abstrata do banco de dados — que descreve entidades, atributos e relacionamentos em termos de negócio — em código executável que cria fisicamente as tabelas em um sistema gerenciador de banco de dados (SGBD).

O modelo lógico (também chamado de modelo relacional) é a ponte entre o modelo conceitual (MER) e o código: ele já representa tabelas e colunas, mas ainda sem sintaxe de nenhum banco específico. O SQL DDL é a materialização desse modelo num SGBD concreto — neste projeto, MySQL.

O processo segue regras diretas:

| Modelo Lógico | SQL DDL |
|---------------|---------|
| Entidade | `CREATE TABLE` |
| Atributo | Coluna com nome e tipo de dado |
| Tipo do atributo | `INT`, `VARCHAR(n)`, `DATE`, `DECIMAL(p,s)`, `ENUM(...)` |
| Chave primária | `PRIMARY KEY (coluna)` |
| Chave estrangeira | `FOREIGN KEY (coluna) REFERENCES tabela(coluna)` |
| Restrição de nulidade | `NOT NULL` ou `NULL` |

## Como é usado neste projeto

O modelo relacional fornecido para a Locadora de Veículos foi integralmente convertido para SQL no arquivo `ddl.sql`. Cada tabela do modelo virou um `CREATE TABLE`, cada atributo virou uma coluna com seu tipo correspondente, e as chaves primárias e estrangeiras foram implementadas com as cláusulas `PRIMARY KEY` e `FOREIGN KEY`.

A tabela `LocacaoVeiculo`, por exemplo, é a representação SQL do relacionamento N:N entre `Locacao` e `Veiculo` — sua chave primária composta reflete diretamente o modelo lógico:

```
Modelo lógico:                    SQL gerado:
LocacaoVeiculo                    CREATE TABLE LocacaoVeiculo (
  idLocacao (PK, FK)     →            idLocacao INT NOT NULL,
  idVeiculo (PK, FK)     →            idVeiculo INT NOT NULL,
                                       PRIMARY KEY (idLocacao, idVeiculo),
                                       FOREIGN KEY (idLocacao) REFERENCES Locacao(idLocacao),
                                       FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo)
                                   );
```

## Exemplo do projeto

```sql
-- Modelo lógico: Veiculo com estado enum e valorDiaria decimal
-- ↓ Implementação SQL correspondente:

CREATE TABLE Veiculo (
    idVeiculo   INT          NOT NULL,
    modelo      VARCHAR(50)  NOT NULL,
    marca       VARCHAR(50)  NOT NULL,
    ano         INT          NOT NULL,
    placa       VARCHAR(10)  NOT NULL,
    valorDiaria DECIMAL(7,2) NOT NULL,
    estado      ENUM('Disponível','Alugado','Manutenção') NOT NULL,
    PRIMARY KEY (idVeiculo)
);
```

## Recursos para aprofundamento

- [W3Schools — SQL CREATE TABLE](https://www.w3schools.com/sql/sql_create_table.asp) — sintaxe completa com exemplos
- [MySQL Docs — Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html) — referência de tipos de dados disponíveis
