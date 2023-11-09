# Aulão SQL

## Quizzes
- [Modelagem](https://quizeiro.games/aasouzaconsult/quiz-modelagem-dados)
- [SQL](https://quizeiro.games/aasouzaconsult/sql-quiz)
- [DML](https://quizeiro.games/aasouzaconsult/quiz-dml-comandos)

## Parte 1: Crie o Banco de dados
Banco de dados: db_aulao_sql

## Parte 2: Tabela de Clientes

1. Crie uma tabela chamada "clientes" para armazenar informações sobre clientes.

2. A tabela "clientes" deve ter as seguintes colunas:
   - `id_cliente`: Uma coluna que atua como chave primária (PRIMARY KEY) e é do tipo SERIAL. Esta coluna será usada para identificar de forma exclusiva cada cliente e será incrementada automaticamente com cada nova entrada.
   - `nome`: Uma coluna do tipo VARCHAR(100), usada para armazenar o nome do cliente. O tamanho máximo do nome é de 100 caracteres.
   - `email`: Uma coluna do tipo VARCHAR(150), usada para armazenar o endereço de e-mail do cliente. O tamanho máximo do e-mail é de 150 caracteres.
   - `telefone`: Uma coluna do tipo VARCHAR(15), usada para armazenar o número de telefone do cliente. O tamanho máximo do número de telefone é de 15 caracteres.
   - `data_nascimento`: Uma coluna do tipo DATE, usada para armazenar a data de nascimento do cliente.

## Parte 3: Tabela de Compras

3. Crie uma tabela chamada "compras" para armazenar informações sobre compras feitas pelos clientes.

4. A tabela "compras" deve ter as seguintes colunas:
   - `id_compra`: Uma coluna que atua como chave primária (PRIMARY KEY) e é do tipo SERIAL. Esta coluna será usada para identificar de forma exclusiva cada compra e será incrementada automaticamente com cada nova entrada.
   - `id_cliente`: Uma coluna do tipo INTEGER que é uma chave estrangeira para a tabela cliente.
   - `produto`: Uma coluna do tipo VARCHAR(100), usada para armazenar o nome do produto comprado. O tamanho máximo do nome do produto é de 100 caracteres.
   - `valor`: Uma coluna do tipo NUMERIC(10, 2), usada para armazenar o valor da compra. O valor é armazenado com duas casas decimais e pode ter até 10 dígitos no total.
   - `data_compra`: Uma coluna do tipo DATE, usada para armazenar a data da compra.
   - `Não esquecer de criar a FOREIGN`

## Parte 4: Insira dados em ambas as tabelas
- Insira 5 clientes (com códigos de 1 a 5)
- Insira 10 compras

## Parte 5: Atualizar
- Atualize o nome do Cliente de Código 3 para `Sam Altman`

## Parte 6: Insira dados em cliente
- Insira mais 2 clientes (código 6 e 7)

## Parte 7: Delete
- Delete o registro do cliente de código 6

## Parte 8: Consultas
- Consulta para retornar o nome do cliente e o e-mail (use alias)
- Consulta para retornar o nome do cliente de código 1.
- Consulta para retornar as compras (todas as informações de compra) feitas pelos clientes 3 e 4.
- Consulta para retornar a contagem de clientes (quantos clientes tem?)
- Somatório do Valor de compra por Produto
- Somatório do Valor de compra por Cliente
- Uma consulta retornando o id_compra, o mês, o ano.
- No nome do cliente, onde tiver A, substitua por B.

## Parte 9: Desfazendo o cenário
- Apagar as 2 tabelas
- Apagar o Banco de dados

## Parte 10: Refazer
- 3 min para refazer