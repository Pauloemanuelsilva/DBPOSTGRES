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