-Criacao da tabela livros-
create table livros(
    ID_Livro SERIAL primary key,
    Titulo varchar(255),
    Autor varchar(255),
    Editora varchar(255),
    Endereco_Editora varchar(255),
    Categoria varchar(255)

);

-Criação da tabela Editoras-
create table Editoras(
    ID_Editora SERIAL primary key,
    Nome varchar(255),
    Endereco varchar(255)
);

-Criação de relacionamento livros - Endereço-
alter table livros 
add column ID_Editora INT references Editora(ID_Editora);

-Exclusão de colunas Editoras e Endereço-
alter table livros 
drop column Editora,
drop column Endereco_Editora;

-Criação de tabela Categorias-
create table Categorias(
    ID_Categoria SERIAL primary key,
    Nome varchar(255)
    
);

-Criar- Relacionamento livros - Categorias-
alter table livros 
add column ID_Categoria INT references Categorias(ID_Categoria);

-Criação da tabela Autor-
create table Autores(
     ID_Autor SERIAL primary key,
     Nome varchar(255)
);

-Criar- Relacionamento livros - Autor-
alter table livros 
add column ID_Autor INT references Autores(ID_Autor);

 
 
 
 

insert into livros(titulo, id_editora, id_categoria, id_autor) values
('Leviatan', 2,5,2),
('Imperador Magico' ,3,3,4),
('Solo Leveling', 3,2,1);

insert into editoras (nome, endereco) values
('Amostradinho', 'Rua cheia de agua n° 125'),
('Cheia de Graça', 'Rhuam Feliz Alameda Contente n° 123'),
('Ambrosio', 'Rua Marques de Figueredo n°1502');

insert into Categorias(Nome) values
('Ficção'),
('Romance'),
('Ação'),
('Policial'),
('Auto Ajuda'),
('Fantasia');

insert into Autores(Nome) values 
('Echiro Oda'),
('Akira Toriama'),
('Amostradinho da Silva'),
('Paulo o  Fodão dos Games'),
('Dava jonas Zerei Todos os Jogos');

insert into livros (Titulo, id_editora, id_categoria, id_autor)
   values 
   ('one piece red',
   (select id_editora from  editoras where nome = 'Amostradinho'),
   (select id_categoria from categorias where nome = 'Ficção'),
   (select id_autor from autores where nome = 'Paulo o  Fodão dos Games')
   );
  
 insert into livros(titulo, id_editora , id_categoria, id_autor) values
 ('Black Clover', 2,1,1);
  
 insert into editoras (nome, endereco) values
('Shueisha', 'Japão');

insert into Autores(Nome) values
('Yūki Tabata');

insert into livros (Titulo, id_editora , id_categoria  , id_autor)
   values 
   ('Black Clover',
   (select id_editora from  editoras where nome = 'Shueisha'),
   (select id_categoria from categorias where nome = 'Ação'),
   (select id_autor from autores where nome = 'Yūki Tabata')
   );

-Mostra dados-
select * from Categorias c;
select * from Autores a;
select * from Editoras e;
select * from livros l;



select * from livros ;
select Titulo from livros 1 where Titulo = 'one piece red';
select Titulo from livros 1 where id_categoria  = 1;
select Titulo from livros 1 order by titulo asc;
select Titulo from livros 1 order by titulo desc;
select Titulo from livros 1 limit 2;

-join-
select livros.titulos, autores.nome 
from livros 
inner join autores aon livros


select * categorias c;
select * autores a;


ação da tabela Editoras
create table Editoras(
    ID_Editora SERIAL primary key,
    Nome varchar(255),
    Endereco varchar(255)
);

-- Criação da tabela Categorias
create table Categorias(
    ID_Categoria SERIAL primary key,
    Nome varchar(255)
);

-- Criação da tabela Autores
create table Autores(
    ID_Autor SERIAL primary key,
    Nome varchar(255)
);

