# Scripts SQL — Locadora de Veículos

## Tabelas

| Tabela           | Descrição                                        |
| ---------------- | ------------------------------------------------ |
| `Cliente`        | Clientes cadastrados na locadora                 |
| `Veiculo`        | Frota disponível para locação                    |
| `Pagamento`      | Pagamentos vinculados às locações                |
| `Manutencao`     | Histórico de manutenções por veículo             |
| `Locacao`        | Registros de locações realizadas                 |
| `LocacaoVeiculo` | Tabela associativa (N:N entre Locacao e Veiculo) |

## Arquivos

| Arquivo             | Tipo | Descrição                                                            |
| ------------------- | ---- | -------------------------------------------------------------------- |
| [`ddl.md`](ddl.sql) | DDL  | Criação do banco e das tabelas com PKs e FKs                         |
| [`dml.md`](dml.sql) | DML  | Inserção de dados de exemplo (10 clientes, 10 veículos, 20 locações) |
| [`dql.md`](dql.md)  | DQL  | 4 consultas com enunciado, abordagem e SQL para cada uma             |

## Ordem de execução

1. `ddl.sql` — criação do banco e das tabelas
2. `dml.sql` — inserção dos dados de exemplo
3. `dql.md` — consultas (leitura, qualquer ordem)

## Banco de dados

MySQL · executado via MySQL Workbench
