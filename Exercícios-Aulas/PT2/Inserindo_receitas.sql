-- =============================
--           TABELAS
-- =============================

CREATE TABLE Cozinheiros(
    id INT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    senha VARCHAR(45)
);

CREATE TABLE Ingredientes(
    id INT PRIMARY KEY,
    nome VARCHAR(45) UNIQUE 
);

CREATE TABLE Estoques (
    cozinheiro INT,
    ingrediente INT,
    quantidade INT CHECK(quantidade >= 0),
    
    PRIMARY KEY (cozinheiro, ingrediente),
    FOREIGN KEY (cozinheiro) REFERENCES Cozinheiros(id),
    FOREIGN KEY (ingrediente) REFERENCES Ingredientes(id)
);

-- Criação da tabela de receitas 

CREATE TABLE Receitas(
    id INT PRIMARY KEY,
    nome VARCHAR(45),
    modo_de_preparo TEXT
);

-- Criação da tabela de composições

CREATE TABLE Composicoes(
    receita INT,
    ingrediente INT,
    quantidade INT,
    
    PRIMARY KEY (receita, ingrediente),
    FOREIGN KEY(receita) REFERENCES Receitas(id),
    FOREIGN KEY(ingrediente) REFERENCES Ingredientes(id)
);


-- =============================
--           INSERÇÕES
-- =============================

INSERT INTO Cozinheiros (id, nome, email, senha) VALUES
(1, 'Soebad Saliv', 'contato@poisonfrit.com', 'Jaca_1234'),
(2, 'Poles Najos',  'poles@g.com',            'DnD13#'),
(3, 'Sani Vosjal',  'sani@g.com',             'Kituti67!');

INSERT INTO Ingredientes (id, nome) VALUES
(1,'Banana'),
(2,'Leite'),
(3,'Ovo'),
(4,'Açúcar'),
(5,'Farinha de trigo'),
(6,'Manteiga'),
(7,'Baunilha'),
(8,'Jaca'),
(9,'Barracuda'),
(10,'Sal'),
(11,'Pimenta'),
(12,'Cebola');

INSERT INTO Estoques (cozinheiro, ingrediente, quantidade) VALUES
(1,5,1854),
(1,6,985),
(1,8,1520),
(1,9,1652),
(1,10,566),
(1,11,362),
(1,12,512),
(2,1,124),
(2,2,512),
(2,3,222),
(2,4,356),
(2,5,1020),
(2,6,558),
(3,1,102),
(3,2,253),
(3,5,152),
(3,9,280);

INSERT INTO Receitas (id, nome, modo_de_preparo) VALUES
(1, 'Bolo de Banana',    'Misture tudo coloque na forma e asse por 30 min.'),
(2, 'Batida de Banana',    'Bata tudo no liquidificador e aproveite!'),
(3, 'Tarte jacquier poisson',    'Cozinhe a jaca em pressão por 20 min. Refogue a barracuda...');

INSERT INTO Composicoes (receita, ingrediente, quantidade) VALUES
(1,1,150),
(1,3,80),
(1,4,100),
(1,5,150),
(1,6,50),
(2,1,100),
(2,2,150),
(3,5,200),
(3,6,100),
(3,8,300),
(3,9,200),
(3,10,10),
(3,11,10),
(3,12,200);

-- Apresentar os nomes das receiras em ordem alfabética e quantos ingredientes diferentes
-- são necessários para fazer cada receita

SELECT r.nome AS nome_receita,
COUNT(DISTINCT c.ingrediente) AS ingredientes_diferentes
FROM Receitas r
JOIN Composicoes c
ON r.id = c.receita 
GROUP BY r.id 
ORDER BY r.nome;
