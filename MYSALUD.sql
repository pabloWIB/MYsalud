-- Crear la base de datos
CREATE DATABASE MYSALUD;
USE MYSALUD;

-- =====================================================
-- BASE DE DATOS CLÍNICA MYSALUD - EJE CAFETERO
-- Sistema de Gestión de Citas Médicas
-- =====================================================

-- Crear las tablas del sistema
-- =====================================================

-- Tabla de tipos de identificación
CREATE TABLE tipo_identificacion (
    id_tipo_identificacion NUMBER PRIMARY KEY,
    descripcion VARCHAR2(50) NOT NULL
);

-- Tabla de especialidades médicas
CREATE TABLE especialidades (
    id_especialidad NUMBER PRIMARY KEY,
    nombre_especialidad VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(200)
);

-- Tabla de médicos
CREATE TABLE medicos (
    id_medico NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    id_tipo_identificacion NUMBER NOT NULL,
    num_identificacion VARCHAR2(20) NOT NULL UNIQUE,
    telefono VARCHAR2(15),
    email VARCHAR2(100),
    id_especialidad NUMBER NOT NULL,
    fecha_registro DATE DEFAULT SYSDATE,
    estado VARCHAR2(10) DEFAULT 'ACTIVO',
    CONSTRAINT fk_medico_tipo_id FOREIGN KEY (id_tipo_identificacion) 
        REFERENCES tipo_identificacion(id_tipo_identificacion),
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) 
        REFERENCES especialidades(id_especialidad)
);

-- Tabla de pacientes
CREATE TABLE pacientes (
    id_paciente NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    id_tipo_identificacion NUMBER NOT NULL,
    num_identificacion VARCHAR2(20) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR2(15),
    email VARCHAR2(100),
    direccion VARCHAR2(200),
    fecha_registro DATE DEFAULT SYSDATE,
    estado VARCHAR2(10) DEFAULT 'ACTIVO',
    CONSTRAINT fk_paciente_tipo_id FOREIGN KEY (id_tipo_identificacion) 
        REFERENCES tipo_identificacion(id_tipo_identificacion)
);

-- Tabla de estados de citas
CREATE TABLE estado_citas (
    id_estado NUMBER PRIMARY KEY,
    descripcion VARCHAR2(30) NOT NULL
);

-- Tabla de citas médicas
CREATE TABLE citas_medicas (
    id_cita NUMBER PRIMARY KEY,
    id_paciente NUMBER NOT NULL,
    id_medico NUMBER NOT NULL,
    fecha_cita DATE NOT NULL,
    hora_cita VARCHAR2(8) NOT NULL,
    id_estado NUMBER NOT NULL,
    observaciones VARCHAR2(500),
    fecha_creacion DATE DEFAULT SYSDATE,
    tipo_cita VARCHAR2(20) DEFAULT 'GENERAL',
    CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) 
        REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) 
        REFERENCES medicos(id_medico),
    CONSTRAINT fk_cita_estado FOREIGN KEY (id_estado) 
        REFERENCES estado_citas(id_estado)
);

-- Crear secuencias para los IDs
-- =====================================================
CREATE SEQUENCE seq_tipo_identificacion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_especialidades START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medicos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pacientes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_estado_citas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_citas_medicas START WITH 1 INCREMENT BY 1;

-- Poblar las tablas con datos de prueba
-- =====================================================

-- Insertar tipos de identificación
INSERT INTO tipo_identificacion VALUES (seq_tipo_identificacion.NEXTVAL, 'Cédula de Ciudadanía');
INSERT INTO tipo_identificacion VALUES (seq_tipo_identificacion.NEXTVAL, 'Cédula de Extranjería');
INSERT INTO tipo_identificacion VALUES (seq_tipo_identificacion.NEXTVAL, 'Pasaporte');
INSERT INTO tipo_identificacion VALUES (seq_tipo_identificacion.NEXTVAL, 'Tarjeta de Identidad');

