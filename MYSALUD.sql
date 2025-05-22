-- =============================================
-- BASE DE DATOS CLÍNICA MYSALUD - EJE CAFETERO
-- Sistema de Gestión de Citas Médicas
-- =============================================

-- 1. CREACIÓN DE TABLAS
-- =============================================

-- Tabla de tipos de identificación
CREATE TABLE tipos_identificacion (
    id_tipo_identificacion NUMBER PRIMARY KEY,
    nombre_tipo VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(100)
);

-- Tabla de especialidades médicas
CREATE TABLE especialidades_medicas (
    id_especialidad NUMBER PRIMARY KEY,
    nombre_especialidad VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(200)
);

-- Tabla de médicos
CREATE TABLE medicos (
    id_medico NUMBER PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    tipo_identificacion NUMBER NOT NULL,
    numero_identificacion VARCHAR2(20) NOT NULL UNIQUE,
    telefono VARCHAR2(15),
    email VARCHAR2(100),
    id_especialidad NUMBER NOT NULL,
    fecha_registro DATE DEFAULT SYSDATE,
    estado VARCHAR2(20) DEFAULT 'ACTIVO',
    CONSTRAINT fk_medicos_tipo_id FOREIGN KEY (tipo_identificacion) 
        REFERENCES tipos_identificacion(id_tipo_identificacion),
    CONSTRAINT fk_medicos_especialidad FOREIGN KEY (id_especialidad) 
        REFERENCES especialidades_medicas(id_especialidad)
);

-- Tabla de pacientes
CREATE TABLE pacientes (
    id_paciente NUMBER PRIMARY KEY,
    nombres VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    tipo_identificacion NUMBER NOT NULL,
    numero_identificacion VARCHAR2(20) NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    telefono VARCHAR2(15),
    email VARCHAR2(100),
    direccion VARCHAR2(200),
    fecha_registro DATE DEFAULT SYSDATE,
    estado VARCHAR2(20) DEFAULT 'ACTIVO',
    CONSTRAINT fk_pacientes_tipo_id FOREIGN KEY (tipo_identificacion) 
        REFERENCES tipos_identificacion(id_tipo_identificacion)
);

-- Tabla de citas médicas
CREATE TABLE citas_medicas (
    id_cita NUMBER PRIMARY KEY,
    id_paciente NUMBER NOT NULL,
    id_medico NUMBER NOT NULL,
    fecha_cita DATE NOT NULL,
    hora_cita VARCHAR2(8) NOT NULL,
    tipo_cita VARCHAR2(50) DEFAULT 'GENERAL',
    motivo_consulta VARCHAR2(500),
    estado_cita VARCHAR2(20) DEFAULT 'PROGRAMADA',
    observaciones VARCHAR2(500),
    fecha_registro DATE DEFAULT SYSDATE,
    CONSTRAINT fk_citas_paciente FOREIGN KEY (id_paciente) 
        REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_citas_medico FOREIGN KEY (id_medico) 
        REFERENCES medicos(id_medico)
);

-- Secuencias para auto-incremento
CREATE SEQUENCE seq_tipos_identificacion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_especialidades START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medicos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pacientes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_citas START WITH 1 INCREMENT BY 1;

-- 2. INSERCIÓN DE DATOS INICIALES
-- =============================================

-- Tipos de identificación
INSERT INTO tipos_identificacion VALUES (seq_tipos_identificacion.NEXTVAL, 'CEDULA_CIUDADANIA', 'Cédula de Ciudadanía');
INSERT INTO tipos_identificacion VALUES (seq_tipos_identificacion.NEXTVAL, 'CEDULA_EXTRANJERIA', 'Cédula de Extranjería');
INSERT INTO tipos_identificacion VALUES (seq_tipos_identificacion.NEXTVAL, 'PASAPORTE', 'Pasaporte');
INSERT INTO tipos_identificacion VALUES (seq_tipos_identificacion.NEXTVAL, 'TARJETA_IDENTIDAD', 'Tarjeta de Identidad');

