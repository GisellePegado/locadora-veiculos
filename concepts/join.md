# JOIN

## O que é

`JOIN` é a operação que combina linhas de duas ou mais tabelas com base em uma condição de relacionamento entre elas — geralmente a igualdade entre uma chave estrangeira e a chave primária que ela referencia.

Como os dados em um banco relacional são distribuídos em múltiplas tabelas para evitar redundância, o `JOIN` é o mecanismo fundamental para **reunir informações que estão separadas** em uma única consulta.

Os tipos mais comuns são:

| Tipo | Comportamento |
|------|---------------|
| `INNER JOIN` (ou só `JOIN`) | Retorna apenas os registros que têm correspondência nas duas tabelas |
| `LEFT JOIN` | Retorna todos os registros da tabela da esquerda, com ou sem correspondência à direita |
| `RIGHT JOIN` | Retorna todos os registros da tabela da direita, com ou sem correspondência à esquerda |

## Como é usado neste projeto

O projeto usa `JOIN` em duas das quatro consultas do `dql.md`.

**Q3 — Veículos mais locados:** une `Veiculo` com `LocacaoVeiculo` para cruzar os dados da frota com os registros de locação. Sem o `JOIN`, seria impossível saber quantas vezes cada veículo foi alugado em uma única consulta.

**Q4 — Clientes com pagamentos pendentes:** encadeia dois `JOIN`s para percorrer três tabelas: `Cliente` → `Locacao` → `Pagamento`. Cada `JOIN` segue o caminho das chaves estrangeiras definidas no `ddl.sql`.

## Exemplo do projeto

```sql
-- Q4: dois JOINs encadeados seguindo as FKs do schema
SELECT
    c.nome,
    SUM(p.valorTotal) AS valor_pendente
FROM Cliente c
JOIN Locacao l   ON c.idCliente   = l.idCliente    -- FK: Locacao.idCliente → Cliente
JOIN Pagamento p ON l.idPagamento = p.idPagamento   -- FK: Locacao.idPagamento → Pagamento
WHERE p.estado = 'Pendente'
GROUP BY c.nome
ORDER BY c.nome ASC;
```

## Recursos para aprofundamento

- [W3Schools — SQL JOIN](https://www.w3schools.com/sql/sql_join.asp) — explicação visual dos diferentes tipos de JOIN
- [SQLZoo — JOIN Tutorial](https://sqlzoo.net/wiki/The_JOIN_operation) — exercícios práticos interativos
