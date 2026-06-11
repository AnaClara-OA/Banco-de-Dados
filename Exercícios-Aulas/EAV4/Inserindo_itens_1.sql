CREATE TABLE Itens (
	Id INT PRIMARY KEY,
    Nome VARCHAR(45),
    Preço INT,
    Peso DOUBLE,
    Vol DOUBLE
);

INSERT INTO Itens VALUES
(1,'Ungento restaurador', 80, 0.2, 0.25),
(2,'Poção de regeneração', 200, 0.2, 0.35),
(3,'Bolsa de explorador', 20, 0.6, 1.2),
(4,'Bolsa encantada', 500, 0.7, 1.1),
(5,'Machado de guerra', 50, 15.5, 10.1);

SELECT * FROM Itens;
