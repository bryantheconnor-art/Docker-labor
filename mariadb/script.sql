-- Laboratório Docker Compose: MariaDB
-- Autor: Bryan da Silva
USE loja_bryan;

CREATE TABLE IF NOT EXISTS produtos_bryan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  preco DECIMAL(10,2) NOT NULL,
  estoque INT NOT NULL DEFAULT 0
);

INSERT IGNORE INTO produtos_bryan (nome, preco, estoque) VALUES
  ('Teclado Mecânico', 249.90, 15),
  ('Mouse Gamer', 129.50, 30),
  ('Monitor 24 polegadas', 899.00, 8);

SELECT * FROM produtos_bryan;
SELECT nome, preco FROM produtos_bryan WHERE preco > 200;
SELECT SUM(estoque) AS total_em_estoque FROM produtos_bryan;
