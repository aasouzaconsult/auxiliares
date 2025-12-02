
-- Base de Contabilidade - PostgreSQL

CREATE SCHEMA IF NOT EXISTS contabilidade;

CREATE TABLE contabilidade.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cnpj VARCHAR(18),
    segmento VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(2)
);

CREATE TABLE contabilidade.plano_contas (
    id_conta SERIAL PRIMARY KEY,
    descricao VARCHAR(100),
    tipo VARCHAR(20) -- Receita, Despesa, Ativo, Passivo, Patrimonio
);

CREATE TABLE contabilidade.lancamentos_contabeis (
    id_lancamento SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES contabilidade.clientes(id_cliente),
    id_conta INT REFERENCES contabilidade.plano_contas(id_conta),
    data_lancamento DATE,
    valor NUMERIC(12,2),
    tipo_lancamento VARCHAR(10) -- Debito, Credito
);

CREATE TABLE contabilidade.periodos_fiscais (
    id_periodo SERIAL PRIMARY KEY,
    ano INT,
    mes INT,
    status VARCHAR(20) -- Aberto, Fechado
);

-- Inserts de Exemplo para Clientes
INSERT INTO contabilidade.clientes (nome, cnpj, segmento, cidade, estado) VALUES
('Empresa Alfa Ltda', '12.345.678/0001-00', 'Comércio', 'São Paulo', 'SP'),
('Empresa Beta S.A.', '98.765.432/0001-00', 'Serviços', 'Fortaleza', 'CE'),
('Gamma Consultoria', '56.789.123/0001-00', 'Consultoria', 'Rio de Janeiro', 'RJ');

-- Inserts de Exemplo para Plano de Contas
INSERT INTO contabilidade.plano_contas (descricao, tipo) VALUES
('Receita de Vendas', 'Receita'),
('Despesas Operacionais', 'Despesa'),
('Caixa', 'Ativo'),
('Fornecedores', 'Passivo'),
('Capital Social', 'Patrimonio');

-- Inserts de Exemplo para Períodos Fiscais
INSERT INTO contabilidade.periodos_fiscais (ano, mes, status) VALUES
(2024, 1, 'Fechado'),
(2024, 2, 'Fechado'),
(2024, 3, 'Aberto');

-- Inserts de Exemplo para Lançamentos Contábeis
INSERT INTO contabilidade.lancamentos_contabeis (id_cliente, id_conta, data_lancamento, valor, tipo_lancamento) VALUES
(1, 1, '2024-01-15', 5000.00, 'Credito'),
(1, 2, '2024-01-16', 1500.00, 'Debito'),
(2, 1, '2024-02-10', 8000.00, 'Credito'),
(2, 2, '2024-02-12', 3000.00, 'Debito'),
(3, 3, '2024-03-05', 2500.00, 'Debito');