-- Insertar especialidades
INSERT INTO especialidades VALUES (seq_especialidades.NEXTVAL, 'Medicina General', 'Atención médica general');
INSERT INTO especialidades VALUES (seq_especialidades.NEXTVAL, 'Cardiología', 'Especialista en corazón');
INSERT INTO especialidades VALUES (seq_especialidades.NEXTVAL, 'Dermatología', 'Especialista en piel');
INSERT INTO especialidades VALUES (seq_especialidades.NEXTVAL, 'Pediatría', 'Especialista en niños');
INSERT INTO especialidades VALUES (seq_especialidades.NEXTVAL, 'Ginecología', 'Especialista en salud femenina');
INSERT INTO especialidades VALUES (seq_especialidades.NEXTVAL, 'Ortopedia', 'Especialista en huesos y articulaciones');

-- Insertar estados de citas
INSERT INTO estado_citas VALUES (seq_estado_citas.NEXTVAL, 'PROGRAMADA');
INSERT INTO estado_citas VALUES (seq_estado_citas.NEXTVAL, 'COMPLETADA');
INSERT INTO estado_citas VALUES (seq_estado_citas.NEXTVAL, 'CANCELADA');
INSERT INTO estado_citas VALUES (seq_estado_citas.NEXTVAL, 'NO_ASISTIO');

-- Insertar médicos
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Carlos', 'Rodríguez', 1, '12345678', '3101234567', 'carlos.rodriguez@mysalud.com', 1, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'María', 'González', 1, '23456789', '3112345678', 'maria.gonzalez@mysalud.com', 2, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Juan', 'Martínez', 1, '34567890', '3123456789', 'juan.martinez@mysalud.com', 3, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Ana', 'López', 1, '45678901', '3134567890', 'ana.lopez@mysalud.com', 4, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Pedro', 'Sánchez', 1, '56789012', '3145678901', 'pedro.sanchez@mysalud.com', 5, SYSDATE, 'ACTIVO');

-- Insertar pacientes
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Laura', 'Herrera', 1, '98765432', TO_DATE('1985-03-15', 'YYYY-MM-DD'), '3201234567', 'laura.herrera@email.com', 'Calle 10 #20-30', SYSDATE, 'ACTIVO');
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Miguel', 'Ramírez', 1, '87654321', TO_DATE('1990-07-22', 'YYYY-MM-DD'), '3212345678', 'miguel.ramirez@email.com', 'Carrera 15 #25-40', SYSDATE, 'ACTIVO');
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Carmen', 'Torres', 1, '76543210', TO_DATE('1978-11-08', 'YYYY-MM-DD'), '3223456789', 'carmen.torres@email.com', 'Avenida 20 #30-50', SYSDATE, 'ACTIVO');
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Ricardo', 'Vargas', 1, '65432109', TO_DATE('1992-05-12', 'YYYY-MM-DD'), '3234567890', 'ricardo.vargas@email.com', 'Calle 25 #35-60', SYSDATE, 'ACTIVO');

-- Insertar citas de prueba (incluyendo citas de hoy y últimos días)
INSERT INTO citas_medicas VALUES (seq_citas_medicas.NEXTVAL, 1, 1, SYSDATE, '08:00', 1, 'Consulta de control general', SYSDATE, 'GENERAL');
INSERT INTO citas_medicas VALUES (seq_citas_medicas.NEXTVAL, 2, 1, SYSDATE, '09:00', 1, 'Chequeo rutinario', SYSDATE, 'GENERAL');
INSERT INTO citas_medicas VALUES (seq_citas_medicas.NEXTVAL, 3, 2, SYSDATE, '10:00', 1, 'Consulta cardiológica', SYSDATE, 'ESPECIALIZADA');
INSERT INTO citas_medicas VALUES (seq_citas_medicas.NEXTVAL, 4, 3, SYSDATE-1, '14:00', 2, 'Revisión dermatológica', SYSDATE-1, 'ESPECIALIZADA');
INSERT INTO citas_medicas VALUES (seq_citas_medicas.NEXTVAL, 1, 2, SYSDATE-2, '11:00', 2, 'Control cardiológico', SYSDATE-2, 'ESPECIALIZADA');
INSERT INTO citas_medicas VALUES (seq_citas_medicas.NEXTVAL, 2, 4, SYSDATE-3, '15:00', 2, 'Consulta pediátrica', SYSDATE-3, 'ESPECIALIZADA');

