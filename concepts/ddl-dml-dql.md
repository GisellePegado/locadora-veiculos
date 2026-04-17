# DDL, DML e DQL (DDL, DML and DQL)

## O que é

SQL é dividido em sublinguagens de acordo com o propósito de cada comando. As três mais comuns no dia a dia são:

**DDL — Data Definition Language (Linguagem de Definição de Dados)**  
Comandos que definem ou alteram a **estrutura** do banco de dados. Criam, modificam ou removem objetos como bancos, tabelas, índices e restrições. Os principais são `CREATE`, `ALTER` e `DROP`. Alterações DDL são geralmente irreversíveis e afetam o schema do banco.

**DML — Data Manipulation Language (Linguagem de Manipulação de Dados)**  
Comandos que manipulam os **dados** dentro das estruturas definidas pelo DDL. Inserem, atualizam, excluem ou consultam registros. Os principais são `INSERT`, `UPDATE`, `DELETE` e `SELECT`. Alterações DML podem ser desfeitas com `ROLLBACK` se executadas dentro de uma transação.

**DQL — Data Query Language (Linguagem de Consulta de Dados)**  
Alguns autores separam o `SELECT` como uma sublinguagem própria — o DQL — por ser o comando de leitura de dados, sem alterá-los. Na prática, muitos materiais tratam o `SELECT` como parte do DML.

## Como é usado neste projeto

O projeto está organizado exatamente seguindo essa separação, com um arquivo para cada sublinguagem:

| Arquivo | Sublinguagem | Responsabilidade |
|---------|-------------|-----------------|
| `ddl.sql` | DDL | `CREATE DATABASE` e `CREATE TABLE` — define a estrutura do banco |
| `dml.sql` | DML | `INSERT INTO` — popula as tabelas com dados de exemplo |
| `dql.md` | DQL | `SELECT` — consultas que extraem informações do banco |

Essa organização reflete uma boa prática de projetos reais: separar o que **define** o banco, o que **popula** o banco e o que **consulta** o banco facilita manutenção, controle de versão e execução seletiva de scripts.

## Exemplo do projeto

```sql
-- DDL: define a estrutura
CREATE TABLE Cliente (
    idCliente INT NOT NULL,
    nome      VARCHAR(50) NOT NULL,
    PRIMARY KEY (idCliente)
);

-- DML: insere dados
INSERT INTO Cliente (idCliente, nome) VALUES (1, 'João da Silva');

-- DQL: consulta os dados
SELECT nome FROM Cliente WHERE idCliente = 1;
```

## Recursos para aprofundamento

- [W3Schools — SQL Tutorial](https://www.w3schools.com/sql/) — cobre DDL, DML e DQL com exemplos interativos
- [GeeksForGeeks — SQL Commands](https://www.geeksforgeeks.org/sql-ddl-dql-dml-dcl-tcl-commands/) — classificação completa de todos os tipos de comandos SQL
