
-- Base de Lanchonete - PostgreSQL

CREATE SCHEMA IF NOT EXISTS lanchonete;

CREATE TABLE lanchonete.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    canal_origem VARCHAR(20)
);

CREATE TABLE lanchonete.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(30),
    preco_unitario NUMERIC(10,2)
);

CREATE TABLE lanchonete.pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES lanchonete.clientes(id_cliente),
    data_pedido DATE,
    hora_pedido TIME,
    status_pedido VARCHAR(20)
);

CREATE TABLE lanchonete.itens_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES lanchonete.pedidos(id_pedido),
    id_produto INT REFERENCES lanchonete.produtos(id_produto),
    quantidade INT,
    preco_unitario NUMERIC(10,2)
);

CREATE TABLE lanchonete.pagamentos (
    id_pagamento SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES lanchonete.pedidos(id_pedido),
    forma_pagamento VARCHAR(20),
    valor_pago NUMERIC(10,2)
);

-- Inserts de exemplo - Clientes
INSERT INTO lanchonete.clientes (nome, telefone, canal_origem) VALUES
('João Silva', '85999990000', 'iFood'),
('Maria Souza', '85988880000', 'Balcão'),
('Carlos Lima', '85977770000', 'iFood');

-- Inserts de exemplo - Produtos
INSERT INTO lanchonete.produtos (nome_produto, categoria, preco_unitario) VALUES
('X-Burguer', 'Sanduíche', 15.00),
('X-Salada', 'Sanduíche', 18.00),
('Refrigerante Lata', 'Bebida', 5.00),
('Batata Frita', 'Acompanhamento', 8.00);

-- Inserts de exemplo - Pedidos
INSERT INTO lanchonete.pedidos (id_cliente, data_pedido, hora_pedido, status_pedido) VALUES
(1, '2024-06-15', '19:30', 'Entregue'),
(2, '2024-06-15', '20:00', 'Entregue'),
(3, '2024-06-16', '18:45', 'Cancelado');

-- Inserts de exemplo - Itens Pedido
INSERT INTO lanchonete.itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 15.00),
(1, 3, 2, 5.00),
(2, 2, 1, 18.00),
(2, 4, 1, 8.00);

-- Inserts de exemplo - Pagamentos
INSERT INTO lanchonete.pagamentos (id_pedido, forma_pagamento, valor_pago) VALUES
(1, 'IfoodPay', 40.00),
(2, 'Dinheiro', 26.00);
