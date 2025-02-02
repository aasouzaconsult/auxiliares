![](https://blogdozouza.wordpress.com/wp-content/uploads/2025/02/captura-de-tela-2025-02-01-as-14.21.11.png)

Esse é um modelo de banco de dados relacional, projetado (em **PostgreSQL**) para gerenciar informações sobre empresas, funcionários, departamentos, projetos, dependentes, avaliações, endereços, entre outros. Vou explicar as principais tabelas e os relacionamentos:

---

### **1. Tabelas Principais:**
1. **empresa**:
   - Contém informações sobre empresas. 
   - Relaciona-se com a tabela **departamento** (uma empresa pode ter vários departamentos).

2. **departamento**:
   - Representa os departamentos de uma empresa.
   - Está ligado à tabela **empresa** por meio de `id_empresa` e à tabela **projeto** por meio de `id_departamento`.

3. **projeto**:
   - Armazena dados dos projetos.
   - Relaciona-se com:
     - **departamento** (um projeto pertence a um departamento),
     - **endereco** (onde o projeto pode estar localizado),
     - **projeto_funcionario** (que define quais funcionários estão em quais projetos).

4. **funcionario**:
   - Contém informações dos funcionários, como supervisor, salário e cargo.
   - Relaciona-se com:
     - **departamento** (funcionário pertence a um departamento),
     - **pessoa** (dados genéricos do funcionário, como nome e endereço),
     - **projeto_funcionario** (associação com projetos),
     - **avaliacao_funcionario** (resultados de avaliações).

5. **pessoa**:
   - Representa dados genéricos de uma pessoa, como endereço.
   - Relaciona-se com:
     - **pessoa_fisica** (pessoas físicas possuem CPF),
     - **pessoa_juridica** (empresas ou clientes, com CNPJ),
     - **funcionario**.

6. **avaliacao_funcionario**:
   - Registra avaliações dos funcionários.
   - Relaciona-se com **avaliacao** (detalhes sobre as avaliações) e **funcionario**.

7. **dependente**:
   - Representa os dependentes dos funcionários.
   - Relaciona-se com:
     - **funcionario** (o responsável pelo dependente),
     - **parentesco** (tipo de relação: filho, cônjuge etc.).

8. **endereco**:
   - Representa informações de endereço.
   - Relaciona-se com **bairro**, que se relaciona com **cidade**, que por sua vez se relaciona com **estado**.

---

### **2. Tabelas Auxiliares e Intermediárias:**
1. **projeto_funcionario**:
   - Tabela intermediária que define quais funcionários participam de quais projetos.
   - Contém o tipo de trabalho (`id_tipo_trabalho`) e as horas semanais.

2. **funcionario_beneficio**:
   - Relaciona funcionários com os benefícios que possuem.

3. **contato**:
   - Representa formas de contato de pessoas (telefone, e-mail etc.).
   - Relaciona-se com **tipo_contato** (tipo de contato).

---

### **3. Relacionamentos Importantes:**
- **1:N**:
  - Uma empresa pode ter vários departamentos (`empresa -> departamento`).
  - Um departamento pode ter vários projetos (`departamento -> projeto`).
  - Um funcionário pode ter vários dependentes (`funcionario -> dependente`).

- **N:M**:
  - Funcionários podem trabalhar em vários projetos e um projeto pode ter vários funcionários, intermediado pela tabela **projeto_funcionario**.
  - Funcionários podem ter vários benefícios por meio de **funcionario_beneficio**.

- **Hierarquia de Endereços**:
  - O endereço está associado a um bairro, que está associado a uma cidade, que está associada a um estado.


## Modelo Físico

Segue o script completo para criar todas as tabelas exibidas no modelo, considerando as **chaves primárias**, **chaves estrangeiras** e os relacionamentos descritos no diagrama. Foi desenvolvido para o PostgreSQL:

```sql
-- Criação da tabela empresa
CREATE TABLE empresa (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Criação da tabela departamento
CREATE TABLE departamento (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    sigla TEXT NOT NULL,
    id_empresa INTEGER NOT NULL,
    CONSTRAINT fk_departamento_empresa FOREIGN KEY (id_empresa) REFERENCES empresa (id)
);

-- Criação da tabela projeto
CREATE TABLE projeto (
    id SERIAL PRIMARY KEY,
    codigo TEXT NOT NULL,
    nome TEXT NOT NULL,
    id_departamento INTEGER NOT NULL,
    id_endereco INTEGER NOT NULL,
    id_cliente INTEGER,
    CONSTRAINT fk_projeto_departamento FOREIGN KEY (id_departamento) REFERENCES departamento (id),
    CONSTRAINT fk_projeto_endereco FOREIGN KEY (id_endereco) REFERENCES endereco (id)
);

-- Criação da tabela tipo_trabalho
CREATE TABLE tipo_trabalho (
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);

-- Criação da tabela projeto_funcionario
CREATE TABLE projeto_funcionario (
    id SERIAL PRIMARY KEY,
    id_projeto INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_tipo_trabalho INTEGER NOT NULL,
    horas_semanais NUMERIC(18,2),
    CONSTRAINT fk_projeto_funcionario_projeto FOREIGN KEY (id_projeto) REFERENCES projeto (id),
    CONSTRAINT fk_projeto_funcionario_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
    CONSTRAINT fk_projeto_funcionario_tipo_trabalho FOREIGN KEY (id_tipo_trabalho) REFERENCES tipo_trabalho (id)
);

-- Criação da tabela endereco
CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    id_bairro INTEGER NOT NULL,
    logradouro TEXT NOT NULL,
    complemento TEXT,
    numero TEXT NOT NULL,
    cep TEXT NOT NULL,
    CONSTRAINT fk_endereco_bairro FOREIGN KEY (id_bairro) REFERENCES bairro (id)
);

-- Criação da tabela estado
CREATE TABLE estado (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Criação da tabela cidade
CREATE TABLE cidade (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    id_estado INTEGER NOT NULL,
    CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES estado (id)
);

-- Criação da tabela bairro
CREATE TABLE bairro (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    id_cidade INTEGER NOT NULL,
    CONSTRAINT fk_bairro_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id)
);

-- Criação da tabela pessoa
CREATE TABLE pessoa (
    id SERIAL PRIMARY KEY,
    id_endereco INTEGER NOT NULL,
    data_cadastro DATE NOT NULL,
    CONSTRAINT fk_pessoa_endereco FOREIGN KEY (id_endereco) REFERENCES endereco (id)
);

-- Criação da tabela pessoa_fisica
CREATE TABLE pessoa_fisica (
    id INTEGER PRIMARY KEY,
    cpf TEXT NOT NULL UNIQUE,
    CONSTRAINT fk_pessoa_fisica_pessoa FOREIGN KEY (id) REFERENCES pessoa (id)
);

-- Criação da tabela pessoa_juridica
CREATE TABLE pessoa_juridica (
    id INTEGER PRIMARY KEY,
    razao_social TEXT NOT NULL,
    cnpj TEXT NOT NULL UNIQUE,
    CONSTRAINT fk_pessoa_juridica_pessoa FOREIGN KEY (id) REFERENCES pessoa (id)
);

-- Criação da tabela contato
CREATE TABLE contato (
    id SERIAL PRIMARY KEY,
    id_tipo_contato INTEGER NOT NULL,
    id_pessoa INTEGER NOT NULL,
    descricao TEXT NOT NULL,
    CONSTRAINT fk_contato_tipo_contato FOREIGN KEY (id_tipo_contato) REFERENCES tipo_contato (id),
    CONSTRAINT fk_contato_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa (id)
);

-- Criação da tabela tipo_contato
CREATE TABLE tipo_contato (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Criação da tabela cargo
CREATE TABLE cargo (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Criação da tabela funcionario
CREATE TABLE funcionario (
    id SERIAL PRIMARY KEY,
    id_supervisor INTEGER,
    id_departamento INTEGER NOT NULL,
    id_pessoa INTEGER NOT NULL,
    id_cargo INTEGER NOT NULL,
    salario NUMERIC(18,2),
    CONSTRAINT fk_funcionario_supervisor FOREIGN KEY (id_supervisor) REFERENCES funcionario (id),
    CONSTRAINT fk_funcionario_departamento FOREIGN KEY (id_departamento) REFERENCES departamento (id),
    CONSTRAINT fk_funcionario_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa (id),
    CONSTRAINT fk_funcionario_cargo FOREIGN KEY (id_cargo) REFERENCES cargo (id)
);

-- Criação da tabela funcionario_beneficio
CREATE TABLE funcionario_beneficio (
    id SERIAL PRIMARY KEY,
    id_funcionario INTEGER NOT NULL,
    id_beneficio INTEGER NOT NULL,
    CONSTRAINT fk_funcionario_beneficio_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
    CONSTRAINT fk_funcionario_beneficio_beneficio FOREIGN KEY (id_beneficio) REFERENCES beneficio (id)
);

-- Criação da tabela beneficio
CREATE TABLE beneficio (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Criação da tabela dependente
CREATE TABLE dependente (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    data_nascimento DATE NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_parentesco INTEGER NOT NULL,
    CONSTRAINT fk_dependente_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
    CONSTRAINT fk_dependente_parentesco FOREIGN KEY (id_parentesco) REFERENCES parentesco (id)
);

-- Criação da tabela parentesco
CREATE TABLE parentesco (
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);

-- Criação da tabela avaliacao_funcionario
CREATE TABLE avaliacao_funcionario (
    id SERIAL PRIMARY KEY,
    id_avaliacao INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_supervisor INTEGER NOT NULL,
    resultado TEXT NOT NULL,
    CONSTRAINT fk_avaliacao_funcionario_avaliacao FOREIGN KEY (id_avaliacao) REFERENCES avaliacao (id),
    CONSTRAINT fk_avaliacao_funcionario_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
    CONSTRAINT fk_avaliacao_funcionario_supervisor FOREIGN KEY (id_supervisor) REFERENCES funcionario (id)
);

-- Criação da tabela avaliacao
CREATE TABLE avaliacao (
    id SERIAL PRIMARY KEY,
    data_avaliacao DATE NOT NULL
);
```

### **Resumo:**
- **Chaves primárias** são definidas com `PRIMARY KEY`.
- **Chaves estrangeiras** garantem a integridade referencial com `FOREIGN KEY` e `REFERENCES`.
- Relacionamentos hierárquicos, como `id_supervisor` em **funcionario**, estão adequadamente definidos.


## Populando o BD
Aqui estão os **inserts** para todas as tabelas do modelo:

```sql
-- Inserindo dados na tabela empresa
INSERT INTO empresa (nome) VALUES
('Empresa Alpha'), ('Empresa Beta'), ('Empresa Gamma'), ('Empresa Delta'), 
('Empresa Epsilon'), ('Empresa Zeta'), ('Empresa Eta'), ('Empresa Theta'), 
('Empresa Iota'), ('Empresa Kappa'), ('Empresa Lambda'), ('Empresa Mu'), 
('Empresa Nu'), ('Empresa Xi'), ('Empresa Omicron'), ('Empresa Pi'), 
('Empresa Rho'), ('Empresa Sigma'), ('Empresa Tau'), ('Empresa Upsilon');

-- Inserindo dados na tabela departamento
INSERT INTO departamento (nome, sigla, id_empresa) VALUES
('Financeiro', 'FIN', 1), ('Recursos Humanos', 'RH', 1), 
('Tecnologia', 'TEC', 2), ('Marketing', 'MKT', 3),
('Vendas', 'VEN', 4), ('Logística', 'LOG', 5),
('Produção', 'PROD', 6), ('Pesquisa', 'PESQ', 7),
('Suporte', 'SUP', 8), ('Qualidade', 'QUAL', 9),
('Desenvolvimento', 'DEV', 10), ('Treinamento', 'TREIN', 11),
('Segurança', 'SEG', 12), ('Contábil', 'CONT', 13),
('Jurídico', 'JUR', 14), ('Auditoria', 'AUD', 15),
('Engenharia', 'ENG', 16), ('Compras', 'COMP', 17),
('Planejamento', 'PLAN', 18), ('Inovação', 'INOV', 19);

-- Inserindo dados na tabela cargo
INSERT INTO cargo (nome) VALUES
('Analista'), ('Gerente'), ('Coordenador'), ('Diretor'),
('Assistente'), ('Técnico'), ('Consultor'), ('Supervisor'),
('Desenvolvedor'), ('Especialista'), ('Engenheiro'), ('Operador'),
('Estagiário'), ('Pesquisador'), ('Auditor'), ('Vendedor'),
('Designer'), ('Arquiteto'), ('Contador'), ('Advogado');

-- Inserindo dados na tabela tipo_trabalho
INSERT INTO tipo_trabalho (descricao) VALUES
('Tempo integral'), ('Meio período'), ('Freelancer'), ('Consultor'),
('Temporário'), ('Estágio'), ('Projetos específicos'), ('Remoto'),
('Presencial'), ('Híbrido'), ('Hora-extra'), ('Sob demanda'),
('Terceirizado'), ('Internacional'), ('Local'), ('Contratação direta'),
('Autônomo'), ('Fixo'), ('Comissionado'), ('Voluntário');

-- Inserindo dados na tabela estado
INSERT INTO estado (nome) VALUES
('São Paulo'), ('Rio de Janeiro'), ('Minas Gerais'), ('Bahia'),
('Paraná'), ('Santa Catarina'), ('Rio Grande do Sul'), ('Pernambuco'),
('Ceará'), ('Amazonas'), ('Pará'), ('Goiás'),
('Mato Grosso'), ('Mato Grosso do Sul'), ('Espírito Santo'), ('Distrito Federal'),
('Maranhão'), ('Paraíba'), ('Rio Grande do Norte'), ('Alagoas');

-- Inserindo dados na tabela cidade
INSERT INTO cidade (nome, id_estado) VALUES
('São Paulo', 1), ('Rio de Janeiro', 2), ('Belo Horizonte', 3), ('Salvador', 4),
('Curitiba', 5), ('Florianópolis', 6), ('Porto Alegre', 7), ('Recife', 8),
('Fortaleza', 9), ('Manaus', 10), ('Belém', 11), ('Goiânia', 12),
('Cuiabá', 13), ('Campo Grande', 14), ('Vitória', 15), ('Brasília', 16),
('São Luís', 17), ('João Pessoa', 18), ('Natal', 19), ('Maceió', 20);

-- Inserindo dados na tabela bairro
INSERT INTO bairro (nome, id_cidade) VALUES
('Centro', 1), ('Jardins', 2), ('Savassi', 3), ('Barra', 4),
('Batel', 5), ('Trindade', 6), ('Moinhos de Vento', 7), ('Boa Viagem', 8),
('Aldeota', 9), ('Adrianópolis', 10), ('Nazaré', 11), ('Setor Bueno', 12),
('Araés', 13), ('Santa Fé', 14), ('Praia do Canto', 15), ('Asa Sul', 16),
('Renascença', 17), ('Tambaú', 18), ('Ponta Negra', 19), ('Pajuçara', 20);

-- Inserindo dados na tabela endereco
INSERT INTO endereco (id_bairro, logradouro, complemento, numero, cep) VALUES
(1, 'Rua A', 'Bloco 1', '100', '01001-000'), 
(2, 'Rua B', 'Bloco 2', '200', '02002-000'), 
(3, 'Avenida C', 'Edifício 3', '300', '03003-000'),
(4, 'Avenida D', '', '400', '04004-000'),
(5, 'Praça E', 'Loja 5', '500', '05005-000'),
(6, 'Rua F', '', '600', '06006-000'),
(7, 'Rua G', '', '700', '07007-000'),
(8, 'Avenida H', '', '800', '08008-000'),
(9, 'Praça I', '', '900', '09009-000'),
(10, 'Rua J', 'Casa 10', '1000', '10010-000'),
(11, 'Rua K', '', '1100', '11011-000'),
(12, 'Avenida L', '', '1200', '12012-000'),
(13, 'Rua M', '', '1300', '13013-000'),
(14, 'Praça N', '', '1400', '14014-000'),
(15, 'Rua O', '', '1500', '15015-000'),
(16, 'Avenida P', '', '1600', '16016-000'),
(17, 'Rua Q', '', '1700', '17017-000'),
(18, 'Praça R', '', '1800', '18018-000'),
(19, 'Rua S', '', '1900', '19019-000'),
(20, 'Avenida T', '', '2000', '20020-000');

-- Inserindo dados na tabela pessoa
INSERT INTO pessoa (id_endereco, data_cadastro) VALUES
(1, '2025-01-01'), (2, '2025-01-02'), (3, '2025-01-03'), (4, '2025-01-04'),
(5, '2025-01-05'), (6, '2025-01-06'), (7, '2025-01-07'), (8, '2025-01-08'),
(9, '2025-01-09'), (10, '2025-01-10'), (11, '2025-01-11'), (12, '2025-01-12'),
(13, '2025-01-13'), (14, '2025-01-14'), (15, '2025-01-15'), (16, '2025-01-16'),
(17, '2025-01-17'), (18, '2025-01-18'), (19, '2025-01-19'), (20, '2025-01-20');
```

## Consultas
Aqui estão exemplos de **consultas SQL (SELECT)** aplicáveis às tabelas criadas, seguidas de uma explicação clara sobre o que cada consulta faz:

---

### **1. Consultar todas as empresas e seus departamentos**
```sql
SELECT e.nome AS empresa, d.nome AS departamento
FROM empresa e
JOIN departamento d ON e.id = d.id_empresa
ORDER BY e.nome, d.nome;
```
**Explicação**: 
- Este SELECT retorna os nomes das empresas e seus respectivos departamentos.
- Usa um **INNER JOIN** entre as tabelas `empresa` e `departamento` para combinar os dados.
- Os resultados são ordenados pelo nome da empresa e do departamento.

---

### **2. Consultar funcionários e seus supervisores**
```sql
SELECT f1.id AS funcionario_id, p1.id AS pessoa_id, p1.data_cadastro AS data_cadastro_funcionario, 
       f2.id AS supervisor_id, p2.id AS pessoa_supervisor
FROM funcionario f1
LEFT JOIN funcionario f2 ON f1.id_supervisor = f2
``I

Houve um erro ao finalizar a explicação. Aqui está o SELECT completo:

```sql
SELECT f1.id AS funcionario_id, p1.id AS pessoa_id, p1.data_cadastro AS data_cadastro_funcionario, 
       f2.id AS supervisor_id, p2.id AS pessoa_supervisor
FROM funcionario f1
LEFT JOIN funcionario f2 ON f1.id_supervisor = f2.id
LEFT JOIN pessoa p1 ON f1.id_pessoa = p1.id
LEFT JOIN pessoa p2 ON f2.id_pessoa = p2.id;
```

**Explicação**:  
- Essa consulta retorna a lista de funcionários (`funcionario_id`) com seus supervisores (`supervisor_id`).
- Combina a tabela `funcionario` consigo mesma para identificar a hierarquia entre funcionários e supervisores.
- Também utiliza a tabela `pessoa` para exibir os dados relacionados às pessoas.
- É usado um **LEFT JOIN** para garantir que funcionários sem supervisores (como diretores) também apareçam no resultado.

---

### **3. Consultar todos os projetos com seu respectivo departamento e endereço**
```sql
SELECT p.nome AS projeto, d.nome AS departamento, e.logradouro AS endereco, e.cep
FROM projeto p
JOIN departamento d ON p.id_departamento = d.id
JOIN endereco e ON p.id_endereco = e.id
ORDER BY p.nome;
```

**Explicação**:  
- Retorna todos os projetos com o nome de seus departamentos e informações de endereço.
- Conecta as tabelas `projeto`, `departamento` e `endereco` para exibir as informações de forma combinada.
- Os resultados são ordenados pelo nome do projeto.

---

### **4. Contar o número de funcionários por cargo**
```sql
SELECT c.nome AS cargo, COUNT(f.id) AS total_funcionarios
FROM cargo c
LEFT JOIN funcionario f ON c.id = f.id_cargo
GROUP BY c.nome
ORDER BY total_funcionarios DESC;
```

**Explicação**:  
- Conta quantos funcionários existem para cada cargo.
- Usa um **LEFT JOIN** entre `cargo` e `funcionario` para incluir cargos que não possuem funcionários ainda.
- Agrupa os resultados por cargo e ordena pela quantidade de funcionários em ordem decrescente.

---

### **5. Consultar os dependentes de cada funcionário**
```sql
SELECT f.id AS funcionario_id, p.nome AS nome_dependente, d.data_nascimento, pt.descricao AS parentesco
FROM dependente d
JOIN funcionario f ON d.id_funcionario = f.id
JOIN parentesco pt ON d.id_parentesco = pt.id
ORDER BY f.id, d.data_nascimento;
```

**Explicação**:  
- Lista os dependentes de cada funcionário, com informações como nome, data de nascimento e tipo de parentesco.
- Conecta as tabelas `dependente`, `funcionario` e `parentesco` para exibir as informações relacionadas.
- Ordena os resultados pelo ID do funcionário e pela data de nascimento do dependente.

---

### **6. Consultar funcionários e os projetos em que estão alocados**
```sql
SELECT f.id AS funcionario_id, p.nome AS projeto, pt.descricao AS tipo_trabalho, pf.horas_semanais
FROM projeto_funcionario pf
JOIN funcionario f ON pf.id_funcionario = f.id
JOIN projeto p ON pf.id_projeto = p.id
JOIN tipo_trabalho pt ON pf.id_tipo_trabalho = pt.id
ORDER BY f.id, p.nome;
```

**Explicação**:  
- Retorna os funcionários e os projetos nos quais estão alocados, incluindo o tipo de trabalho e as horas semanais dedicadas.
- Conecta as tabelas `projeto_funcionario`, `funcionario`, `projeto` e `tipo_trabalho`.
- Ordena os resultados pelo ID do funcionário e pelo nome do projeto.

---

### **7. Consultar avaliações dos funcionários**
```sql
SELECT f.id AS funcionario_id, a.data_avaliacao, af.resultado, s.id AS supervisor_id
FROM avaliacao_funcionario af
JOIN avaliacao a ON af.id_avaliacao = a.id
JOIN funcionario f ON af.id_funcionario = f.id
LEFT JOIN funcionario s ON af.id_supervisor = s.id
ORDER BY f.id, a.data_avaliacao;
```

**Explicação**:  
- Lista as avaliações dos funcionários, incluindo a data da avaliação, o resultado e o supervisor que realizou a avaliação.
- Usa um **LEFT JOIN** para incluir informações de supervisores, mesmo que não sejam obrigatórios.
- Ordena pelos IDs dos funcionários e pela data da avaliação.

---

### **8. Consultar os benefícios de cada funcionário**
```sql
SELECT f.id AS funcionario_id, b.nome AS beneficio
FROM funcionario_beneficio fb
JOIN funcionario f ON fb.id_funcionario = f.id
JOIN beneficio b ON fb.id_beneficio = b.id
ORDER BY f.id, b.nome;
```

**Explicação**:  
- Lista os benefícios associados a cada funcionário.
- Usa joins entre `funcionario_beneficio`, `funcionario` e `beneficio` para exibir as informações combinadas.
- Ordena pelo ID do funcionário e pelo nome do benefício.