-- Criação da tabela Livros com a estrutura inicial
create table Livros(
    ID_Livro SERIAL primary key,
    Titulo varchar(255),
    ID_Editora INT references Editoras(ID_Editora),  -- Relacionamento com a tabela Editoras
    ID_Categoria INT REFERENCES Categorias(ID_Categoria),  -- Relacionamento com a tabela Categorias
    ID_Autor INT REFERENCES Autores(ID_Autor)  -- Relacionamento com a tabela Autores
);

-- Exclusão de colunas Editora e Endereco_Editora da tabela Livros
alter table livros 
drop column Editora,
drop column Endereco_Editora;



-- Inserir dados na tabela Editoras
insert into editoras (nome, endereco) values
('Shueisha', 'Japão'),
('Webnovel', 'Coreia'),
('NewPOP', 'Brasil');

-- Inserir dados na tabela Categorias
insert into categorias (nome) values
('Ação'),
('Aventura'),
('Ficção'),
('Fantasia'),
('Shonen'); 

-- Inserir dados na tabela Autores
insert into autores (nome) values
('Echiro Oda'),        
('Akira Toriyama'),    
('Chu-Gong'),          
('Yūki Tabata');       

-- Inserir dados na tabela Livros com valores de IDs diretos
insert into livros (titulo, id_editora, id_categoria, id_autor) values
('Leviathan', 2, 5, 3),         
('Imperador Mágico', 2, 3, 4),   
('Solo Leveling', 2, 1, 3),      
('One Piece', 2, 1, 1),           
('Dragon Ball', 2, 1, 2),         
('Black Clover', 2, 1, 4); 

-- Inserir dados na tabela Livros com valores corretos usando subconsultas
insert into livros(titulo, id_editora, id_categoria, id_autor)
values
('Black Clover',
	(select id_editora from editoras where nome = 'Shueisha'),  
    (select id_categoria from categorias where nome = 'Shonen'), 
    (select id_autor from autores where nome = 'Yūki Tabata')
);

-- Mostrar dados
select * from categorias c;
select * from autores a;
select * from editoras e;
select * from livros l;



-- Consultas simples
select titulo from livros where titulo = 'one piece red';
select titulo from livros where id_categoria = 1;
select titulo from livros order by titulo asc;
select titulo from livros order by titulo desc;
select titulo from livros limit 2;

-- Retorna registros que correspondem em ambas as tabelas (INNER JOIN)
select livros.titulo, autores.nome 
from livros 
inner join autores on livros.id_autor = autores.id_autor;

-- Retorna registros da tabela esquerda (Livros) e registros da tabela direita (Autores) (LEFT JOIN)
select livros.titulo, autores.nome
from livros
left join autores on livros.id_autor = autores.id_autor;

-- Retorna registros da tabela direita (Autores) e registros da tabela esquerda (Livros) (RIGHT JOIN)
select livros.titulo , autores.nome
from livros
right join autores on livros.id_autor = autores.id_autor;

-- Retorna todos os registros quando há uma correspondência (FULL OUTER JOIN)
select livros.titulo , autores.nome
from livros
full outer join autores on livros.id_autor = autores.id_autor;

-- Consultas com múltiplos joins para incluir dados de Editoras, Categorias e Autores
select livros.titulo, autores.nome, categorias.nome as categoria, editoras.nome as editora
from livros
inner join autores on livros.id_autor = autores.id_autor
inner join categorias on livros.id_categoria = categorias.id_categoria
inner join editoras on livros.id_editora = editoras.id_editora;



-Funções de agregação-
-COUNT-

select COUNT(*) from livros;

-SUM-
select SUM(preco) from livros;

alter table livros 
add column preco DECIMAL;

-AVG-

select avg(preco) from livros; 

-MAX-

select MAX(preco) from livros;

-MIN-

select MIN(preco) from livros;

-GROUP BY-

select preco, COUNT(*) from livros group by preco;