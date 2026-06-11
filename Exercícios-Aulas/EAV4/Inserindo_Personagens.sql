CREATE TABLE Mundo (
	Id INT PRIMARY KEY,
    Nome VARCHAR(45),
    Descricao VARCHAR(100)
);

INSERT INTO Mundo VALUES
(1,'Maygïk','Uma teocracia aliada aos magnatas exploradores regem esse mundo. Os desafios vão muito além do que você espera.'),
(2,'Lucinera','O mundo é dominado por dragões. Como você vai trilhar o seu caminho:  Para livrar o seu povo ou para ascender como um senhor dos dragões?');

CREATE TABLE Personagens (
	Id INT PRIMARY KEY,
    Nome VARCHAR(45),
    Idade INT,
    Profissão VARCHAR(45),
    Data VARCHAR(45),
    Mundo_Id INT,
    FOREIGN KEY (Mundo_Id) REFERENCES Mundo(Id)
);

INSERT INTO Personagens VALUES
(1, 'Ann`aurora', '21', 'Clérigo(a)', '2024-06-05', '1'),
(2, 'Zurendownr Narrwack', '652', 'Diplomata', '2024-06-05', '1');

SELECT * FROM Personagens;
