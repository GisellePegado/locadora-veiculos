# DDL — Criação das Tabelas (Data Definition Language)

O arquivo `ddl.sql` cria o banco de dados `LocadoraVeiculos` e todas as suas tabelas a partir do **[modelo relacional (lógico)](../assets/modelo-logico.png)** fornecido na atividade. Cada tabela foi construída com base nas entidades, atributos, tipos de dados, chaves primárias e chaves estrangeiras descritos no modelo.

---

## Banco de dados

```sql
CREATE DATABASE LocadoraVeiculos;
USE LocadoraVeiculos;
```

O banco agrupa todas as tabelas do sistema. O comando `USE` seleciona o banco para que os próximos comandos sejam executados dentro dele.

---

## Tabelas

### Cliente

**Informações disponíveis no modelo:** `idCliente INT (PK)`, `CPF VARCHAR(20)`, `nome VARCHAR(50)`, `telefone VARCHAR(20)`, `email VARCHAR(50)`, `endereco VARCHAR(100)`.

O cliente é o ponto de entrada do negócio — toda locação precisa estar vinculada a um cliente cadastrado.

<details>
<summary>Ver SQL</summary>

```sql
CREATE TABLE Cliente (
    idCliente  INT          NOT NULL,
    CPF        VARCHAR(20)  NOT NULL,
    nome       VARCHAR(50)  NOT NULL,
    telefone   VARCHAR(20)  NOT NULL,
    email      VARCHAR(50)  NOT NULL,
    endereco   VARCHAR(100) NULL,
    PRIMARY KEY (idCliente)
);
```

</details>

---

### Veiculo

**Informações disponíveis no modelo:** `idVeiculo INT (PK)`, `modelo VARCHAR(50)`, `marca VARCHAR(50)`, `ano INT`, `placa VARCHAR(10)`, `valorDiaria DECIMAL(7,2)`, `estado ENUM('Disponível','Alugado','Manutenção')`.

O campo `estado` usa `ENUM` para restringir os valores possíveis a exatamente três situações operacionais do veículo — qualquer outro valor seria rejeitado pelo banco.

<details>
<summary>Ver SQL</summary>

```sql
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

</details>

---

### Pagamento

**Informações disponíveis no modelo:** `idPagamento INT (PK)`, `forma ENUM('Cartão','Pix','Dinheiro')`, `dataPagamento DATE`, `valorTotal DECIMAL(7,2)`, `estado ENUM('Pago','Pendente')`.

`Pagamento` não tem chave estrangeira porque a relação 1:1 com `Locacao` é registrada do lado de `Locacao` — que recebe o `idPagamento` como FK. Isso segue a regra: em cardinalidade 1:1, a FK vai para a tabela com mais chaves estrangeiras.

<details>
<summary>Ver SQL</summary>

```sql
CREATE TABLE Pagamento (
    idPagamento   INT          NOT NULL,
    forma         ENUM('Cartão','Pix','Dinheiro') NOT NULL,
    dataPagamento DATE         NOT NULL,
    valorTotal    DECIMAL(7,2) NOT NULL,
    estado        ENUM('Pago','Pendente') NOT NULL,
    PRIMARY KEY (idPagamento)
);
```

</details>

---

### Manutencao

**Informações disponíveis no modelo:** `idManutencao INT (PK)`, `idVeiculo INT (FK)`, `descricao VARCHAR(100)`, `dataManutencao DATE`, `custo DECIMAL(7,2)`.

A relação com `Veiculo` é N:1 — um veículo pode ter várias manutenções, mas cada manutenção pertence a exatamente um veículo. Por isso `idVeiculo` aparece aqui como chave estrangeira.

<details>
<summary>Ver SQL</summary>

```sql
CREATE TABLE Manutencao (
    idManutencao   INT          NOT NULL,
    idVeiculo      INT          NOT NULL,
    descricao      VARCHAR(100) NOT NULL,
    dataManutencao DATE         NOT NULL,
    custo          DECIMAL(7,2) NOT NULL,
    PRIMARY KEY (idManutencao),
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo (idVeiculo)
);
```

</details>

---

### Locacao

**Informações disponíveis no modelo:** `idLocacao INT (PK)`, `idCliente INT (FK)`, `idPagamento INT (FK)`, `dataInicio DATE`, `dataFim DATE`.

`Locacao` é a tabela central do sistema — ela conecta o cliente ao pagamento e serve de âncora para os veículos alugados (via `LocacaoVeiculo`). Carrega duas chaves estrangeiras: `idCliente` (N:1 com `Cliente`) e `idPagamento` (1:1 com `Pagamento`).

<details>
<summary>Ver SQL</summary>

```sql
CREATE TABLE Locacao (
    idLocacao   INT  NOT NULL,
    idCliente   INT  NOT NULL,
    idPagamento INT  NOT NULL,
    dataInicio  DATE NOT NULL,
    dataFim     DATE NOT NULL,
    PRIMARY KEY (idLocacao),
    FOREIGN KEY (idCliente)   REFERENCES Cliente  (idCliente),
    FOREIGN KEY (idPagamento) REFERENCES Pagamento (idPagamento)
);
```

</details>

---

### LocacaoVeiculo

**Informações disponíveis no modelo:** `idLocacao INT (PK, FK)`, `idVeiculo INT (PK, FK)`.

Tabela associativa criada para resolver o relacionamento N:N entre `Locacao` e `Veiculo` — uma locação pode incluir mais de um veículo, e um veículo pode aparecer em locações diferentes ao longo do tempo. A chave primária é **composta** pelos dois campos, o que garante que a mesma combinação locação-veículo não se repita.

<details>
<summary>Ver SQL</summary>

```sql
CREATE TABLE LocacaoVeiculo (
    idLocacao  INT NOT NULL,
    idVeiculo  INT NOT NULL,
    PRIMARY KEY (idLocacao, idVeiculo),
    FOREIGN KEY (idLocacao) REFERENCES Locacao (idLocacao),
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo (idVeiculo)
);
```

</details>

---

## Diagrama de relacionamentos

```
Cliente ──────────────< Locacao >────────────── Pagamento
                           │
                    LocacaoVeiculo
                           │
Veiculo ──────────────────>┘
  │
  └──< Manutencao
```

Leitura: um `Cliente` faz várias `Locacao`s; cada `Locacao` gera um `Pagamento`; cada `Locacao` inclui um ou mais `Veiculo`s via `LocacaoVeiculo`; cada `Veiculo` pode ter várias `Manutencao`s.
