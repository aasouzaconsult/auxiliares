<!-- Imagem redimensionada -->
<img src="https://ehgomes.com.br/wp-content/uploads/2023/08/banco-de-dados-relacionais.webp" alt="texto alt" width="600">

# Desafio ERP (Inicial)
Cliente sente tem a necessidade de criar um banco de dados para armazenar os cadastros de `Vendas`, `Vendedores`, `Produtos`, `Clientes` e os `Itens de Vendas` realizadas em seu estabelecimento.

## Status
![Badge em Desenvolvimento](https://img.shields.io/static/v1?label=STATUS&message=FINALIZADO&color=GREEN&style=for-the-badge)

# Iniciando Banco de Dados 

## Projeto de Modelagem Lógica e Conceitual e Criação do Banco de Dados 📚💾

Neste projeto, vamos explorar o processo de criação de um banco de dados relacional para gerenciar informações sobre Vendas, Vendedores, Clientes, Produtos e os Itens de Vendas. Seguiremos os passos desde a modelagem conceitual até a implementação do banco de dados.

## Sobre
Este projeto visa demonstrar a modelagem conceitual, lógica e física de um banco de dados fictício. Através deste repositório, você encontrará informações sobre a história dos bancos de dados, suas funcionalidades, pré-requisitos e um exemplo de modelagem de tabela.
Neste projeto, estaremos criando um banco de dados para uma cliente fictícia. O sistema permitirá o gerenciamento de informações sobre Vendas, Vendedores, Clientes, Produtos e os Itens de Vendas.

## História do Banco de Dados 📜
Os bancos de dados desempenham um papel crucial na organização e recuperação de informações. Sua história remonta aos primórdios da computação, quando sistemas primitivos de armazenamento de dados eram utilizados. Desde então, evoluíram significativamente e desempenham um papel vital em todas as esferas da tecnologia.Nosso projeto se baseia em conceitos modernos de bancos de dados relacionais.

## Funcionalidades 💡
- Armazenamento de dados estruturados.
- Recuperação eficiente de informações.
- Manutenção de integridade dos dados.
- Gerenciamento de transações.
- Controle de acesso e segurança dos dados.

## Breve descrição das tabelas 🧩

- **Tabela: Vendas** 📚
  - Armazena informações sobre as Vendas, incluindo data, código do cliente, código do vendedor

- **Tabela: Produtos** ✍️
  - Contém informações sobre os produtos.

- **Tabela: Vendedores** 👥
  - Armazena dados os Vendedores, como nome e código do Vendedor.

- **Tabela: Clientes** 🙎
  - Registra as informações dos Clientes.

- **Tabela: Item da Venda** 🛒
  - Registra as informações dos itens comprados na venda, incluindo código do produto, o valor e o quantidade.

## Pré-requisitos 🛠️
Antes de iniciar este projeto, você deve ter:

- Conhecimento básico em bancos de dados relacionais.
- Um sistema de gerenciamento de banco de dados (SGBD) instalado, como MySQL, PostgreSQL ou SQLite.
- Ferramenta para modelagem de banco de dados nesse foi usado o [brmodeloweb](https://app.brmodeloweb.com/#!/)


# 🏁 Começando 🚀

##  Modelagem de Dados
Modelagem de dados é o processo de criar uma representação visual, ou esquema, que define os sistemas de coleta e gerenciamento de informações de qualquer organização.

## Conceitual
É a análise dos elementos e fenômenos relevantes de uma realidade observada ou imaginada e a posterior formação de um modelo abstrato do corpo de conhecimento adquirido: o Modelo Entidade-Relacionamento ou MER

![](https://blogdozouza.files.wordpress.com/2023/10/conceitual-1.png)

## Lógica
Descreve como os dados serão armazenados no banco e também seus relacionamentos. Esse modelo adota alguma tecnologia, pode ser: relacional, orientado a objetos, orientado a colunas, entre outros. Os modelos lógicos basicamente determinam se todos os requisitos do negócio foram reunidos.

![](https://blogdozouza.files.wordpress.com/2023/10/logica-1.png)

## Fisica
Todas as informações coletadas são convertidas em modelos relacionais e modelos de negócios. Durante a modelagem física, os objetos são definidos em um nível denominado nível de esquema. Um esquema é considerado um grupo de objetos que estão relacionados entre si em um banco de dados (`Postgres`).

- Criando Banco de Dados

```sql
CREATE DATABASE Erp_inicial ;
```

- Criando as tabelas do banco de dados :pencil:
  - Vendas
    ```sql
    CREATE TABLE Tbven ( 
        cdven INT PRIMARY KEY,
        dtven DATE NOT NULL,
        cdvdd INT NOT NULL,  
        cdcli INT NOT NULL
    );
    ```

  - Clientes (desmembrada da Vendas)
    ```sql
    CREATE TABLE tbcli ( 
        cdcli INT PRIMARY KEY,  
        nmcli VARCHAR (50) NOT NULL  
    );
    ```
    
  - Itens de Vendas
    ```sql
    CREATE TABLE Tbvenite ( 
        cdvenite INT PRIMARY KEY,  
        cdven    INT NOT NULL,
        cdpro    INT NOT NULL,  
        qtven    INT NOT NULL
    );
    ```
  - Produtos
    ```sql
    CREATE TABLE Tbpro ( 
        cdpro INT PRIMARY KEY,
        nmpro VARCHAR (70) NOT NULL,
        tppro VARCHAR (20) NOT NULL        
    ); 

    ```
  - Vendedores
    ```sql
    CREATE TABLE Tbvdd ( 
        cdvdd INT PRIMARY KEY,
        nmvdd VARCHAR (70) NOT NULL
    ); 
    ```

  - Relacionamentos (`Foreign Keys`)
    ```sql
    ALTER TABLE Tbven    ADD FOREIGN KEY(cdvdd) REFERENCES Tbvdd (cdvdd)
    ALTER TABLE Tbven    ADD FOREIGN KEY(cdcli) REFERENCES tbcli (cdcli)
    ALTER TABLE Tbvenite ADD FOREIGN KEY(cdpro) REFERENCES Tbpro (cdpro)
    ALTER TABLE Tbvenite ADD FOREIGN KEY(cdven) REFERENCES Tbven (cdven)
    ```

- Alimentado o Banco de dados :cyclone:
  - INSERINDO CLIENTES
     ```sql
     INSERT INTO tbcli (cdcli, nmcli) VALUES (1, 'Cliente A') ;
     INSERT INTO tbcli (cdcli, nmcli) VALUES (2, 'Cliente B') ;
     -- Adicionem mais 3 clientes
     ```

  - INSERINDO PRODUTOS
    ```sql
    INSERT INTO tbpro (cdpro, nmpro, tppro) VALUES (1, 'FEIJÃO PAI ANTONIO', 'Tipo A') ;
    INSERT INTO tbpro (cdpro, nmpro, tppro) VALUES (2, 'Arroz Integral'    , 'Tipo C') ;
    -- Adicionem mais 3 produtos
    ```

  - INSERINDO VENDEDORES
    ```sql
    INSERT INTO tbvdd (cdvdd, nmvdd) VALUES (1, 'Alex') ;
    INSERT INTO tbvdd (cdvdd, nmvdd) VALUES (2, 'Souza') ;
    -- Adicionem mais 3 vendedores
    ```

  - INSERINDO VENDAS
    ```sql
    INSERT INTO tbven (cdven, dtven, cdvdd, cdcli) VALUES (1, '20231004', 1, 2) ;
    INSERT INTO tbven (cdven, dtven, cdvdd, cdcli) VALUES (2, '20231005', 2, 1) ;
    -- Adicionem mais 3 vendas
    ```

  - INSERINDO ITEM VENDA
    ```sql
    INSERT INTO Tbvenite (cdvenite, cdven, cdpro, qtven) VALUES (1, 1, 2, 8);
    INSERT INTO Tbvenite (cdvenite, cdven, cdpro, qtven) VALUES (2, 1, 1, 10);
    INSERT INTO Tbvenite (cdvenite, cdven, cdpro, qtven) VALUES (3, 2, 1, 8);
    INSERT INTO Tbvenite (cdvenite, cdven, cdpro, qtven) VALUES (4, 2, 2, 10);
    -- Inserir mais 11 itens de vendas
    ```

- Consultando o banco de dados :skull_and_crossbones:
  - Clientes
    ```sql
    SELECT * FROM tbcli ;
    ```
    ![](https://blogdozouza.files.wordpress.com/2023/10/1.png)

  - Produtos
    ```sql
    SELECT * FROM tbpro;
    ```
    ![](https://blogdozouza.files.wordpress.com/2023/10/2.png)

  - Vendedores
    ```sql
    SELECT * FROM tbvdd;
    ```
    ![](https://blogdozouza.files.wordpress.com/2023/10/3.png)

  - Vendas
    ```sql
    SELECT * FROM tbven;
    ```
    ![](https://blogdozouza.files.wordpress.com/2023/10/4.png)

  - Item de Vendas
    ```sql
    SELECT * FROM tbvenite;
    ```
    ![](https://blogdozouza.files.wordpress.com/2023/10/5.png)

- Relacionamento entre tabelas (façam outro exemplo de relacionamento)
    ```sql
    SELECT * 
      FROM tbven v
      JOIN tbcli c on c.cdcli = v.cdcli;
    ``` 
    ![](https://blogdozouza.files.wordpress.com/2023/10/6.png)


## Dicionário de Dados
Segue o [dicionário](https://blogdozouza.files.wordpress.com/2023/10/dicionario-de-dados.pdf) de dados do banco.

----

## 🎁 Expressões de gratidão

* Compartilhe com outras pessoas esse projeto 📢;
* Quer saber mais sobre o projeto? Entre em contato para tomarmos um :coffee:;
  
[![Autor](https://img.shields.io/badge/Autor-Fulano1-blue.svg)](https://www.linkedin.com/in/alex-souza/)
[![CoAutor](https://img.shields.io/badge/CoAutor-Fulano2-blue.svg)](https://www.linkedin.com/in/alex-souza/)
[![Professor](https://img.shields.io/badge/Professor-AlexSouza-red.svg)](https://www.instagram.com/alexsouzamsc/) 
![Assunto](https://img.shields.io/badge/Assunto-Modelagem-yellow.svg)