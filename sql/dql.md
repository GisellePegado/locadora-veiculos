# DQL — Consultas SQL (Data Query Language)

Consultas implementadas sobre o banco `LocadoraVeiculos` a partir dos requisitos da atividade.  
Cada seção apresenta o enunciado, o SQL e o resultado obtido com os dados do `dml.sql`.

---

## Q1 — Manutenções realizadas nos veículos

**Enunciado:** Listar a descrição, a data e o custo de todas as manutenções realizadas nos veículos.

**Abordagem:** Consulta direta à tabela `Manutencao`, sem necessidade de junções — todos os dados solicitados estão na mesma tabela.

<details>
<summary>Ver SQL</summary>

```sql
USE LocadoraVeiculos;

SELECT
    descricao,
    dataManutencao,
    custo
FROM Manutencao;
```

</details>

<details>
<summary>Ver resultado</summary>

| descricao | dataManutencao | custo |
|-----------|---------------|------:|
| Troca de óleo e revisão geral | 2024-12-09 | 200,00 |
| Substituição de pneu | 2024-12-10 | 600,00 |
| Troca de pastilhas de freio | 2024-12-14 | 450,00 |
| Alinhamento e balanceamento | 2024-12-18 | 150,00 |
| Revisão elétrica completa | 2024-12-28 | 500,00 |
| Reparo na suspensão | 2025-01-05 | 700,00 |
| Troca do sistema de escapamento | 2025-01-07 | 750,00 |
| Troca de bateria | 2025-01-17 | 400,00 |
| Substituição do filtro de ar | 2025-01-17 | 120,00 |
| Pintura e retoques na lataria | 2025-01-28 | 900,00 |

*10 linhas retornadas.*

</details>

---

## Q2 — Total arrecadado pela locadora

**Enunciado:** Listar o valor total arrecadado pela locadora. Pagamentos com status `Pendente` não devem ser incluídos na soma.

**Abordagem:** Função de agregação `SUM` com filtro `WHERE` para considerar apenas pagamentos com `estado = 'Pago'`. Os 4 pagamentos pendentes (ids 16, 18, 19, 20) são excluídos automaticamente.

<details>
<summary>Ver SQL</summary>

```sql
USE LocadoraVeiculos;

SELECT
    SUM(valorTotal) AS total_arrecadado
FROM Pagamento
WHERE estado = 'Pago';
```

</details>

<details>
<summary>Ver resultado</summary>

| total_arrecadado |
|-----------------:|
| 14.700,00 |

*Soma dos 16 pagamentos com `estado = 'Pago'`. Os 4 pendentes (R$ 3.380,00) não entram no cálculo.*

</details>

---

## Q3 — Veículos mais locados

**Enunciado:** Listar o modelo e a marca dos veículos, bem como o número de vezes que cada um foi locado. A listagem deve ser apresentada em ordem decrescente pelo número de aluguéis.

**Abordagem:** `JOIN` entre `Veiculo` e `LocacaoVeiculo` para cruzar os dados das duas tabelas. `COUNT` para contar as locações por veículo, `GROUP BY` para agrupar e `ORDER BY DESC` para ordenar do mais alugado ao menos alugado.

<details>
<summary>Ver SQL</summary>

```sql
USE LocadoraVeiculos;

SELECT
    v.modelo,
    v.marca,
    COUNT(l.idVeiculo) AS total_locacoes
FROM Veiculo v
JOIN LocacaoVeiculo l ON v.idVeiculo = l.idVeiculo
GROUP BY l.idVeiculo
ORDER BY COUNT(l.idVeiculo) DESC;
```

</details>

<details>
<summary>Ver resultado</summary>

| modelo | marca | total_locacoes |
|--------|-------|---------------:|
| HB20 | Hyundai | 4 |
| Duster | Renault | 3 |
| Gol | Volkswagen | 2 |
| Corolla | Toyota | 2 |
| Fiesta | Ford | 2 |
| Toro | Fiat | 2 |
| Compass | Jeep | 2 |
| Onix | Chevrolet | 1 |
| Civic | Honda | 1 |
| Cruze | Chevrolet | 1 |

*10 linhas retornadas. O HB20 (Hyundai) foi o veículo mais locado, com 4 aluguéis.*

</details>

---

## Q4 — Clientes com pagamentos pendentes

**Enunciado:** Listar o nome dos clientes que possuem pagamento com status `Pendente`, bem como o valor total devido por cada um. A listagem deve ser apresentada em ordem alfabética crescente pelo nome do cliente.

**Abordagem:** Dois `JOIN`s encadeados para ligar `Cliente` → `Locacao` → `Pagamento`. Filtro `WHERE` para isolar os pendentes, `SUM` com `GROUP BY` para consolidar o valor total por cliente, e `ORDER BY ASC` para a ordenação alfabética.

<details>
<summary>Ver SQL</summary>

```sql
USE LocadoraVeiculos;

SELECT
    c.nome,
    SUM(p.valorTotal) AS valor_pendente
FROM Cliente c
JOIN Locacao l   ON c.idCliente   = l.idCliente
JOIN Pagamento p ON l.idPagamento = p.idPagamento
WHERE p.estado = 'Pendente'
GROUP BY c.nome
ORDER BY c.nome ASC;
```

</details>

<details>
<summary>Ver resultado</summary>

| nome | valor_pendente |
|------|---------------:|
| João da Silva | 880,00 |
| Lucas Martins | 2.220,00 |
| Pedro dos Santos | 280,00 |

*3 clientes com pagamentos pendentes. Lucas Martins possui o maior valor em aberto (R$ 2.220,00).*

</details>
