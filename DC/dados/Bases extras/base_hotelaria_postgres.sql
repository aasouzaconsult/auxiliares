
-- Base de Hotelaria com Serviços de Transfer e Passeios - PostgreSQL

CREATE SCHEMA IF NOT EXISTS hotelaria;

CREATE TABLE hotelaria.hospedes (
    id_hospede SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    data_nascimento DATE,
    nacionalidade VARCHAR(50)
);

CREATE TABLE hotelaria.quartos (
    id_quarto SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    capacidade INT,
    preco_diaria NUMERIC(10,2)
);

CREATE TABLE hotelaria.reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_hospede INT REFERENCES hotelaria.hospedes(id_hospede),
    id_quarto INT REFERENCES hotelaria.quartos(id_quarto),
    data_checkin DATE,
    data_checkout DATE,
    status_reserva VARCHAR(20)
);

CREATE TABLE hotelaria.servicos (
    id_servico SERIAL PRIMARY KEY,
    descricao VARCHAR(100),
    tipo_servico VARCHAR(30), -- Ex: Transfer, Passeio, Outros
    preco NUMERIC(10,2)
);

CREATE TABLE hotelaria.consumo_servicos (
    id_consumo SERIAL PRIMARY KEY,
    id_reserva INT REFERENCES hotelaria.reservas(id_reserva),
    id_servico INT REFERENCES hotelaria.servicos(id_servico),
    data_consumo DATE,
    quantidade INT
);

-- Inserts de Exemplo para Hóspedes
INSERT INTO hotelaria.hospedes (nome, cpf, data_nascimento, nacionalidade) VALUES
('Fernanda Silva', '123.456.789-00', '1990-05-10', 'Brasileira'),
('Carlos Almeida', '987.654.321-00', '1985-08-25', 'Brasileira'),
('Luciana Costa', '456.789.123-00', '1992-11-30', 'Portuguesa');

-- Inserts de Exemplo para Quartos
INSERT INTO hotelaria.quartos (tipo, capacidade, preco_diaria) VALUES
('Standard', 2, 150.00),
('Luxo', 3, 300.00),
('Suíte Master', 4, 500.00);

-- Inserts de Exemplo para Reservas
INSERT INTO hotelaria.reservas (id_hospede, id_quarto, data_checkin, data_checkout, status_reserva) VALUES
(1, 2, '2024-06-01', '2024-06-05', 'Concluída'),
(2, 1, '2024-06-10', '2024-06-12', 'Cancelada'),
(3, 3, '2024-07-01', '2024-07-07', 'Confirmada');

-- Inserts de Exemplo para Serviços
INSERT INTO hotelaria.servicos (descricao, tipo_servico, preco) VALUES
('Transfer Aeroporto-Hotel', 'Transfer', 80.00),
('City Tour Fortaleza', 'Passeio', 150.00),
('Passeio Beach Park', 'Passeio', 200.00),
('Serviço de Quarto', 'Outros', 50.00);

-- Inserts de Exemplo para Consumo de Serviços
INSERT INTO hotelaria.consumo_servicos (id_reserva, id_servico, data_consumo, quantidade) VALUES
(1, 1, '2024-06-01', 1),
(1, 2, '2024-06-02', 2),
(3, 3, '2024-07-03', 1),
(3, 4, '2024-07-04', 3);
