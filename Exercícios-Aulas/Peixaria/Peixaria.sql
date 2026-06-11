PRAGMA foreign_keys = ON;

CREATE TABLE Peixe (
    id_peixe      INTEGER  PRIMARY KEY,
    nome_comum    TEXT     NOT NULL,
    preco_kg      REAL     NOT NULL CHECK (preco_kg > 0),
    qtd_estoque   REAL     NOT NULL CHECK (qtd_estoque >= 0),
    tipo          TEXT     NOT NULL CHECK (tipo IN ('agua_doce', 'marinho', 'generico'))
);

CREATE TABLE Peixe_Agua_Doce (
    id_peixe        INTEGER  PRIMARY KEY REFERENCES Peixe(id_peixe) ON DELETE CASCADE,
    nome_cientifico TEXT     NOT NULL,
    habitat         TEXT     NOT NULL,   -- Ex: represa, rio, lago
    nivel_raridade  TEXT     NOT NULL CHECK (nivel_raridade IN ('comum', 'raro', 'exotico'))
);

CREATE TABLE Peixe_Marinho (
    id_peixe              INTEGER  PRIMARY KEY REFERENCES Peixe(id_peixe) ON DELETE CASCADE,
    origem                TEXT     NOT NULL,   -- Ex: litoral sudeste, profundidade
    sabor_predominante    TEXT     NOT NULL,
    refrigeracao_especial INTEGER  NOT NULL DEFAULT 0 CHECK (refrigeracao_especial IN (0, 1))
    -- 0 = false, 1 = true
);

CREATE TABLE Cliente (
    id_cliente    INTEGER  PRIMARY KEY,
    nome_completo TEXT     NOT NULL,
    telefone      TEXT     NOT NULL
);

CREATE TABLE Venda (
    id_venda           INTEGER  PRIMARY KEY,
    id_cliente         INTEGER  NOT NULL REFERENCES Cliente(id_cliente),
    data_hora_venda    TEXT     NOT NULL DEFAULT (datetime('now')),
    data_prev_retirada TEXT     NOT NULL
);

CREATE TABLE Item_Venda (
    id_venda              INTEGER  NOT NULL REFERENCES Venda(id_venda) ON DELETE CASCADE,
    id_peixe              INTEGER  NOT NULL REFERENCES Peixe(id_peixe),
    qtd_kg                REAL     NOT NULL CHECK (qtd_kg > 0),
    data_retirada_efetiva TEXT     NULL,
    PRIMARY KEY (id_venda, id_peixe)
);

-- ── Peixes de Água Doce ──────────────────────────────────────

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Tucunaré', 38.90, 45.00, 'agua_doce');           -- id 1

INSERT INTO Peixe_Agua_Doce VALUES (1, 'Cichla ocellaris', 'represa', 'comum');

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Dourado', 72.50, 18.50, 'agua_doce');            -- id 2

INSERT INTO Peixe_Agua_Doce VALUES (2, 'Salminus brasiliensis', 'rio', 'raro');

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Pintado', 95.00, 12.00, 'agua_doce');            -- id 3

INSERT INTO Peixe_Agua_Doce VALUES (3, 'Pseudoplatystoma corruscans', 'represa', 'exotico');

-- ── Peixes Marinhos ──────────────────────────────────────────

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Robalo', 55.00, 30.00, 'marinho');               -- id 4

INSERT INTO Peixe_Marinho VALUES (4, 'litoral sudeste', 'suave', 0);

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Linguado', 89.00, 10.00, 'marinho');             -- id 5

INSERT INTO Peixe_Marinho VALUES (5, 'profundidade', 'delicado', 1);

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Atum', 48.00, 60.00, 'marinho');                 -- id 6

INSERT INTO Peixe_Marinho VALUES (6, 'alto mar', 'intenso', 1);

-- ── Peixes Genéricos (sem subtipo) ───────────────────────────

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Traíra', 18.00, 80.00, 'generico');              -- id 7

INSERT INTO Peixe (nome_comum, preco_kg, qtd_estoque, tipo)
VALUES ('Lambari', 9.50, 200.00, 'generico');             -- id 8

-- ── (a) Inserção de clientes ─────────────────────────────────

INSERT INTO Cliente (nome_completo, telefone)
VALUES ('Margarida Souza Fonseca', '(35) 99812-4401');    -- id 1

INSERT INTO Cliente (nome_completo, telefone)
VALUES ('Raimundo Pereira das Neves', '(35) 98744-0093'); -- id 2

INSERT INTO Cliente (nome_completo, telefone)
VALUES ('Cleide Aparecida Braga', '(35) 99201-7755');     -- id 3

-- ── (b) Inserção de vendas ───────────────────────────────────

-- Venda 1: Margarida compra Tucunaré + Dourado
INSERT INTO Venda (id_cliente, data_hora_venda, data_prev_retirada)
VALUES (1, '2025-11-10 09:30:00', '2025-11-10');          -- id 1

INSERT INTO Item_Venda VALUES (1, 1, 3.50, NULL);         -- Tucunaré
INSERT INTO Item_Venda VALUES (1, 2, 1.20, NULL);         -- Dourado

-- Venda 2: Raimundo compra Linguado + Atum + Traíra
INSERT INTO Venda (id_cliente, data_hora_venda, data_prev_retirada)
VALUES (2, '2025-11-12 14:15:00', '2025-11-13');          -- id 2

INSERT INTO Item_Venda VALUES (2, 5, 2.00, NULL);         -- Linguado
INSERT INTO Item_Venda VALUES (2, 6, 4.50, NULL);         -- Atum
INSERT INTO Item_Venda VALUES (2, 7, 1.00, NULL);         -- Traíra

-- ── (c) Atualização: registrar retirada efetiva ──────────────
-- Raimundo retirou o Atum na data prevista

UPDATE Item_Venda
SET data_retirada_efetiva = '2025-11-13'
WHERE id_venda = 2
  AND id_peixe = 6;

-- ── (d) Remoção de cliente ───────────────────────────────────
-- Remove Cleide (id 3), que não possui vendas associadas

DELETE FROM Cliente
WHERE id_cliente = 3;

SELECT
    v.id_venda,
    c.nome_completo          AS cliente,
    v.data_hora_venda,
    p.nome_comum             AS peixe,
    iv.qtd_kg,
    iv.data_retirada_efetiva
FROM Venda v
    JOIN Cliente      c  ON c.id_cliente = v.id_cliente
    JOIN Item_Venda   iv ON iv.id_venda  = v.id_venda
    JOIN Peixe        p  ON p.id_peixe   = iv.id_peixe
ORDER BY v.data_hora_venda DESC;