COMMIT;

-- =====================================================
-- PROCEDIMIENTO ALMACENADO: sp_asignarCitaMedica
-- =====================================================

CREATE OR REPLACE PROCEDURE sp_asignarCitaMedica (
    p_num_identificacion_paciente IN VARCHAR2,
    p_num_identificacion_medico IN VARCHAR2,
    p_fecha_cita IN DATE,
    p_hora_cita IN VARCHAR2,
    p_tipo_cita IN VARCHAR2 DEFAULT 'GENERAL',
    p_observaciones IN VARCHAR2 DEFAULT NULL,
    p_resultado OUT VARCHAR2,
    p_id_cita OUT NUMBER
) IS
    v_id_paciente NUMBER;
    v_id_medico NUMBER;
    v_count_conflicto NUMBER;
    v_nueva_cita NUMBER;
BEGIN
    -- Validar que el paciente existe
    SELECT id_paciente INTO v_id_paciente 
    FROM pacientes 
    WHERE num_identificacion = p_num_identificacion_paciente 
    AND estado = 'ACTIVO';
    
    -- Validar que el médico existe
    SELECT id_medico INTO v_id_medico 
    FROM medicos 
    WHERE num_identificacion = p_num_identificacion_medico 
    AND estado = 'ACTIVO';
    
    -- Validar que no hay conflicto de horarios
    SELECT COUNT(*) INTO v_count_conflicto
    FROM citas_medicas 
    WHERE id_medico = v_id_medico 
    AND fecha_cita = p_fecha_cita 
    AND hora_cita = p_hora_cita 
    AND id_estado = 1; -- Solo citas programadas
    
    IF v_count_conflicto > 0 THEN
        p_resultado := 'ERROR: El médico ya tiene una cita programada en esa fecha y hora';
        p_id_cita := 0;
        RETURN;
    END IF;
    
    -- Crear la nueva cita
    SELECT seq_citas_medicas.NEXTVAL INTO v_nueva_cita FROM DUAL;
    
    INSERT INTO citas_medicas (
        id_cita, id_paciente, id_medico, fecha_cita, hora_cita, 
        id_estado, observaciones, fecha_creacion, tipo_cita
    ) VALUES (
        v_nueva_cita, v_id_paciente, v_id_medico, p_fecha_cita, p_hora_cita,
        1, p_observaciones, SYSDATE, p_tipo_cita
    );
    
    COMMIT;
    
    p_resultado := 'EXITO: Cita médica asignada correctamente';
    p_id_cita := v_nueva_cita;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_resultado := 'ERROR: Paciente o médico no encontrado';
        p_id_cita := 0;
    WHEN OTHERS THEN
        ROLLBACK;
        p_resultado := 'ERROR: ' || SQLERRM;
        p_id_cita := 0;
END sp_asignarCitaMedica;
/

-- =====================================================
-- PROCEDIMIENTO ALMACENADO: sp_consultarCitas
-- =====================================================

