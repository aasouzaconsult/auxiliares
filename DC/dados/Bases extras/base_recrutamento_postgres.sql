
-- Base de Recrutamento e Seleção - PostgreSQL

CREATE SCHEMA IF NOT EXISTS recrutamento;

CREATE TABLE recrutamento.vagas (
    id_vaga SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    departamento VARCHAR(50),
    data_abertura DATE,
    status VARCHAR(20)
);

CREATE TABLE recrutamento.candidatos (
    id_candidato SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    data_cadastro DATE
);

CREATE TABLE recrutamento.inscricoes (
    id_inscricao SERIAL PRIMARY KEY,
    id_candidato INT REFERENCES recrutamento.candidatos(id_candidato),
    id_vaga INT REFERENCES recrutamento.vagas(id_vaga),
    data_inscricao DATE,
    status VARCHAR(20)
);

CREATE TABLE recrutamento.etapas_processos (
    id_etapa SERIAL PRIMARY KEY,
    id_inscricao INT REFERENCES recrutamento.inscricoes(id_inscricao),
    nome_etapa VARCHAR(50),
    data_realizacao DATE,
    resultado VARCHAR(20)
);

-- Inserts de exemplo - Vagas
INSERT INTO recrutamento.vagas (titulo, departamento, data_abertura, status) VALUES
('Analista de Dados', 'TI', '2024-05-01', 'Aberta'),
('Assistente Administrativo', 'Administração', '2024-04-15', 'Fechada');

-- Inserts de exemplo - Candidatos
INSERT INTO recrutamento.candidatos (nome, email, cidade, estado, data_cadastro) VALUES
('Lucas Silva', 'lucas@gmail.com', 'São Paulo', 'SP', '2024-05-05'),
('Mariana Costa', 'mariana@gmail.com', 'Fortaleza', 'CE', '2024-05-10'),
('Carlos Mendes', 'carlos@gmail.com', 'Belo Horizonte', 'MG', '2024-05-12');

-- Inserts de exemplo - Inscrições
INSERT INTO recrutamento.inscricoes (id_candidato, id_vaga, data_inscricao, status) VALUES
(1, 1, '2024-05-06', 'Ativo'),
(2, 1, '2024-05-11', 'Ativo'),
(3, 2, '2024-05-13', 'Ativo');

-- Inserts de exemplo - Etapas do Processo
INSERT INTO recrutamento.etapas_processos (id_inscricao, nome_etapa, data_realizacao, resultado) VALUES
(1, 'Triagem Curricular', '2024-05-07', 'Aprovado'),
(1, 'Entrevista Técnica', '2024-05-08', 'Reprovado'),
(2, 'Triagem Curricular', '2024-05-12', 'Aprovado'),
(2, 'Entrevista Técnica', '2024-05-13', 'Aprovado'),
(3, 'Triagem Curricular', '2024-05-14', 'Reprovado');
