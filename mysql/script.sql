-- Laboratório Docker Compose: MySQL
-- Autor: Bryan da Silva
USE loja_bryan;

CREATE TABLE IF NOT EXISTS clientes_bryan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  cidade VARCHAR(100) NOT NULL
);

INSERT IGNORE INTO clientes_bryan (nome, email, cidade) VALUES
  ('Ana Souza', 'ana.souza@example.com', 'São Paulo'),
  ('Bruno Lima', 'bruno.lima@example.com', 'Campinas'),
  ('Carla Mendes', 'carla.mendes@example.com', 'Santos');

SELECT * FROM clientes_bryan;
SELECT nome, cidade FROM clientes_bryan WHERE cidade = 'São Paulo';
SELECT COUNT(*) AS total_de_clientes FROM clientes_bryan;
