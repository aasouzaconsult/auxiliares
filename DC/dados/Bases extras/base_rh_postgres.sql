
-- Base de Recursos Humanos (RH) - PostgreSQL

CREATE SCHEMA IF NOT EXISTS rh;

CREATE TABLE rh.departamentos (
    id_departamento SERIAL PRIMARY KEY,
    nome_departamento VARCHAR(100),
    localizacao VARCHAR(50)
);

CREATE TABLE rh.cargos (
    id_cargo SERIAL PRIMARY KEY,
    nome_cargo VARCHAR(100),
    salario_base NUMERIC(10,2)
);

CREATE TABLE rh.funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    data_admissao DATE,
    id_departamento INT REFERENCES rh.departamentos(id_departamento),
    id_cargo INT REFERENCES rh.cargos(id_cargo),
    salario_atual NUMERIC(10,2),
    status VARCHAR(20) -- Ativo, Inativo, Afastado
);

CREATE TABLE rh.folha_pagamento (
    id_folha SERIAL PRIMARY KEY,
    id_funcionario INT REFERENCES rh.funcionarios(id_funcionario),
    mes INT,
    ano INT,
    salario_bruto NUMERIC(10,2),
    descontos NUMERIC(10,2),
    salario_liquido NUMERIC(10,2)
);

CREATE TABLE rh.treinamentos (
    id_treinamento SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    carga_horaria INT,
    tipo VARCHAR(30) -- Presencial, Online
);

CREATE TABLE rh.participacoes_treinamentos (
    id_participacao SERIAL PRIMARY KEY,
    id_funcionario INT REFERENCES rh.funcionarios(id_funcionario),
    id_treinamento INT REFERENCES rh.treinamentos(id_treinamento),
    data_participacao DATE
);

-- Inserts de exemplo - Departamentos
INSERT INTO rh.departamentos (nome_departamento, localizacao) VALUES
('TI', 'São Paulo'),
('RH', 'Fortaleza'),
('Financeiro', 'Curitiba');

-- Inserts de exemplo - Cargos
INSERT INTO rh.cargos (nome_cargo, salario_base) VALUES
('Analista de Sistemas', 4500.00),
('Assistente de RH', 3000.00),
('Contador', 5000.00);

-- Inserts de exemplo - Funcionários
INSERT INTO rh.funcionarios (nome, data_admissao, id_departamento, id_cargo, salario_atual, status) VALUES
('Lucas Pereira', '2022-01-10', 1, 1, 4700.00, 'Ativo'),
('Mariana Costa', '2023-03-15', 2, 2, 3200.00, 'Ativo'),
('Carlos Silva', '2021-06-20', 3, 3, 5200.00, 'Afastado');

-- Inserts de exemplo - Folha de Pagamento
INSERT INTO rh.folha_pagamento (id_funcionario, mes, ano, salario_bruto, descontos, salario_liquido) VALUES
(1, 5, 2024, 4700.00, 700.00, 4000.00),
(2, 5, 2024, 3200.00, 500.00, 2700.00),
(3, 5, 2024, 5200.00, 800.00, 4400.00);

-- Inserts de exemplo - Treinamentos
INSERT INTO rh.treinamentos (titulo, carga_horaria, tipo) VALUES
('Formação em Liderança', 16, 'Presencial'),
('LGPD para Colaboradores', 8, 'Online'),
('Excel Avançado', 12, 'Presencial');

-- Inserts de exemplo - Participações em Treinamentos
INSERT INTO rh.participacoes_treinamentos (id_funcionario, id_treinamento, data_participacao) VALUES
(1, 1, '2024-04-10'),
(2, 2, '2024-04-15'),
(3, 3, '2024-04-20');