CREATE OR REPLACE PROCEDURE sp_consultarCitas (
    p_num_identificacion_medico IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR
        SELECT 
            c.id_cita,
            c.fecha_cita,
            c.hora_cita,
            p.nombre || ' ' || p.apellido AS nombre_paciente,
            p.num_identificacion AS cedula_paciente,
            e.descripcion AS estado_cita,
            c.tipo_cita,
            c.observaciones,
            esp.nombre_especialidad
        FROM citas_medicas c
        INNER JOIN medicos m ON c.id_medico = m.id_medico
        INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
        INNER JOIN estado_citas e ON c.id_estado = e.id_estado
        INNER JOIN especialidades esp ON m.id_especialidad = esp.id_especialidad
        WHERE m.num_identificacion = p_num_identificacion_medico
        AND c.fecha_cita >= SYSDATE - 5
        AND c.fecha_cita <= SYSDATE
        ORDER BY c.fecha_cita DESC, c.hora_cita;
END sp_consultarCitas;
/

-- =====================================================
-- FUNCIÓN: fn_contarCitasHoy
-- =====================================================

CREATE OR REPLACE FUNCTION fn_contarCitasHoy (
    p_num_identificacion_medico IN VARCHAR2
) RETURN NUMBER IS
    v_cantidad NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_cantidad
    FROM citas_medicas c
    INNER JOIN medicos m ON c.id_medico = m.id_medico
    WHERE m.num_identificacion = p_num_identificacion_medico
    AND TRUNC(c.fecha_cita) = TRUNC(SYSDATE)
    AND c.id_estado = 1; -- Solo citas programadas
    
    RETURN v_cantidad;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1; -- Error
END fn_contarCitasHoy;
/

-- =====================================================
-- VISTA: v_medicos
-- =====================================================

CREATE OR REPLACE VIEW v_medicos AS
SELECT 
    m.nombre,
    m.apellido,
    ti.descripcion AS tipo_identificacion,
    m.num_identificacion,
    fn_contarCitasHoy(m.num_identificacion) AS cantidad_citas_hoy,
    e.nombre_especialidad
FROM medicos m
INNER JOIN tipo_identificacion ti ON m.id_tipo_identificacion = ti.id_tipo_identificacion
INNER JOIN especialidades e ON m.id_especialidad = e.id_especialidad
WHERE m.estado = 'ACTIVO';

-- =====================================================
-- EJEMPLOS DE USO
-- =====================================================

-- Ejemplo 1: Asignar una nueva cita médica
/*
DECLARE
    v_resultado VARCHAR2(200);
    v_id_cita NUMBER;
BEGIN
    sp_asignarCitaMedica(
        p_num_identificacion_paciente => '98765432',
        p_num_identificacion_medico => '12345678',
        p_fecha_cita => SYSDATE + 1,
        p_hora_cita => '14:00',
        p_tipo_cita => 'GENERAL',
        p_observaciones => 'Consulta de seguimiento',
        p_resultado => v_resultado,
        p_id_cita => v_id_cita
    );
    
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_resultado);
    DBMS_OUTPUT.PUT_LINE('ID Cita: ' || v_id_cita);
END;
/
*/

-- Ejemplo 2: Consultar citas de un médico en los últimos 5 días
/*
DECLARE
    v_cursor SYS_REFCURSOR;
    v_id_cita NUMBER;
    v_fecha_cita DATE;
    v_hora_cita VARCHAR2(8);
    v_nombre_paciente VARCHAR2(100);
BEGIN
    sp_consultarCitas('12345678', v_cursor);
    
    LOOP
        FETCH v_cursor INTO v_id_cita, v_fecha_cita, v_hora_cita, v_nombre_paciente;
        EXIT WHEN v_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Cita: ' || v_id_cita || ' - ' || v_fecha_cita || ' ' || v_hora_cita || ' - ' || v_nombre_paciente);
    END LOOP;
    
    CLOSE v_cursor;
END;
/
*/

-- Ejemplo 3: Consultar cantidad de citas de hoy para un médico
/*
SELECT fn_contarCitasHoy('12345678') AS citas_hoy FROM DUAL;
*/

-- Ejemplo 4: Consultar la vista de médicos
/*
SELECT * FROM v_medicos;
*/

-- =====================================================
-- CONSULTAS ÚTILES PARA VERIFICAR EL SISTEMA
-- =====================================================

-- Ver todas las citas programadas
SELECT 
    c.id_cita,
    p.nombre || ' ' || p.apellido AS paciente,
    m.nombre || ' ' || m.apellido AS medico,
    c.fecha_cita,
    c.hora_cita,
    e.descripcion AS estado
FROM citas_medicas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico
JOIN estado_citas e ON c.id_estado = e.id_estado
ORDER BY c.fecha_cita, c.hora_cita;

-- Ver médicos con sus especialidades
SELECT 
    m.nombre || ' ' || m.apellido AS medico,
    m.num_identificacion,
    e.nombre_especialidad
FROM medicos m
JOIN especialidades e ON m.id_especialidad = e.id_especialidad
WHERE m.estado = 'ACTIVO';
