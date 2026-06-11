drop database if exists zoologico;
create database zoologico;
use zoologico;

-- ================================== --
--     TABELAS DO BANCO DE DADOS      --
-- ================================== --

-- Tabela Habitat
create table Habitat (
 id_Habitat int primary key auto_increment, 
    nome varchar(45),
    clima varchar(45), 
    lotacao int, 
    tipo varchar(45)
);

-- Tabel Animal 
create table Animal (
 id_Animal int primary key auto_increment,
    nome varchar(45),
    sexo varchar(10), 
    idade int,
    especie varchar(100), 
    peso double (10, 2), 
    id_habitat int, 
    foreign key (id_habitat) references Habitat(id_Habitat) on delete cascade on update cascade
);


-- Tabela Visitante 
create table Visitante ( 
    id_Visitante int primary key auto_increment,
    nome varchar(45), 
    idade int
    -- numeroVisitante int
);

-- Tabela Ingresso
create table Ingresso ( 
    id_Ingresso int primary key auto_increment,
    data date,
    tipo varchar(45), 
    -- quantidade int, 
    preco double (10, 2),
    id_visitante int, 
    foreign key (id_visitante) references Visitante(id_Visitante) on delete cascade on update cascade
);

-- Tabela Funcionário
create table Funcionario (
    id_Funcionario int primary key auto_increment,
    nome varchar(45) , 
    funcao varchar(100), 
    salario double (10, 2)
);

-- Tabela Consulta Veterinária
create table ConsultaVeterinaria (
    id_ConsultaVeterinaria int primary key auto_increment,
    data date,
    estado_de_saude varchar(45),
    id_animal int,
    id_funcionario int,
    foreign key (id_animal) references Animal(id_Animal) on delete cascade on update cascade,
    foreign key (id_funcionario) references Funcionario(id_Funcionario) on delete cascade on update cascade
);

-- Tabela Alimento
create table Alimento (
	id_Alimento int primary key auto_increment,
    tipo_de_dieta varchar(45), 
    estoque int , 
    nome varchar(45)
);

-- Tabela intermediário entre Alimento e Animal
create table Alimento_has_Animal (
	id_alimento int,
	id_animal int,
	primary key (id_alimento, id_animal),
	foreign key (id_alimento) references Alimento(id_Alimento) on delete cascade on update cascade,
	foreign key (id_animal) references Animal(id_Animal) on delete cascade on update cascade
);

-- Tabela intermediário entre Funcionário e Animal
create table Funcionario_has_Animal (
	id_funcionario int,
	id_animal int,
	primary key (id_funcionario, id_animal),
	foreign key (id_funcionario) references Funcionario(id_Funcionario) on delete cascade on update cascade,
	foreign key (id_animal) references Animal(id_Animal) on delete cascade on update cascade
);

create table Funcionario_has_Habitat (
    id_funcionario int,
    id_habitat int,

    primary key (id_funcionario, id_habitat),

    foreign key (id_funcionario)
        references Funcionario(id_Funcionario)
        on delete cascade
        on update cascade,

    foreign key (id_habitat)
        references Habitat(id_Habitat)
        on delete cascade
        on update cascade
);

-- ================================== --
--          INSERÇÃO DE DADOS         --
-- ================================== --

-- Inserindo dados na tabela Habitat

Insert into Habitat(nome, clima, lotacao, tipo) values
('Floresta Australiana', 'Quente e úmido', 6, 'Aquático-terrestre'),
('Lagoa', 'Temperatura controlada', 40, 'Aquático'),
('Floresta Silvestre', 'Temperatura controlada', 15, 'Terrestre Fechado'),
('Floresta Tropical', 'Quente e úmido', 20, 'Terrestre'),
('Savana', 'Quente e seco', 12, 'Terrestre');

-- Inserindo dados na tabela Animal

Insert into Animal(nome, sexo, idade, especie, peso, id_habitat) values
('Ornitorinco', 'macho', 5, 'Ornithorhynchus Anatinus', 2.4, 1),
('Tambaqui', 'macho', 40 ,'Colossoma Macropomum', 27.5 , 2),
('Esquilo-Cinzento-Oriental', 'fêmea', 3 ,'Sciurus Carolinensis', 0.600 , 3),
('Arara-Azul-Grande', 'fêmea', 35 ,'Anodorhynchus Hyacinthinus', 1.34, 4),
('Hipopótamo-comum', 'macho', 40 ,'Hippopotamus amphibius', 4500, 5);

-- Inserindo dados na tabela Visitante

Insert into Visitante(nome, idade) values
('Lucas Almeida', 14),
('Fernanda Costa', 27),
('Gabriel Souza', 35),
('Mariana Lima', 19),
('Pedro Tavares', 2),
('Juliana Martins', 31),
('Rafael Gomes', 22),
('Beatriz Oliveira', 17),
('Mateus Ferreira', 45),
('Mary Braverman', 67);

-- Inserindo dados na tabela Ingresso

Insert into Ingresso(data, tipo, preco, id_visitante) values
('2026-05-28','Meia', 50, 1),
('2026-05-28','Inteira', 100, 2),
('2026-05-28','Inteira', 100, 3),
('2026-05-28','Estudante', 60, 4),
('2026-05-28','Isento', 0, 5),
('2026-05-28','Inteira', 100, 6),
('2026-05-28','Estudante', 60, 7),
('2026-05-28','Meia', 50, 8),
('2026-05-28','Inteira', 100, 9),
('2026-05-28','Isento', 0, 10);

