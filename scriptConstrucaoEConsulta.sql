-- Gerado por Oracle SQL Developer Data Modeler 24.3.0.240.1210
--   em:        2024-11-10 14:35:17 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE cultura CASCADE CONSTRAINTS;

DROP TABLE estado CASCADE CONSTRAINTS;

DROP TABLE producao CASCADE CONSTRAINTS;

DROP TABLE safra CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cultura (
    id   NUMBER NOT NULL,
    nome VARCHAR2(100) NOT NULL
);

ALTER TABLE cultura ADD CONSTRAINT pk_cultura PRIMARY KEY ( id );

ALTER TABLE cultura ADD CONSTRAINT un_cultura_nome UNIQUE ( nome );

CREATE TABLE estado (
    id   NUMBER NOT NULL,
    nome VARCHAR2(100) NOT NULL
);

ALTER TABLE estado ADD CONSTRAINT pk_estado PRIMARY KEY ( id );

ALTER TABLE estado ADD CONSTRAINT un_estado_nome UNIQUE ( nome );

CREATE TABLE producao (
    id             NUMBER NOT NULL,
    safra_id       NUMBER NOT NULL,
    produtividade  NUMBER,
    area_plantada  NUMBER,
    producao_total NUMBER
);

ALTER TABLE producao ADD CONSTRAINT pk_producao PRIMARY KEY ( id );

CREATE TABLE safra (
    id         NUMBER NOT NULL,
    estado_id  NUMBER NOT NULL,
    cultura_id NUMBER NOT NULL,
    ano        NUMBER(4) NOT NULL
);

ALTER TABLE safra ADD CONSTRAINT pk_safra PRIMARY KEY ( id );

ALTER TABLE producao
    ADD CONSTRAINT fk_producao_safra FOREIGN KEY ( safra_id )
        REFERENCES safra ( id );

ALTER TABLE safra
    ADD CONSTRAINT fk_safra_cultura FOREIGN KEY ( cultura_id )
        REFERENCES cultura ( id );

ALTER TABLE safra
    ADD CONSTRAINT fk_safra_estado FOREIGN KEY ( estado_id )
        REFERENCES estado ( id );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              9
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0


---POPULAR AS TABELAS

INSERT INTO cultura (id, nome) VALUES (1, 'Soja');
INSERT INTO cultura (id, nome) VALUES (2, 'Milho');
INSERT INTO cultura (id, nome) VALUES (3, 'Algodão');

INSERT INTO estado (id, nome) VALUES (1, 'Mato Grosso');
INSERT INTO estado (id, nome) VALUES (2, 'São Paulo');
INSERT INTO estado (id, nome) VALUES (3, 'Minas Gerais');

INSERT INTO safra (id, estado_id, cultura_id, ano) VALUES (1, 1, 1, 2023); -- Mato Grosso, Soja, 2023
INSERT INTO safra (id, estado_id, cultura_id, ano) VALUES (2, 1, 2, 2023); -- Mato Grosso, Milho, 2023
INSERT INTO safra (id, estado_id, cultura_id, ano) VALUES (3, 2, 1, 2023); -- São Paulo, Soja, 2023
INSERT INTO safra (id, estado_id, cultura_id, ano) VALUES (4, 3, 3, 2022); -- Minas Gerais, Algodão, 2022
INSERT INTO safra (id, estado_id, cultura_id, ano) VALUES (5, 2, 2, 2022); -- São Paulo, Milho, 2022

INSERT INTO producao (id, safra_id, produtividade, area_plantada, producao_total) 
VALUES (1, 1, 3.5, 1500, 5250);  -- Safra 1 (Mato Grosso, Soja, 2023)

INSERT INTO producao (id, safra_id, produtividade, area_plantada, producao_total) 
VALUES (2, 2, 4.2, 2000, 8400);  -- Safra 2 (Mato Grosso, Milho, 2023)

INSERT INTO producao (id, safra_id, produtividade, area_plantada, producao_total) 
VALUES (3, 3, 3.8, 1300, 4940);  -- Safra 3 (São Paulo, Soja, 2023)

INSERT INTO producao (id, safra_id, produtividade, area_plantada, producao_total) 
VALUES (4, 4, 2.5, 800, 2000);   -- Safra 4 (Minas Gerais, Algodão, 2022)

INSERT INTO producao (id, safra_id, produtividade, area_plantada, producao_total) 
VALUES (5, 5, 3.0, 900, 2700);   -- Safra 5 (São Paulo, Milho, 2022)


--- CONSULTAS
--- o ano e o estado com a maior produção total 
SELECT 
    s.ano AS ano_safra,
    e.nome AS estado,
    SUM(p.producao_total) AS producao_total
FROM 
    producao p
JOIN 
    safra s ON p.safra_id = s.id
JOIN 
    estado e ON s.estado_id = e.id
GROUP BY 
    s.ano, e.nome
ORDER BY 
    producao_total DESC
FETCH FIRST 1 ROWS ONLY;



---PRODUTIVIDADE MEDIA POR ANO E ESTADO
SELECT 
    e.nome AS estado,
    c.nome AS cultura,
    AVG(p.produtividade) AS produtividade_media
FROM 
    producao p
JOIN 
    safra s ON p.safra_id = s.id
JOIN 
    cultura c ON s.cultura_id = c.id
JOIN 
    estado e ON s.estado_id = e.id
GROUP BY 
    e.nome, c.nome
ORDER BY 
    estado, cultura;


---Área Plantada Total por Estado e Ano

SELECT 
    s.ano AS ano_safra,
    e.nome AS estado,
    SUM(p.area_plantada) AS area_plantada_total
FROM 
    producao p
JOIN 
    safra s ON p.safra_id = s.id
JOIN 
    estado e ON s.estado_id = e.id
GROUP BY 
    s.ano, e.nome
ORDER BY 
    s.ano, estado;