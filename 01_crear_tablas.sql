-- =====================================================================
--  CREACIÓN Y POBLADO DE TABLAS PARA PRACTICAR JOINS (XAMPP / phpMyAdmin)
--  Cómo usarlo:
--    1. Abre http://localhost/phpmyadmin
--    2. Pestaña "SQL" (arriba, sin seleccionar ninguna base de datos)
--    3. Pega TODO este archivo y pulsa "Continuar"
--  Se puede ejecutar varias veces: borra y vuelve a crear las tablas.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS joins_demo
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE joins_demo;

DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS ciudades;

-- ---------------------------------------------------------------------
-- TABLAS (sin FOREIGN KEY: la relación es solo "lógica" por los id)
--
--   ciudades.id  <---  clientes.id_ciudad
--   clientes.id  <---  pedidos.id_cliente
--   productos.id <---  pedidos.id_producto
-- ---------------------------------------------------------------------

CREATE TABLE ciudades (
  id     INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE clientes (
  id        INT PRIMARY KEY,
  nombre    VARCHAR(50) NOT NULL,
  id_ciudad INT NULL            -- apunta a ciudades.id (puede ser NULL)
);

CREATE TABLE productos (
  id     INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  precio DECIMAL(8,2) NOT NULL
);

CREATE TABLE pedidos (
  id          INT PRIMARY KEY,
  id_cliente  INT NOT NULL,     -- apunta a clientes.id
  id_producto INT NOT NULL,     -- apunta a productos.id
  cantidad    INT NOT NULL,
  fecha       DATE NOT NULL
);

-- ---------------------------------------------------------------------
-- DATOS (preparados a propósito con "huecos" para ver las diferencias)
-- ---------------------------------------------------------------------

INSERT INTO ciudades (id, nombre) VALUES
  (1, 'Madrid'),
  (2, 'Barcelona'),
  (3, 'Sevilla'),
  (4, 'Valencia');              -- OJO: ningún cliente vive en Valencia

INSERT INTO clientes (id, nombre, id_ciudad) VALUES
  (1, 'Ana',   1),
  (2, 'Luis',  2),
  (3, 'Marta', 1),
  (4, 'Pedro', 3),              -- OJO: Pedro no tiene pedidos
  (5, 'Sara',  NULL);           -- OJO: Sara no tiene ciudad

INSERT INTO productos (id, nombre, precio) VALUES
  (1, 'Teclado',  25.00),
  (2, 'Raton',    15.00),
  (3, 'Monitor', 150.00),
  (4, 'Webcam',   40.00);       -- OJO: la Webcam nunca se ha vendido

INSERT INTO pedidos (id, id_cliente, id_producto, cantidad, fecha) VALUES
  (1, 1,  1, 1, '2026-09-01'),  -- Ana   compra Teclado
  (2, 1,  3, 2, '2026-09-03'),  -- Ana   compra Monitor
  (3, 2,  2, 3, '2026-09-05'),  -- Luis  compra Raton
  (4, 3,  1, 1, '2026-09-10'),  -- Marta compra Teclado
  (5, 5,  2, 1, '2026-09-12'),  -- Sara  compra Raton
  (6, 99, 3, 1, '2026-09-15');  -- OJO: el cliente 99 NO existe (pedido "huérfano")

-- Comprobación rápida
SELECT * FROM ciudades;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM pedidos;
