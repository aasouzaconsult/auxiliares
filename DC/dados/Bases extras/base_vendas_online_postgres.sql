
-- Base de Vendas Online - PostgreSQL

CREATE SCHEMA IF NOT EXISTS ecommerce;

CREATE TABLE ecommerce.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    data_cadastro DATE
);

CREATE TABLE ecommerce.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco_unitario NUMERIC(10,2)
);

CREATE TABLE ecommerce.vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES ecommerce.clientes(id_cliente),
    data_venda DATE,
    total_venda NUMERIC(12,2),
    status VARCHAR(20)
);

CREATE TABLE ecommerce.itens_venda (
    id_item SERIAL PRIMARY KEY,
    id_venda INT REFERENCES ecommerce.vendas(id_venda),
    id_produto INT REFERENCES ecommerce.produtos(id_produto),
    quantidade INT,
    preco_unitario NUMERIC(10,2)
);

-- Inserts de Exemplo para Clientes
INSERT INTO ecommerce.clientes (nome, email, cidade, estado, data_cadastro) VALUES
('João Silva', 'joao@gmail.com', 'São Paulo', 'SP', '2023-01-15'),
('Maria Oliveira', 'maria@gmail.com', 'Fortaleza', 'CE', '2023-02-20'),
('Carlos Santos', 'carlos@gmail.com', 'Rio de Janeiro', 'RJ', '2023-03-10');

-- Inserts de Exemplo para Produtos
INSERT INTO ecommerce.produtos (nome_produto, categoria, preco_unitario) VALUES
('Notebook Lenovo', 'Informática', 3500.00),
('Smartphone Samsung', 'Eletrônicos', 2200.00),
('Fone JBL', 'Áudio', 450.00);

-- Inserts de Exemplo para Vendas
INSERT INTO ecommerce.vendas (id_cliente, data_venda, total_venda, status) VALUES
(1, '2024-01-10', 3950.00, 'Concluída'),
(2, '2024-01-15', 2200.00, 'Concluída'),
(3, '2024-02-05', 450.00, 'Cancelada');

-- Inserts de Exemplo para Itens de Venda
INSERT INTO ecommerce.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 3500.00),
(1, 3, 1, 450.00),
(2, 2, 1, 2200.00),
(3, 3, 1, 450.00);
