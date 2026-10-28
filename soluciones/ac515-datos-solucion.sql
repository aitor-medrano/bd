-- =============================================================
-- Gimnasio "SeveroFit" - script de datos corregido (solución AC515)
-- Ejecutar tras ac515.sql
-- =============================================================
USE gimnasio;


INSERT INTO MONITOR VALUES
(1, '11111111A', 'Laura Pérez', 'laura@severofit.es', '2023-09-01'),
(2, '22222222B', 'Marcos Gil', 'marcos@severofit.es', '2024-01-15'),
(3, '33333333C', 'Sara Molina', NULL, DEFAULT);

INSERT INTO SOCIO (id, dni, nombre, cuota, tipo) VALUES
(1, '40000001D', 'Ana López', 35, 'mensual'),
(2, '40000002E', 'Luis Martín', 90, 'trimestral'),
(3, '40000003F', 'Eva Sanz', 180, 'anual'),
(4, '40000004G', 'Jorge Ruiz', 35, 'mensual'),
(5, '40000005H', 'Nuria Vidal', DEFAULT, DEFAULT);

INSERT INTO ACTIVIDAD (codigo, nombre, descripcion, plazas, monitor) VALUES
('SPIN', 'Spinning', 'Ciclismo indoor', 20, 1),
('YOGA', 'Yoga', NULL, 15, 2),
('PILA', 'Pilates', 'Suelo y máquinas', 12, 2),
('CROS', 'CrossFit', NULL, 25, NULL),
('ZUMB', 'Zumba', 'Baile', 30, 3);

INSERT INTO INSCRIPCION (socio, actividad, fecha) VALUES
(1, 'SPIN', '2025-09-15'),
(1, 'YOGA', '2025-09-15'),
(2, 'SPIN', '2025-09-20'),
(3, 'PILA', '2025-10-01'),
(3, 'YOGA', '2025-10-01'),
(4, 'CROS', '2025-10-03'),
(5, 'ZUMB', DEFAULT);
