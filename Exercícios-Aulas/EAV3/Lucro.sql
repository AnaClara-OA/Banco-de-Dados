create table item (
    cod_item int,
    nome varchar(45) unique not null,
    preco float,
    quantidade int,
    primary key(cod_item),
    check(preco > 0),
    check(quantidade >0)
);

insert into item (cod_item, nome, preco, quantidade) values 
(1,"Arco",20.0,22),
(2,"Flecha",2.0,43),                                                                 
(3,"Espada",35.0,16),                                                                
(4,"Escudo",20.0,20),                                                                
(5,"Maça",23.0,19),                                                                  
(6,"Mangual",56.0,16),                                                               
(7,"Lança",21.0,18),                                                                 
(8,"Machado",20.0,21);


select * from item;

create table item (
    cod_item int,
    nome varchar(45) unique not null,
    preco float,
    quantidade int,
    primary key(cod_item),
    check(preco > 0),
    check(quantidade >= 0)
);

create table venda(
    cod	int primary key,
    data_hora date,
    email_usuario varchar(45)
);

create table item_vendido(
    cod_venda int,
    cod_item int,
    quantidade int,
    primary key(cod_venda, cod_item),
    foreign key(cod_item) references item(cod_item),
    foreign key(cod_venda) references venda(cod)
);

insert into item (cod_item, nome, preco, quantidade) values 
(1,"Arco",20.0,22),
(2,"Flecha",2.0,43),                                                                 
(3,"Espada",35.0,16),                                                                
(4,"Escudo",20.0,20),                                                                
(5,"Maça",23.0,19),                                                                  
(6,"Mangual",56.0,16),                                                               
(7,"Lança",21.0,18),                                                                 
(8,"Machado",20.0,21);

insert into venda (cod, data_hora, email_usuario) values
(1,"2024-05-10 11:22","j@g.com"),
(2,"2024-05-12 11:22","k@g.com"),
(3,"2024-05-13 11:22","a@g.com"),
(4,"2024-05-13 11:22","r@g.com"),
(5,"2024-05-13 11:22","r@g.com"),
(6,"2024-05-14 11:22","f@g.com"),
(7,"2024-05-15 11:22","r@g.com");

insert into item_vendido(cod_venda, cod_item, quantidade) values
(1,1,15),
(1,3,5),
(2,2,2),
(3,5,2),
(4,8,3),
(4,6,2),
(4,1,1),
(5,3,6),
(6,4,7),
(6,3,5),
(7,7,10);

update item set quantidade = quantidade - (
    select sum(quantidade) from item_vendido where item_vendido.cod_item = item.cod_item
);


select cast(avg(quantidade) AS int) 
from item_vendido;

select cod_item
from item_vendido
group by(cod_item)
order by(sum(quantidade)) desc
limit 5;


----------------------------------

create table item (
    cod_item int,
    nome varchar(45) unique not null,
    preco float,
    quantidade int,
    primary key(cod_item),
    check(preco > 0),
    check(quantidade >= 0)
);

create table venda(
    cod	int primary key,
    data_hora date,
    email_usuario varchar(45)
);

create table item_vendido(
    cod_venda int,
    cod_item int,
    quantidade int,
    primary key(cod_venda, cod_item),
    foreign key(cod_item) references item(cod_item),
    foreign key(cod_venda) references venda(cod)
);

insert into item (cod_item, nome, preco, quantidade) values 
(1,"Arco",20.0,22),
(2,"Flecha",2.0,43),                                                                 
(3,"Espada",35.0,16),                                                                
(4,"Escudo",20.0,20),                                                                
(5,"Maça",23.0,19),                                                                  
(6,"Mangual",56.0,16),                                                               
(7,"Lança",21.0,18),                                                                 
(8,"Machado",20.0,21);

insert into venda (cod, data_hora, email_usuario) values
(1,"2024-05-10 11:22","j@g.com"),
(2,"2024-05-12 11:22","k@g.com"),
(3,"2024-05-13 11:22","a@g.com"),
(4,"2024-05-13 11:22","r@g.com"),
(5,"2024-05-13 11:22","r@g.com"),
(6,"2024-05-14 11:22","f@g.com"),
(7,"2024-05-15 11:22","r@g.com");

insert into item_vendido(cod_venda, cod_item, quantidade) values
(1,1,15),
(1,3,5),
(2,2,2),
(3,5,2),
(4,8,3),
(4,6,2),
(4,1,1),
(5,3,6),
(6,4,7),
(6,3,5),
(7,7,10);

update item set quantidade = quantidade - (
    select sum(quantidade) from item_vendido where item_vendido.cod_item = item.cod_item
) where item.cod_item in (
    select item_vendido.cod_item from item_vendido
);


select nome, quantidade from item where quantidade < 10 order by quantidade;

----------------------------------

create table item (
    cod_item int,
    nome varchar(45) unique not null,
    preco float,
    custo float,
    quantidade int,
    primary key(cod_item),
    check(preco > 0),
    check(quantidade >= 0)
);

create table venda(
    cod	int primary key,
    data_hora date,
    email_usuario varchar(45)
);

create table item_vendido(
    cod_venda int,
    cod_item int,
    quantidade int,
    primary key(cod_venda, cod_item),
    foreign key(cod_item) references item(cod_item),
    foreign key(cod_venda) references venda(cod)
);

insert into item (cod_item, nome, preco, custo, quantidade) values 
(1,"Arco",20.0,10,22),
(2,"Flecha",2.0,1,43),                                                                 
(3,"Espada",35.0,20,16),                                                                
(4,"Escudo",20.0,12,20),                                                                
(5,"Maça",23.0,11,19),                                                                  
(6,"Mangual",56.0,35,16),                                                               
(7,"Lança",21.0,16,18),                                                                 
(8,"Machado",20.0,13,21);

insert into venda (cod, data_hora, email_usuario) values
(1,	"2024-05-10 11:22","j@g.com"),
(2,	"2024-05-12 11:22","k@g.com"),
(3,"2024-05-13 11:22","a@g.com"),
(4,	"2024-05-13 11:22","r@g.com"),
(5,	"2024-05-13 11:22","r@g.com"),
(6,	"2024-05-14 11:22","f@g.com"),
(7,	"2024-05-15 11:22","r@g.com");

insert into item_vendido(cod_venda, cod_item, quantidade) values
(1,1,15),
(1,3,5),
(2,2,2),
(3,5,2),
(4,8,3),
(4,6,2),
(4,1,1),
(5,3,6),
(6,4,7),
(6,3,5),
(7,7,10);

update item set quantidade = quantidade - (
    select sum(quantidade) from item_vendido where item_vendido.cod_item = item.cod_item
) where item.cod_item in (
    select item_vendido.cod_item from item_vendido
);


select cast(sum((item.preco - item.custo) * item_vendido.quantidade) as int)
from item_vendido 
join item
on item.cod_item = item_vendido.cod_item;
