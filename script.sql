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

