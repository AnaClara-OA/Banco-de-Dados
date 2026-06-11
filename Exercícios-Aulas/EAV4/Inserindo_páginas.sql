CREATE TABLE Mundo (
	Id INT PRIMARY KEY,
    Nome VARCHAR(45),
    Descricao VARCHAR(100)
);

INSERT INTO Mundo VALUES
(1,'Maygïk','Uma teocracia aliada aos magnatas exploradores regem esse mundo. Os desafios vão muito além do que você espera.'),
(2,'Lucinera','O mundo é dominado por dragões. Como você vai trilhar o seu caminho:  Para livrar o seu povo ou para ascender como um senhor dos dragões?');

CREATE TABLE Paginas (
	Id INT PRIMARY KEY,
    Titulo VARCHAR(45),
    Descricao VARCHAR(100),
    Mundo_Id INT,
    FOREIGN KEY (Mundo_Id) REFERENCES Mundo(Id)
);

INSERT INTO Paginas VALUES
(1,'O Culto do Heroi','Uma sociedade religiosa que segue os passos do Heroi que salvou Granjaran dos sombrios.',1),
(2,'Uanteji','Uma organização secreta de mercenários, espiões e assassinos.',1);

SELECT * FROM Paginas;
