CREATE TABLE Item (
    id     INTEGER PRIMARY KEY,
    nome   TEXT NOT NULL,
    preco  REAL,
    peso   REAL,
    volume REAL
);

CREATE TABLE Item_Magico (
    id_item INTEGER PRIMARY KEY REFERENCES Item(id),
    efeito  TEXT
);

CREATE TABLE Item_Inventario (
    id_item    INTEGER PRIMARY KEY REFERENCES Item(id),
    cap_peso   REAL,
    cap_volume REAL
);

CREATE TABLE Item_Arma (
    id_item INTEGER PRIMARY KEY REFERENCES Item(id),
    classe  TEXT,
    dano    TEXT
);

INSERT INTO Item (id, nome, preco, peso, volume) VALUES
(1, 'Ungento restaurador',  80,  0.2,  0.25),
(2, 'Poção de regeneração', 200, 0.2,  0.35),
(3, 'Bolsa de explorador',  20,  0.6,  1.2),
(4, 'Bolsa encantada',      500, 0.7,  1.1),
(5, 'Machado de guerra',    50,  15.5, 10.1);


INSERT INTO Item_Magico (id_item, efeito) VALUES
(2, 'Cicatriza ferimentos profundos (1d4+2 PV)'),
(4, 'Tem uma dimensão de bolso para armazenar itens');

INSERT INTO Item_Inventario (id_item, cap_peso, cap_volume) VALUES
(3, 50,   23.6),
(4, 1850, 1020);

INSERT INTO Item_Arma (id_item, classe, dano) VALUES
(5, 'Corpo-a-corpo pesada', '1d8');

-- Itens comuns
SELECT i.*
FROM Item i
WHERE NOT EXISTS (SELECT 1 FROM Item_Magico     WHERE id_item = i.id)
  AND NOT EXISTS (SELECT 1 FROM Item_Inventario WHERE id_item = i.id)
  AND NOT EXISTS (SELECT 1 FROM Item_Arma       WHERE id_item = i.id);

-- Itens mágicos
SELECT i.*, m.id_item, m.efeito
FROM Item i
JOIN Item_Magico m ON m.id_item = i.id;

-- Itens inventário
SELECT i.*, inv.id_item, inv.cap_peso, inv.cap_volume
FROM Item i
JOIN Item_Inventario inv ON inv.id_item = i.id;

-- Armas (dano antes de classe)
SELECT i.*, a.id_item, a.dano, a.classe
FROM Item i
JOIN Item_Arma a ON a.id_item = i.id;