-- Inserindo dados na tabela Funcionário

Insert into Funcionario(nome, funcao, salario) values
('Carlos Silva', 'Veterinário', 6500.00),
('Andreia Costa', 'Veterinário', 6500.00),
('Marina Souza', 'Tratador de Animais', 3200.00),
('Julia Marques', 'Tratador de Animais', 3200.00),
('Felipe Costa', 'Biólogo', 5400.00),
('João Oliveira', 'Zelador', 2100.00),
('Levi Andrade', 'Zelador', 2100.00),
('Bernadete Silva', 'Zelador', 2100.00),
('Thiafo Pereira', 'Segurança', 2800.00),
('Ricardo Lima', 'Segurança', 2800.00);

-- Inserindo dados na tabela Consulta Veterinária

Insert into ConsultaVeterinaria(data, estado_de_saude, id_animal, id_funcionario) values
('2026-05-10', 'Saudável', 1, 2),
('2026-05-12', 'Em observação', 3, 1),
('2026-05-15', 'Recuperação de ferimento', 2, 1),
('2026-05-18', 'Saudável', 4, 1),
('2026-05-20', 'Tratamento veterinário', 5, 2);

-- Inserindo dados na tabela Alimento

Insert into Alimento(tipo_de_dieta, estoque, nome) values
('Carnívora', 50, 'Crustáceos e peixes'),
('Herbívora', 150, 'Frutas e sementes'),
('Onívora', 80, 'Frutas e insetos variados'),
('Onívora', 90, 'Frutas e insetos variados'),
('Herbívora (mas podem consumir carne)', 1500, 'Gramíneas');

INSERT INTO Funcionario_has_Habitat(id_funcionario, id_habitat) VALUES
(1, 1), 
(1, 5), 
(2, 2), 
(2, 4), 
(3, 3), 
(3, 4), 
(4, 5), 
(4, 1), 
(5, 3), 
(5, 4), 
(6, 1), 
(7, 2), 
(8, 5), 
(9, 4), 
(10, 5); 

INSERT INTO Funcionario_has_Animal(id_funcionario, id_animal) VALUES
(3,1),
(3,2),
(4,3),
(4,4),
(5,5),
(1,1),
(1,3),
(2,2),
(2,4),
(2,5);

-- ================================== --
--        USUÁRIOS ARBITRÁRIOS        --
-- ================================== --

drop user if exists 'Administrador'@'%';
drop user if exists 'DiretorGeral'@'%';

Create user 'Administrador'@'%' identified by 'senha_adm';
Create user 'DiretorGeral'@'%' identified by 'senha_diretor';

-- Privilégios dos usuários
Grant select, insert, delete, update on zoologico.* to 'Administrador'@'%';
Grant all privileges on zoologico.* to 'DiretorGeral'@'%';

-- ================================== --
--                ROLE                --
-- ================================== --

drop role if exists 'Veterinario';
Create role 'Veterinario';
Grant select, insert, update on zoologico.ConsultaVeterinaria to 'Veterinario';

Drop user if exists 'CarlosVet'@'%';
Drop user if exists 'AndreiaVet'@'%';

Create user 'CarlosVet'@'%' identified by 'Carlos123';
Create user 'AndreiaVet'@'%' identified by 'Andreia123';

Grant 'Veterinario' to 'CarlosVet'@'%';
Grant 'Veterinario' to 'AndreiaVet'@'%';

set default role 'Veterinario' to 'CarlosVet'@'%';
set default role 'Veterinario' to 'AndreiaVet'@'%';

-- ================================== --
--         OBJETOS PROGRAMÁVEIS       --
-- ================================== --

-- Function que verifica quantos animais há em cada habitat e o limite destes
delimiter $$

drop function if exists verificarlotacao $$
create function verificarlotacao(habitat_id  int)
returns varchar(200)
deterministic

begin

    declare qtd_animais int;
    declare lotacao_maxima int;

    -- conta quantos animais existem no habitat
    select count(*)
    into qtd_animais
    from Animal
    where id_habitat = habitat_id ;

    -- busca a lotação máxima do habitat
    select lotacao
    into lotacao_maxima
    from Habitat
    where id_Habitat = habitat_id ;

    -- verificações
    if qtd_animais >= lotacao_maxima then
        return concat('Habitat lotado! possui ', qtd_animais,' animais e precisa de transferência.');
	else
		return concat('Habitat disponível, possui ', qtd_animais,' animais.');
    end if;

end $$
delimiter ;

-- Trigger 
delimiter $$

drop trigger if exists desconto_infantil $$

create trigger desconto_infantil
before insert on Ingresso
for each row
begin

    declare idade_visitante int;

    -- Busca a idade do visitante
    select idade
    into idade_visitante
    from Visitante
    where id_Visitante = new.id_visitante;

    -- Regra de desconto infantil
    if idade_visitante < 12 then
        set new.preco = 0;
        set new.tipo = 'Isento';
    end if;

end $$
delimiter ;

 -- insert into Ingresso(data, tipo, preco, id_visitante) values ('2026-06-01', 'Inteira', 100, 5);
 -- select * from Ingresso where id_visitante = 5;

-- Views
create view Animais_Peso_Idade as (select peso, idade from Animal);

select * from Animais_Peso_Idade;

drop view Animais_Peso_Idade;

-- select * from zoologico;
SHOW TABLES FROM zoologico;
