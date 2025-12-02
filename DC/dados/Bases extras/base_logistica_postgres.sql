
-- Base de Logística - PostgreSQL

CREATE SCHEMA IF NOT EXISTS logistica;

CREATE TABLE logistica.transportadoras (
    id_transportadora SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cnpj VARCHAR(18),
    cidade VARCHAR(50),
    estado VARCHAR(2)
);

CREATE TABLE logistica.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(150),
    cidade VARCHAR(50),
    estado VARCHAR(2)
);

CREATE TABLE logistica.pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES logistica.clientes(id_cliente),
    data_pedido DATE,
    status VARCHAR(20)
);

CREATE TABLE logistica.entregas (
    id_entrega SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES logistica.pedidos(id_pedido),
    id_transportadora INT REFERENCES logistica.transportadoras(id_transportadora),
    data_saida DATE,
    data_entrega DATE,
    status_entrega VARCHAR(20),
    tipo_frete VARCHAR(20) -- CIF, FOB, etc.
);

CREATE TABLE logistica.ocorrencias_entrega (
    id_ocorrencia SERIAL PRIMARY KEY,
    id_entrega INT REFERENCES logistica.entregas(id_entrega),
    data_ocorrencia DATE,
    descricao VARCHAR(255)
);

-- Inserts de Exemplo para Transportadoras
INSERT INTO logistica.transportadoras (nome, cnpj, cidade, estado) VALUES
('TransLog Express', '11.222.333/0001-00', 'São Paulo', 'SP'),
('Rápido Nordeste', '44.555.666/0001-00', 'Fortaleza', 'CE'),
('Sul Cargo', '77.888.999/0001-00', 'Porto Alegre', 'RS');

-- Inserts de Exemplo para Clientes
INSERT INTO logistica.clientes (nome, endereco, cidade, estado) VALUES
('Loja Alpha', 'Rua das Flores, 123', 'São Paulo', 'SP'),
('Distribuidora Beta', 'Av. Beira Mar, 456', 'Fortaleza', 'CE'),
('Supermercado Gamma', 'Rua Central, 789', 'Curitiba', 'PR');

-- Inserts de Exemplo para Pedidos
INSERT INTO logistica.pedidos (id_cliente, data_pedido, status) VALUES
(1, '2024-05-10', 'Concluído'),
(2, '2024-05-15', 'Em Andamento'),
(3, '2024-06-01', 'Cancelado');

-- Inserts de Exemplo para Entregas
INSERT INTO logistica.entregas (id_pedido, id_transportadora, data_saida, data_entrega, status_entrega, tipo_frete) VALUES
(1, 1, '2024-05-11', '2024-05-13', 'Entregue', 'CIF'),
(2, 2, '2024-05-16', NULL, 'Em Trânsito', 'FOB'),
(3, 3, '2024-06-02', NULL, 'Cancelada', 'CIF');

-- Inserts de Exemplo para Ocorrências de Entrega
INSERT INTO logistica.ocorrencias_entrega (id_entrega, data_ocorrencia, descricao) VALUES
(1, '2024-05-12', 'Atraso devido a condições climáticas'),
(2, '2024-05-17', 'Veículo em manutenção'),
(3, '2024-06-03', 'Pedido cancelado pelo cliente');
