-- Tabela de Permissões
CREATE TABLE Permissoes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT
);

-- Tabela de Usuários
CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    permissao_id INTEGER REFERENCES Permissoes(id)
);

-- Tabela de Clientes
CREATE TABLE Clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

-- Tabela de Categorias
CREATE TABLE Categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    categoria_id INTEGER REFERENCES Categorias(id)
);

-- Tabela de Clientes_Produtos (tabela de junção para relacionamento muitos-para-muitos)
CREATE TABLE Clientes_Produtos (
    cliente_id INTEGER REFERENCES Clientes(id),
    produto_id INTEGER REFERENCES Produtos(id),
    PRIMARY KEY (cliente_id, produto_id)
);

-- Tabela de Formas de Pagamento
CREATE TABLE FormasPagamento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT
);
  

-- Inserindo dados de exemplo para Permissoes
INSERT INTO Permissoes (nome, descricao) VALUES
('admin', 'Administrador do sistema'),
('vendedor', 'Vendedor com acesso limitado'),
('cliente', 'Cliente com acesso ao próprio perfil');

-- Inserindo dados de exemplo para Usuarios
INSERT INTO Usuarios (nome, email, senha, permissao_id) VALUES
('Administrador', 'admin@sisvendas.com', 'senha123', 1),
('Vendedor 1', 'vendedor1@sisvendas.com', 'senha456', 2),
('Cliente 1', 'cliente1@sisvendas.com', 'senha789', 3);

-- Inserindo dados de exemplo para Clientes
INSERT INTO Clientes (nome, email, telefone, endereco) VALUES
('Cliente A', 'clientea@email.com', '1234-5678', 'Rua A, 123'),
('Cliente B', 'clienteb@email.com', '9876-5432', 'Rua B, 456'),
('Cliente C', 'clientec@email.com', '1111-2222', 'Rua C, 789');

-- Inserindo dados de exemplo para Categorias
INSERT INTO Categorias (nome, descricao) VALUES
('Eletrônicos', 'Produtos eletrônicos em geral'),
('Vestuário', 'Roupas e acessórios'),
('Alimentos', 'Produtos alimentícios');

-- Inserindo dados de exemplo para Produtos
INSERT INTO Produtos (nome, descricao, preco, categoria_id) VALUES
('Smartphone', 'Smartphone com câmera de alta resolução', 1200.00, 1),
('Camiseta', 'Camiseta de algodão', 50.00, 2),
('Arroz', 'Arroz branco tipo 1', 10.00, 3),
('Notebook', 'Notebook com processador Intel Core i7', 3500.00, 1);

-- Inserindo dados de exemplo para Clientes_Produtos
INSERT INTO Clientes_Produtos (cliente_id, produto_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Inserindo dados de exemplo para FormasPagamento
INSERT INTO FormasPagamento (nome, descricao) VALUES
('Cartão de crédito', 'Pagamento com cartão de crédito'),
('Boleto bancário', 'Pagamento com boleto bancário'),
('Pix', 'Pagamento instantâneo via Pix');

-- Procedure para atualizar o preço de um produto
CREATE OR REPLACE PROCEDURE atualizar_preco_produto(
    produto_id INT,
    novo_preco DECIMAL(10, 2)
) 
LANGUAGE plpgsql
AS $$
begin 
    UPDATE Produtos 
    SET preco = novo_preco 
    WHERE id = produto_id; 

    -- Aqui você pode adicionar mais lógica, como logs ou notificações.
    RAISE NOTICE 'Preço do produto % atualizado para %', produto_id, novo_preco;

    -- Confirma a transação
    COMMIT; 
END;
$$; 

-- Executando a procedure para atualizar o preço de um produto
CALL atualizar_preco_produto(1, 1300.00); 

-- Criação da tabela LogPrecosProdutos
CREATE TABLE LogPrecosProdutos (
    id SERIAL PRIMARY KEY,
    produto_id INT,
    preco_antigo DECIMAL(10, 2),
    preco_novo DECIMAL(10, 2),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Função para registrar alterações de preço
CREATE OR REPLACE FUNCTION registrar_alteracao_preco()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$ 
BEGIN
    IF NEW.preco <> OLD.preco THEN
        INSERT INTO LogPrecosProdutos (produto_id, preco_antigo, preco_novo)
        VALUES (OLD.id, OLD.preco, NEW.preco);
    END IF;
    RETURN NEW;
END;
$$;

-- Trigger para registrar alterações nos preços dos produtos
CREATE TRIGGER trigger_alteracao_preco
AFTER UPDATE OF preco ON Produtos
FOR EACH row 
EXECUTE FUNCTION registrar_alteracao_preco();


select * from LogPrecosProdutos;

--Criar View Consulta pre pronta de categorização de dados
create or replace view ProdutosPorCategoriaComContagemClientes as 
select
    c.nome as categoria,
    p.nome as produto,
    count(cp.cliente_id) as numero_de_clientes
from
    categorias c 
join
    produtos p on c.id = p.categoria_id 
 left join 
    clientes_produtos cp on p.id = cp.produto_id 
group by 
    c.nome, p.nome 
order by 
    c.nome, p.nome; 
    
   select * from ProdutosPorCategoriaComContagemClientes;
   