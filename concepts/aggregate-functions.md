# Funções de Agregação, GROUP BY e ORDER BY (Aggregate Functions, GROUP BY and ORDER BY)

## O que é

**Funções de agregação** realizam cálculos sobre um conjunto de linhas e retornam um único valor. São usadas para responder perguntas como "qual o total?", "quantos registros existem?" ou "qual a média?". As principais são:

| Função | O que faz |
|--------|-----------|
| `COUNT()` | Conta o número de registros |
| `SUM()` | Soma os valores de uma coluna numérica |
| `AVG()` | Calcula a média dos valores |
| `MAX()` / `MIN()` | Retorna o maior ou menor valor |

**`GROUP BY`** divide os resultados em grupos antes de aplicar a função de agregação. Sem ele, a função calcularia sobre todos os registros de uma vez. Com ele, o cálculo é feito separadamente para cada grupo — por exemplo, o total de vendas **por cliente**, ou a quantidade de locações **por veículo**.

**`ORDER BY`** define a ordenação do resultado. `ASC` (padrão) ordena crescente; `DESC` ordena decrescente. Pode receber o nome de uma coluna ou até uma função como argumento.

## Como é usado neste projeto

O projeto usa funções de agregação nas consultas Q2, Q3 e Q4 do `dql.md`:

**Q2 — Total arrecadado:** `SUM(valorTotal)` somou todos os pagamentos com estado `'Pago'`, retornando um único número: o total arrecadado pela locadora.

**Q3 — Veículos mais locados:** `COUNT(l.idVeiculo)` contou quantas vezes cada veículo aparece na tabela `LocacaoVeiculo`. O `GROUP BY l.idVeiculo` garantiu que a contagem fosse feita separadamente para cada veículo. O `ORDER BY COUNT(...) DESC` ordenou do mais alugado para o menos.

**Q4 — Clientes com pendências:** `SUM(p.valorTotal)` somou os valores devidos, mas agrupado por `c.nome` — assim cada cliente tem seu próprio total. O `ORDER BY c.nome ASC` organizou o resultado em ordem alfabética.

## Exemplo do projeto

```sql
-- Q3: COUNT por grupo + ordenação pelo resultado da agregação
SELECT
    v.modelo,
    v.marca,
    COUNT(l.idVeiculo) AS total_locacoes
FROM Veiculo v
JOIN LocacaoVeiculo l ON v.idVeiculo = l.idVeiculo
GROUP BY l.idVeiculo                          -- agrupa por veículo antes de contar
ORDER BY COUNT(l.idVeiculo) DESC;             -- ordena pelo resultado da contagem
```

## Recursos para aprofundamento

- [W3Schools — SQL Aggregate Functions](https://www.w3schools.com/sql/sql_aggregate_functions.asp) — referência de todas as funções com exemplos
- [W3Schools — SQL GROUP BY](https://www.w3schools.com/sql/sql_groupby.asp) — uso combinado com funções de agregação
