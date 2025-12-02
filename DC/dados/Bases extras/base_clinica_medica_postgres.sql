
-- Base de Clínica Médica - PostgreSQL

CREATE SCHEMA IF NOT EXISTS clinica;

CREATE TABLE clinica.pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    sexo VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(2)
);

CREATE TABLE clinica.medicos (
    id_medico SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(50)
);

CREATE TABLE clinica.consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_paciente INT REFERENCES clinica.pacientes(id_paciente),
    id_medico INT REFERENCES clinica.medicos(id_medico),
    data_consulta DATE,
    horario TIME,
    status_consulta VARCHAR(20) -- Realizada, Cancelada, Não Compareceu
);

CREATE TABLE clinica.exames (
    id_exame SERIAL PRIMARY KEY,
    descricao VARCHAR(100),
    tipo_exame VARCHAR(50) -- Laboratorial, Imagem, Outros
);

CREATE TABLE clinica.solicitacoes_exames (
    id_solicitacao SERIAL PRIMARY KEY,
    id_consulta INT REFERENCES clinica.consultas(id_consulta),
    id_exame INT REFERENCES clinica.exames(id_exame),
    data_solicitacao DATE
);

-- Inserts de exemplo - Pacientes
INSERT INTO clinica.pacientes (nome, data_nascimento, sexo, cidade, estado) VALUES
('Ana Souza', '1990-05-15', 'Feminino', 'Fortaleza', 'CE'),
('Carlos Lima', '1985-08-20', 'Masculino', 'São Paulo', 'SP'),
('Mariana Costa', '1992-12-10', 'Feminino', 'Recife', 'PE');

-- Inserts de exemplo - Médicos
INSERT INTO clinica.medicos (nome, especialidade) VALUES
('Dr. João Silva', 'Cardiologia'),
('Dra. Fernanda Alves', 'Ginecologia'),
('Dr. Pedro Rocha', 'Ortopedia');

-- Inserts de exemplo - Consultas
INSERT INTO clinica.consultas (id_paciente, id_medico, data_consulta, horario, status_consulta) VALUES
(1, 1, '2024-06-10', '09:00', 'Realizada'),
(2, 2, '2024-06-11', '10:30', 'Cancelada'),
(3, 3, '2024-06-12', '11:00', 'Não Compareceu');

-- Inserts de exemplo - Exames
INSERT INTO clinica.exames (descricao, tipo_exame) VALUES
('Hemograma Completo', 'Laboratorial'),
('Ultrassonografia', 'Imagem'),
('Raio-X de Tórax', 'Imagem');

-- Inserts de exemplo - Solicitações de Exames
INSERT INTO clinica.solicitacoes_exames (id_consulta, id_exame, data_solicitacao) VALUES
(1, 1, '2024-06-10'),
(1, 3, '2024-06-10'),
(2, 2, '2024-06-11');
