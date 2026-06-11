CREATE TABLE Habilidades (
	Id INT PRIMARY KEY,
    Descrição VARCHAR(45),
    Atributo VARCHAR(30)
);

INSERT INTO Habilidades VALUES
(1,'Corrida longa', 'Constituição'),
(2,'Corrida de arrancada', 'Força'),
(3,'Acrobacia', 'Destreza'),
(4,'Tiro com arco', 'Destreza');

SELECT * FROM Habilidades;
