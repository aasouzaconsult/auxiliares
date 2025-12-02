
-- Base de Help Desk - PostgreSQL

CREATE SCHEMA IF NOT EXISTS helpdesk;

CREATE TABLE helpdesk.usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    departamento VARCHAR(50)
);

CREATE TABLE helpdesk.categorias_chamado (
    id_categoria SERIAL PRIMARY KEY,
    descricao VARCHAR(100)
);

CREATE TABLE helpdesk.chamados (
    id_chamado SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES helpdesk.usuarios(id_usuario),
    id_categoria INT REFERENCES helpdesk.categorias_chamado(id_categoria),
    data_abertura DATE,
    data_fechamento DATE,
    status VARCHAR(20),
    prioridade VARCHAR(20)
);

-- Inserts de Exemplo para Usuários
INSERT INTO helpdesk.usuarios (nome, email, departamento) VALUES
('Ana Souza', 'ana.souza@empresa.com', 'TI'),
('Bruno Lima', 'bruno.lima@empresa.com', 'RH'),
('Clara Mendes', 'clara.mendes@empresa.com', 'Financeiro');

-- Inserts de Exemplo para Categorias de Chamado
INSERT INTO helpdesk.categorias_chamado (descricao) VALUES
('Problemas de Rede'),
('Erro em Sistema'),
('Solicitação de Acesso');

-- Inserts de Exemplo para Chamados
INSERT INTO helpdesk.chamados (id_usuario, id_categoria, data_abertura, data_fechamento, status, prioridade) VALUES
(1, 1, '2024-03-01', '2024-03-02', 'Fechado', 'Alta'),
(2, 2, '2024-03-05', NULL, 'Aberto', 'Média'),
(3, 3, '2024-03-10', '2024-03-12', 'Fechado', 'Baixa');
