-- =============================
--     Criação das tabelas
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

-- =============================
--     Inserção de dados
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

-- (b) Soebad Saliv retirou 100 gramas de farinha e descartou todas as cebolas
UPDATE Estoques SET quantidade = '1754' WHERE cozinheiro = 1 AND ingrediente = 5;
DELETE FROM Estoques WHERE cozinheiro = 1 AND ingrediente = 12;

-- (c) Nomes dos cozinheiros em ordem alfabética e o peso total do estoque de cada um

SELECT c.nome, sum(e.quantidade) 
AS peso_total_estoque 
FROM Cozinheiros c 
JOIN Estoques e 
ON c.id = e.cozinheiro 
GROUP BY c.id 
ORDER BY c.nome;
