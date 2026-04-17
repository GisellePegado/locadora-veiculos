-- ==============================================
-- DQL — Consultas representativas do sistema
-- Locadora de Veículos
-- ==============================================

use LocadoraVeiculos;

-- --------------------------------------------------
-- Q1: Manutenções realizadas nos veículos
-- Retorna: descrição, data e custo de cada manutenção
-- --------------------------------------------------
select
    descricao,
    dataManutencao,
    custo
from Manutencao;

-- --------------------------------------------------
-- Q2: Valor total arrecadado pela locadora
-- Considera apenas pagamentos com estado 'Pago'
-- --------------------------------------------------
select
    sum(valorTotal) as total_arrecadado
from Pagamento
where estado = 'Pago';

-- --------------------------------------------------
-- Q3: Veículos e número de vezes que foram locados
-- Ordenado de forma decrescente pelo total de aluguéis
-- --------------------------------------------------
select
    v.modelo,
    v.marca,
    count(l.idVeiculo) as total_locacoes
from Veiculo v
join LocacaoVeiculo l on v.idVeiculo = l.idVeiculo
group by l.idVeiculo
order by count(l.idVeiculo) desc;

-- --------------------------------------------------
-- Q4: Clientes com pagamentos pendentes e valores devidos
-- Ordenado alfabeticamente pelo nome do cliente
-- --------------------------------------------------
select
    c.nome,
    sum(p.valorTotal) as valor_pendente
from Cliente c
join Locacao l on c.idCliente = l.idCliente
join Pagamento p on l.idPagamento = p.idPagamento
where p.estado = 'Pendente'
group by c.nome
order by c.nome asc;
