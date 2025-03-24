CREATE TABLE funcionario3 (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Idade INT,
    Salario DECIMAL(10, 2),
    Email VARCHAR(255) 
);

-- Selecionando todos os dados da tabela funcionario3
SELECT * FROM funcionario3;

-- Criação da tabela produtos
CREATE TABLE produtos (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2)
);

-- Selecionando todos os dados da tabela produtos
SELECT * FROM produtos;

-- Criação da tabela clientes
CREATE TABLE clientes (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    idade INT,
    Email VARCHAR(255)
);

-- Selecionando todos os dados da tabela clientes
SELECT * FROM clientes;

-- Criação da tabela pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER REFERENCES produtos(id),
    cliente_id INTEGER REFERENCES clientes(id),
    funcionario_id INTEGER REFERENCES funcionario3(id)
);

-- Selecionando todos os dados da tabela pedidos
SELECT * FROM pedidos;

CREATE OR REPLACE PROCEDURE aumentar_preco_produtos(percentual DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN 
    UPDATE produtos
    SET preco = preco * (1 + percentual / 100);
END;
$$;

-- Chamando o procedimento para aumentar o preço em 10%
CALL aumentar_preco_produtos(10);

delete from clientes where idade < 18;

update clientes set email = 'novo_email@exemplo.com' where id = 1;

insert into produtos (nome, preco) values ('nootbook', 2500.00);

select Nome , Salario 
from funcionario3
where DepartamentoID = 1;

select clientes.nome, pedidos.quantidade, produtos. nome
from clientes
join pedidos on clientes.id = pedidos.cliente_id
join produtos on pedidos.produto_id = produtos.id;

select produto_id, count(*) from pedidos group by produto_id;

select nome, preco from produtos order by preco desc;

select nome from clients where nome like 'A%';