-- Especialidades médicas
INSERT INTO especialidades_medicas VALUES (seq_especialidades.NEXTVAL, 'MEDICINA_GENERAL', 'Medicina General y Familiar');
INSERT INTO especialidades_medicas VALUES (seq_especialidades.NEXTVAL, 'CARDIOLOGIA', 'Especialidad en Cardiología');
INSERT INTO especialidades_medicas VALUES (seq_especialidades.NEXTVAL, 'DERMATOLOGIA', 'Especialidad en Dermatología');
INSERT INTO especialidades_medicas VALUES (seq_especialidades.NEXTVAL, 'PEDIATRIA', 'Especialidad en Pediatría');
INSERT INTO especialidades_medicas VALUES (seq_especialidades.NEXTVAL, 'GINECOLOGIA', 'Especialidad en Ginecología');
INSERT INTO especialidades_medicas VALUES (seq_especialidades.NEXTVAL, 'NEUROLOGIA', 'Especialidad en Neurología');

-- Médicos
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Carlos Alberto', 'García Mendoza', 1, '12345678', '3201234567', 'carlos.garcia@mysalud.com', 1, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'María Elena', 'Rodríguez López', 1, '23456789', '3207654321', 'maria.rodriguez@mysalud.com', 2, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'José Fernando', 'Martínez Silva', 1, '34567890', '3198765432', 'jose.martinez@mysalud.com', 3, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Ana Sofía', 'Herrera Castro', 1, '45678901', '3112345678', 'ana.herrera@mysalud.com', 4, SYSDATE, 'ACTIVO');
INSERT INTO medicos VALUES (seq_medicos.NEXTVAL, 'Luis Eduardo', 'Pérez Gómez', 1, '56789012', '3156789012', 'luis.perez@mysalud.com', 5, SYSDATE, 'ACTIVO');

-- Pacientes
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Laura', 'Jiménez Vargas', 1, '87654321', TO_DATE('1985-03-15', 'YYYY-MM-DD'), '3109876543', 'laura.jimenez@email.com', 'Cra 15 #25-30, Manizales', SYSDATE, 'ACTIVO');
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Roberto', 'González Díaz', 1, '76543210', TO_DATE('1978-07-22', 'YYYY-MM-DD'), '3187654321', 'roberto.gonzalez@email.com', 'Av 12 de Octubre #40-15, Pereira', SYSDATE, 'ACTIVO');
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Carmen', 'Torres Morales', 1, '65432109', TO_DATE('1992-11-08', 'YYYY-MM-DD'), '3145678901', 'carmen.torres@email.com', 'Calle 20 #18-45, Armenia', SYSDATE, 'ACTIVO');
INSERT INTO pacientes VALUES (seq_pacientes.NEXTVAL, 'Diego', 'Ramírez Quintero', 1, '54321098', TO_DATE('2010-02-14', 'YYYY-MM-DD'), '3123456789', 'diego.ramirez@email.com', 'Cra 8 #12-22, Manizales', SYSDATE, 'ACTIVO');

-- Citas médicas (algunas recientes para las pruebas)
INSERT INTO citas_medicas VALUES (seq_citas.NEXTVAL, 1, 1, SYSDATE, '08:00', 'GENERAL', 'Control médico general', 'PROGRAMADA', NULL, SYSDATE);
INSERT INTO citas_medicas VALUES (seq_citas.NEXTVAL, 2, 2, SYSDATE, '09:30', 'ESPECIALIZADA', 'Control cardiológico', 'PROGRAMADA', NULL, SYSDATE);
INSERT INTO citas_medicas VALUES (seq_citas.NEXTVAL, 3, 1, SYSDATE-1, '10:00', 'GENERAL', 'Consulta por gripe', 'ATENDIDA', 'Paciente mejoró', SYSDATE-1);
INSERT INTO citas_medicas VALUES (seq_citas.NEXTVAL, 4, 4, SYSDATE-2, '14:30', 'ESPECIALIZADA', 'Control pediátrico', 'ATENDIDA', 'Desarrollo normal', SYSDATE-2);
INSERT INTO citas_medicas VALUES (seq_citas.NEXTVAL, 1, 3, SYSDATE-3, '11:15', 'ESPECIALIZADA', 'Consulta dermatológica', 'ATENDIDA', NULL, SYSDATE-3);

