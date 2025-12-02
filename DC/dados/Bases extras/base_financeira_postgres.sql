
-- Base Financeira - PostgreSQL

CREATE SCHEMA IF NOT EXISTS financeiro;

CREATE TABLE financeiro.categorias_financeiras (
    id_categoria SERIAL PRIMARY KEY,
    descricao VARCHAR(100),
    tipo VARCHAR(20) -- Receita, Despesa, Investimento
);

CREATE TABLE financeiro.contas_bancarias (
    id_conta SERIAL PRIMARY KEY,
    nome_banco VARCHAR(50),
    agencia VARCHAR(10),
    numero_conta VARCHAR(20),
    tipo_conta VARCHAR(20) -- Corrente, Poupança
);

CREATE TABLE financeiro.transacoes (
    id_transacao SERIAL PRIMARY KEY,
    id_categoria INT REFERENCES financeiro.categorias_financeiras(id_categoria),
    id_conta INT REFERENCES financeiro.contas_bancarias(id_conta),
    data_transacao DATE,
    descricao VARCHAR(150),
    valor NUMERIC(12,2),
    tipo_transacao VARCHAR(10) -- Crédito, Débito
);

-- Inserts de exemplo - Categorias Financeiras
INSERT INTO financeiro.categorias_financeiras (descricao, tipo) VALUES
('Salário', 'Receita'),
('Venda de Produtos', 'Receita'),
('Conta de Luz', 'Despesa'),
('Conta de Água', 'Despesa'),
('Investimento em Renda Fixa', 'Investimento');

-- Inserts de exemplo - Contas Bancárias
INSERT INTO financeiro.contas_bancarias (nome_banco, agencia, numero_conta, tipo_conta) VALUES
('Banco do Brasil', '1234', '00012345-6', 'Corrente'),
('Caixa Econômica', '5678', '00067890-1', 'Poupança');

-- Inserts de exemplo - Transações Financeiras
INSERT INTO financeiro.transacoes (id_categoria, id_conta, data_transacao, descricao, valor, tipo_transacao) VALUES
(1, 1, '2024-06-01', 'Salário de Junho', 5000.00, 'Crédito'),
(2, 1, '2024-06-05', 'Venda de Produtos', 1200.00, 'Crédito'),
(3, 1, '2024-06-10', 'Conta de Luz', -300.00, 'Débito'),
(4, 2, '2024-06-12', 'Conta de Água', -150.00, 'Débito'),
(5, 1, '2024-06-15', 'Aplicação em CDB', -2000.00, 'Débito');
