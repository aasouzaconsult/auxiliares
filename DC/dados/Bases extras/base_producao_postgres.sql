
-- Base de Produção Industrial - PostgreSQL

CREATE SCHEMA IF NOT EXISTS producao;

CREATE TABLE producao.produtos_finais (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    unidade_medida VARCHAR(20)
);

CREATE TABLE producao.materias_primas (
    id_materia_prima SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    unidade_medida VARCHAR(20)
);

CREATE TABLE producao.ordens_producao (
    id_ordem SERIAL PRIMARY KEY,
    id_produto INT REFERENCES producao.produtos_finais(id_produto),
    data_inicio DATE,
    data_fim DATE,
    quantidade_produzida NUMERIC(10,2),
    status VARCHAR(20)
);

CREATE TABLE producao.consumo_materias_primas (
    id_consumo SERIAL PRIMARY KEY,
    id_ordem INT REFERENCES producao.ordens_producao(id_ordem),
    id_materia_prima INT REFERENCES producao.materias_primas(id_materia_prima),
    quantidade_consumida NUMERIC(10,2)
);

CREATE TABLE producao.paradas_producao (
    id_parada SERIAL PRIMARY KEY,
    id_ordem INT REFERENCES producao.ordens_producao(id_ordem),
    motivo VARCHAR(100),
    data_inicio TIMESTAMP,
    data_fim TIMESTAMP
);

-- Inserts de exemplo - Produtos Finais
INSERT INTO producao.produtos_finais (nome, categoria, unidade_medida) VALUES
('Cadeira de Madeira', 'Mobiliário', 'Unidade'),
('Mesa de Escritório', 'Mobiliário', 'Unidade');

-- Inserts de exemplo - Matérias-Primas
INSERT INTO producao.materias_primas (nome, unidade_medida) VALUES
('Madeira MDF', 'Metro cúbico'),
('Parafuso', 'Unidade'),
('Tinta Verniz', 'Litro');

-- Inserts de exemplo - Ordens de Produção
INSERT INTO producao.ordens_producao (id_produto, data_inicio, data_fim, quantidade_produzida, status) VALUES
(1, '2024-06-01', '2024-06-05', 100, 'Concluída'),
(2, '2024-06-10', NULL, 50, 'Em Andamento');

-- Inserts de exemplo - Consumo de Materiais
INSERT INTO producao.consumo_materias_primas (id_ordem, id_materia_prima, quantidade_consumida) VALUES
(1, 1, 5.0),
(1, 2, 400),
(1, 3, 10.0),
(2, 1, 2.5),
(2, 2, 200);

-- Inserts de exemplo - Paradas de Produção
INSERT INTO producao.paradas_producao (id_ordem, motivo, data_inicio, data_fim) VALUES
(2, 'Manutenção de Equipamento', '2024-06-12 08:00', '2024-06-12 12:00');
