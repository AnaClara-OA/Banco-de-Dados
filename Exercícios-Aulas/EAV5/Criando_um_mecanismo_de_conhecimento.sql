CREATE TABLE Item (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    preco REAL,
    peso REAL,
    volume REAL
);

CREATE TABLE Item_Magico (
    id_item INTEGER PRIMARY KEY REFERENCES Item(id),
    efeito TEXT
);

CREATE TABLE Item_Inventario (
    id_item INTEGER PRIMARY KEY REFERENCES Item(id),
    cap_peso REAL,
    cap_volume REAL
);

CREATE TABLE Item_Arma (
    id_item INTEGER PRIMARY KEY REFERENCES Item(id),
    classe TEXT,
    dano TEXT
);

INSERT INTO Item (id, nome, preco, peso, volume) VALUES
(1, 'Ungento restaurador', 80,  0.2,  0.25),
(2, 'Poção de regeneração', 200, 0.2,  0.35),
(3, 'Bolsa de explorador', 20,  0.6,  1.2),
(4, 'Bolsa encantada', 500, 0.7,  1.1),
(5, 'Machado de guerra', 50,  15.5, 10.1);

INSERT INTO Item_Magico (id_item, efeito) VALUES
(2, 'Cicatriza ferimentos profundos (1d4+2 PV)'),
(4, 'Tem uma dimensão de bolso para armazenar itens');

INSERT INTO Item_Inventario (id_item, cap_peso, cap_volume) VALUES
(3, 50, 23.6),
(4, 1850, 1020);

INSERT INTO Item_Arma (id_item, classe, dano) VALUES
(5, 'Corpo-a-corpo pesada', '1d8');

CREATE TABLE Mundo (
    id INTEGER PRIMARY KEY,
    nome TEXT,
    descricao TEXT
);

INSERT INTO Mundo (id, nome, descricao) VALUES
(1, 'Mundo Principal', 'O mundo base da campanha');

CREATE TABLE Pagina (
    id INTEGER PRIMARY KEY,
    titulo TEXT,
    descricao TEXT,
    id_mundo INTEGER REFERENCES Mundo(id)
);

INSERT INTO Pagina (id, titulo, descricao, id_mundo) VALUES
(1, 'O Culto do Heroi', 'Página destinada a personagens religiosos', 1),
(2, 'Uanteji', 'Página destinada a personagens furtivos', 1);


CREATE TABLE Habilidade (
    id  INTEGER PRIMARY KEY,
    descricao TEXT,
    atributo_base TEXT
);

INSERT INTO Habilidade (id, descricao, atributo_base) VALUES
(1, 'Corrida de arrancada', 'Agilidade'),
(2, 'Corrida longa', 'Resistência'),
(3, 'Acrobacia', 'Agilidade');

CREATE TABLE Personagem (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    profissao TEXT,
    idade INTEGER,
    id_mundo INTEGER REFERENCES Mundo(id),
    data_criacao DATE
);

INSERT INTO Personagem (id, nome, profissao, idade, id_mundo, data_criacao) VALUES
(1, 'Ann`aurora', 'Clérigo(a)', 21,  1, '2024-06-05'),
(2, 'Zurendownr Narrwack', 'Diplomata',  652, 1, '2024-06-05');

CREATE TABLE Habilidades_Personagem (
    id_habilidade INTEGER REFERENCES Habilidade(id),
    id_personagem INTEGER REFERENCES Personagem(id),
    modificador REAL,
    PRIMARY KEY (id_habilidade, id_personagem)
);

INSERT INTO Habilidades_Personagem (id_habilidade, id_personagem, modificador) VALUES
(1, 1, 2),
(3, 2, 2);

CREATE TABLE Personagem_Item (
    id_personagem INTEGER REFERENCES Personagem(id),
    id_item INTEGER REFERENCES Item(id),
    quantidade INTEGER,
    PRIMARY KEY (id_personagem, id_item)
);

INSERT INTO Personagem_Item (id_personagem, id_item, quantidade) VALUES
(1, 1, 3),
(1, 2, 2),
(1, 3, 1);

CREATE TABLE Pagina_Profissao (
    id_pagina INTEGER REFERENCES Pagina(id),
    profissao TEXT,
    PRIMARY KEY (id_pagina, profissao)
);

INSERT INTO Pagina_Profissao (id_pagina, profissao) VALUES
(1, 'Clérigo(a)'),
(1, 'Acólito(a)'),
(1, 'Paladino(a)'),
(1, 'Diplomata'),
(2, 'Ladino(a)'),
(2, 'Diplomata');

CREATE TABLE Personagem_Pagina (
    id_personagem INTEGER REFERENCES Personagem(id),
    id_pagina INTEGER REFERENCES Pagina(id),
    PRIMARY KEY (id_personagem, id_pagina)
);

INSERT INTO Personagem_Pagina (id_personagem, id_pagina)
SELECT DISTINCT p.id, pp.id_pagina
FROM Personagem p
JOIN Pagina_Profissao pp ON pp.profissao = p.profissao;

SELECT
    p.nome,
    GROUP_CONCAT(pg.titulo, ',') AS paginas
FROM Personagem p
JOIN Personagem_Pagina ppa ON ppa.id_personagem = p.id
JOIN Pagina pg ON pg.id = ppa.id_pagina
GROUP BY p.id, p.nome;