COMMIT;

-- 3. PROCEDIMIENTOS ALMACENADOS
-- =============================================

-- Procedimiento para asignar cita médica
CREATE OR REPLACE PROCEDURE sp_asignarCitaMedica (
    p_numero_id_paciente IN VARCHAR2,
    p_numero_id_medico IN VARCHAR2,
    p_fecha_cita IN DATE,
    p_hora_cita IN VARCHAR2,
    p_tipo_cita IN VARCHAR2 DEFAULT 'GENERAL',
    p_motivo_consulta IN VARCHAR2 DEFAULT NULL,
    p_resultado OUT VARCHAR2,
    p_id_cita_generada OUT NUMBER
) AS
    v_id_paciente NUMBER;
    v_id_medico NUMBER;
    v_contador_citas NUMBER;
    v_nueva_cita NUMBER;
BEGIN
    -- Validar que el paciente existe
    SELECT id_paciente INTO v_id_paciente 
    FROM pacientes 
    WHERE numero_identificacion = p_numero_id_paciente AND estado = 'ACTIVO';
    
    -- Validar que el médico existe
    SELECT id_medico INTO v_id_medico 
    FROM medicos 
    WHERE numero_identificacion = p_numero_id_medico AND estado = 'ACTIVO';
    
    -- Verificar disponibilidad del médico en esa fecha y hora
    SELECT COUNT(*) INTO v_contador_citas
    FROM citas_medicas 
    WHERE id_medico = v_id_medico 
    AND TRUNC(fecha_cita) = TRUNC(p_fecha_cita)
    AND hora_cita = p_hora_cita
    AND estado_cita IN ('PROGRAMADA', 'CONFIRMADA');
    
    IF v_contador_citas > 0 THEN
        p_resultado := 'ERROR: El médico ya tiene una cita programada en esa fecha y hora';
        p_id_cita_generada := NULL;
        RETURN;
    END IF;
    
    -- Crear la nueva cita
    SELECT seq_citas.NEXTVAL INTO v_nueva_cita FROM DUAL;
    
    INSERT INTO citas_medicas (
        id_cita, id_paciente, id_medico, fecha_cita, hora_cita, 
        tipo_cita, motivo_consulta, estado_cita, fecha_registro
    ) VALUES (
        v_nueva_cita, v_id_paciente, v_id_medico, p_fecha_cita, p_hora_cita,
        p_tipo_cita, p_motivo_consulta, 'PROGRAMADA', SYSDATE
    );
    
    COMMIT;
    
    p_resultado := 'EXITO: Cita médica asignada correctamente';
    p_id_cita_generada := v_nueva_cita;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_resultado := 'ERROR: Paciente o médico no encontrado';
        p_id_cita_generada := NULL;
    WHEN OTHERS THEN
        ROLLBACK;
        p_resultado := 'ERROR: ' || SQLERRM;
        p_id_cita_generada := NULL;
END sp_asignarCitaMedica;
/

