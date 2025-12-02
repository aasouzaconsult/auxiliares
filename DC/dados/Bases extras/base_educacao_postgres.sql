
-- Base Educacional - PostgreSQL

CREATE SCHEMA IF NOT EXISTS educacional;

CREATE TABLE educacional.alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    curso VARCHAR(100),
    data_ingresso DATE,
    status_academico VARCHAR(20)
);

CREATE TABLE educacional.disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(100),
    carga_horaria INT,
    departamento VARCHAR(50)
);

CREATE TABLE educacional.professores (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    departamento VARCHAR(50)
);

CREATE TABLE educacional.turmas (
    id_turma SERIAL PRIMARY KEY,
    id_disciplina INT REFERENCES educacional.disciplinas(id_disciplina),
    id_professor INT REFERENCES educacional.professores(id_professor),
    semestre VARCHAR(10),
    ano INT
);

CREATE TABLE educacional.matriculas (
    id_matricula SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES educacional.alunos(id_aluno),
    id_turma INT REFERENCES educacional.turmas(id_turma),
    status VARCHAR(20),
    nota_final NUMERIC(4,2)
);

-- Inserts de Exemplo para Alunos
INSERT INTO educacional.alunos (nome, email, curso, data_ingresso, status_academico) VALUES
('Lucas Pereira', 'lucas.pereira@edu.com', 'Engenharia de Software', '2022-02-10', 'Ativo'),
('Mariana Costa', 'mariana.costa@edu.com', 'Administração', '2023-03-05', 'Ativo'),
('Thiago Silva', 'thiago.silva@edu.com', 'Ciência de Dados', '2022-08-20', 'Inativo');

-- Inserts de Exemplo para Disciplinas
INSERT INTO educacional.disciplinas (nome_disciplina, carga_horaria, departamento) VALUES
('Banco de Dados', 60, 'Tecnologia'),
('Marketing Digital', 40, 'Administração'),
('Estatística Aplicada', 50, 'Matemática');

-- Inserts de Exemplo para Professores
INSERT INTO educacional.professores (nome, email, departamento) VALUES
('Paulo Souza', 'paulo.souza@edu.com', 'Tecnologia'),
('Fernanda Lima', 'fernanda.lima@edu.com', 'Administração'),
('Roberto Alves', 'roberto.alves@edu.com', 'Matemática');

-- Inserts de Exemplo para Turmas
INSERT INTO educacional.turmas (id_disciplina, id_professor, semestre, ano) VALUES
(1, 1, '2024/1', 2024),
(2, 2, '2024/1', 2024),
(3, 3, '2024/1', 2024);

-- Inserts de Exemplo para Matrículas
INSERT INTO educacional.matriculas (id_aluno, id_turma, status, nota_final) VALUES
(1, 1, 'Cursando', NULL),
(2, 2, 'Aprovado', 8.5),
(3, 3, 'Reprovado', 4.0);