-- Procedimiento para consultar citas de un médico en los últimos 5 días
CREATE OR REPLACE PROCEDURE sp_consultarCitas (
    p_numero_id_medico IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
    v_id_medico NUMBER;
BEGIN
    -- Obtener el ID del médico
    SELECT id_medico INTO v_id_medico 
    FROM medicos 
    WHERE numero_identificacion = p_numero_id_medico AND estado = 'ACTIVO';
    
    -- Abrir cursor con las citas de los últimos 5 días
    OPEN p_cursor FOR
        SELECT 
            c.id_cita,
            c.fecha_cita,
            c.hora_cita,
            c.tipo_cita,
            c.estado_cita,
            c.motivo_consulta,
            p.nombres || ' ' || p.apellidos AS nombre_paciente,
            p.numero_identificacion AS id_paciente,
            p.telefono AS telefono_paciente
        FROM citas_medicas c
        INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
        WHERE c.id_medico = v_id_medico
        AND c.fecha_cita >= SYSDATE - 5
        ORDER BY c.fecha_cita DESC, c.hora_cita;
        
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        OPEN p_cursor FOR SELECT NULL FROM DUAL WHERE 1=0;
    WHEN OTHERS THEN
        OPEN p_cursor FOR SELECT NULL FROM DUAL WHERE 1=0;
END sp_consultarCitas;
/

-- 4. FUNCIÓN PARA CONTAR CITAS DEL DÍA
-- =============================================

CREATE OR REPLACE FUNCTION fn_contarCitasHoy (
    p_numero_id_medico IN VARCHAR2
) RETURN NUMBER AS
    v_id_medico NUMBER;
    v_cantidad_citas NUMBER;
BEGIN
    -- Obtener el ID del médico
    SELECT id_medico INTO v_id_medico 
    FROM medicos 
    WHERE numero_identificacion = p_numero_id_medico AND estado = 'ACTIVO';
    
    -- Contar citas del día de hoy
    SELECT COUNT(*) INTO v_cantidad_citas
    FROM citas_medicas 
    WHERE id_medico = v_id_medico 
    AND TRUNC(fecha_cita) = TRUNC(SYSDATE);
    
    RETURN v_cantidad_citas;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END fn_contarCitasHoy;
/

-- 5. VISTA DE MÉDICOS CON INFORMACIÓN COMPLETA
-- =============================================

CREATE OR REPLACE VIEW v_medicos AS
SELECT 
    m.nombres,
    m.apellidos,
    ti.nombre_tipo AS tipo_identificacion,
    m.numero_identificacion AS num_identificacion,
    fn_contarCitasHoy(m.numero_identificacion) AS cantidad_citas,
    e.nombre_especialidad AS nombre_especialidad
FROM medicos m
INNER JOIN tipos_identificacion ti ON m.tipo_identificacion = ti.id_tipo_identificacion
INNER JOIN especialidades_medicas e ON m.id_especialidad = e.id_especialidad
WHERE m.estado = 'ACTIVO';

-- 6. EJEMPLOS DE USO
-- =============================================

/*
-- Ejemplo 1: Asignar una nueva cita médica
DECLARE
    v_resultado VARCHAR2(200);
    v_id_cita NUMBER;
BEGIN
    sp_asignarCitaMedica(
        p_numero_id_paciente => '87654321',
        p_numero_id_medico => '12345678',
        p_fecha_cita => SYSDATE + 1,
        p_hora_cita => '15:30',
        p_tipo_cita => 'GENERAL',
        p_motivo_consulta => 'Control médico preventivo',
        p_resultado => v_resultado,
        p_id_cita_generada => v_id_cita
    );
    
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_resultado);
    DBMS_OUTPUT.PUT_LINE('ID Cita: ' || v_id_cita);
END;
/

-- Ejemplo 2: Consultar citas de un médico
DECLARE
    v_cursor SYS_REFCURSOR;
    v_id_cita NUMBER;
    v_fecha_cita DATE;
    v_hora_cita VARCHAR2(8);
    v_tipo_cita VARCHAR2(50);
    v_estado_cita VARCHAR2(20);
    v_motivo VARCHAR2(500);
    v_nombre_paciente VARCHAR2(200);
    v_id_paciente VARCHAR2(20);
    v_telefono VARCHAR2(15);
BEGIN
    sp_consultarCitas('12345678', v_cursor);
    
    LOOP
        FETCH v_cursor INTO v_id_cita, v_fecha_cita, v_hora_cita, v_tipo_cita, 
              v_estado_cita, v_motivo, v_nombre_paciente, v_id_paciente, v_telefono;
        EXIT WHEN v_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Cita ID: ' || v_id_cita || ' - Paciente: ' || v_nombre_paciente || 
                            ' - Fecha: ' || TO_CHAR(v_fecha_cita, 'DD/MM/YYYY') || 
                            ' - Hora: ' || v_hora_cita);
    END LOOP;
    
    CLOSE v_cursor;
END;
/

-- Ejemplo 3: Usar la función para contar citas
SELECT fn_contarCitasHoy('12345678') AS citas_hoy_dr_garcia FROM DUAL;

-- Ejemplo 4: Consultar la vista de médicos
SELECT * FROM v_medicos;
*/
