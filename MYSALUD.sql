-- Crear la base de datos
CREATE DATABASE MYSALUD;
USE MYSALUD;

-- Crear tabla especialidad
CREATE TABLE especialidad (
    esp_id INT(10) PRIMARY KEY,
    esp_nombre VARCHAR(45) NOT NULL
);

-- Crear tabla medico
CREATE TABLE medico (
    med_num_ident INT(10) PRIMARY KEY,
    med_nombre VARCHAR(45) NOT NULL,
    med_apellido VARCHAR(45) NOT NULL,
    med_tipo_ident VARCHAR(45) NOT NULL,
    med_num_tarj_prof VARCHAR(45) NOT NULL,
    med_estado INT(1) NOT NULL,
    med_genero VARCHAR(1) NOT NULL
);

-- Crear tabla paciente
CREATE TABLE paciente (
    pac_id_paciente INT(10) PRIMARY KEY,
    pac_nombre VARCHAR(45) NOT NULL,
    pac_apellido VARCHAR(45) NOT NULL,
    pac_tipo_ident VARCHAR(45) NOT NULL,
    pac_num_ident VARCHAR(45) NOT NULL,
    pac_genero VARCHAR(1) NOT NULL,
    pac_fecha_nac DATE NOT NULL,
    pac_telf_fijo INT(12),
    pac_movil VARCHAR(45) NOT NULL,
    pac_estatura DOUBLE
);

-- Crear tabla medioesp (relación muchos a muchos entre médico y especialidad)
CREATE TABLE medioesp (
    mxe_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    mxe_id_medico INT(10) NOT NULL,
    mxe_id_especialidad INT(10) NOT NULL,
    FOREIGN KEY (mxe_id_medico) REFERENCES medico(med_num_ident),
    FOREIGN KEY (mxe_id_especialidad) REFERENCES especialidad(esp_id)
);

-- Crear tabla cita
CREATE TABLE cita (
    cit_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    cit_hora TIME NOT NULL,
    cit_fecha DATE NOT NULL,
    cit_id_medico INT(10) NOT NULL,
    cit_id_paciente INT(10) NOT NULL,
    cit_estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (cit_id_medico) REFERENCES medico(med_num_ident),
    FOREIGN KEY (cit_id_paciente) REFERENCES paciente(pac_id_paciente)
);

-- Insertar especialidades
INSERT INTO especialidad VALUES (1, 'Medicina General');
INSERT INTO especialidad VALUES (2, 'Cardiología');
INSERT INTO especialidad VALUES (3, 'Dermatología');
INSERT INTO especialidad VALUES (4, 'Pediatría');
INSERT INTO especialidad VALUES (5, 'Ginecología');

-- Insertar médicos
INSERT INTO medico VALUES (1001, 'Juan', 'Pérez', 'CC', 'TP001', 1, 'M');
INSERT INTO medico VALUES (1002, 'María', 'López', 'CC', 'TP002', 1, 'F');
INSERT INTO medico VALUES (1003, 'Carlos', 'Rodríguez', 'CC', 'TP003', 1, 'M');
INSERT INTO medico VALUES (1004, 'Ana', 'Martínez', 'CE', 'TP004', 1, 'F');
INSERT INTO medico VALUES (1005, 'Pedro', 'Sánchez', 'CC', 'TP005', 1, 'M');

-- Insertar pacientes
INSERT INTO paciente VALUES (1, 'Luis', 'García', 'CC', '2001', 'M', '1980-05-15', 6072345, '3102345678', 1.75);
INSERT INTO paciente VALUES (2, 'Carmen', 'Díaz', 'TI', '2002', 'F', '1995-08-20', 6073456, '3153456789', 1.65);
INSERT INTO paciente VALUES (3, 'Roberto', 'Fernández', 'CC', '2003', 'M', '1975-12-10', 6074567, '3204567890', 1.80);
INSERT INTO paciente VALUES (4, 'Sofía', 'Torres', 'CE', '2004', 'F', '1990-03-25', 6075678, '3135678901', 1.70);
INSERT INTO paciente VALUES (5, 'Javier', 'Gómez', 'CC', '2005', 'M', '1985-07-30', 6076789, '3176789012', 1.78);

-- Insertar relaciones médico-especialidad
INSERT INTO medioesp (mxe_id_medico, mxe_id_especialidad) VALUES (1001, 1);
INSERT INTO medioesp (mxe_id_medico, mxe_id_especialidad) VALUES (1002, 2);
INSERT INTO medioesp (mxe_id_medico, mxe_id_especialidad) VALUES (1002, 3);
INSERT INTO medioesp (mxe_id_medico, mxe_id_especialidad) VALUES (1003, 4);
INSERT INTO medioesp (mxe_id_medico, mxe_id_especialidad) VALUES (1004, 5);
INSERT INTO medioesp (mxe_id_medico, mxe_id_especialidad) VALUES (1005, 1);

-- Insertar citas (algunas con fechas dinámicas para simular citas recientes)
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('08:00:00', CURDATE(), 1001, 1, 'Programada');
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('09:30:00', CURDATE(), 1001, 2, 'Programada');
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('10:15:00', DATE_SUB(CURDATE(), INTERVAL 1 DAY), 1002, 3, 'Atendida');
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('14:00:00', DATE_SUB(CURDATE(), INTERVAL 2 DAY), 1003, 4, 'Atendida');
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('16:30:00', DATE_SUB(CURDATE(), INTERVAL 3 DAY), 1001, 5, 'Atendida');
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('11:00:00', DATE_SUB(CURDATE(), INTERVAL 4 DAY), 1002, 1, 'Atendida');
INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado) 
VALUES ('15:45:00', DATE_ADD(CURDATE(), INTERVAL 1 DAY), 1004, 2, 'Programada');

DELIMITER //
CREATE PROCEDURE sp_asignarCitaMedica(
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_medico_id INT,
    IN p_paciente_id INT,
    OUT p_mensaje VARCHAR(100)
)
BEGIN
    DECLARE v_cita_existente INT DEFAULT 0;
    DECLARE v_medico_existe INT DEFAULT 0;
    DECLARE v_paciente_existe INT DEFAULT 0;
    
    -- Verificar si el médico existe
    SELECT COUNT(*) INTO v_medico_existe FROM medico WHERE med_num_ident = p_medico_id;
    
    -- Verificar si el paciente existe
    SELECT COUNT(*) INTO v_paciente_existe FROM paciente WHERE pac_id_paciente = p_paciente_id;
    
    -- Verificar si ya existe una cita con el mismo médico, fecha y hora
    SELECT COUNT(*) INTO v_cita_existente 
    FROM cita 
    WHERE cit_id_medico = p_medico_id 
    AND cit_fecha = p_fecha 
    AND cit_hora = p_hora;
    
    -- Validaciones
    IF v_medico_existe = 0 THEN
        SET p_mensaje = 'Error: El médico no existe en el sistema';
    ELSEIF v_paciente_existe = 0 THEN
        SET p_mensaje = 'Error: El paciente no existe en el sistema';
    ELSEIF v_cita_existente > 0 THEN
        SET p_mensaje = 'Error: El médico ya tiene una cita asignada en esa fecha y hora';
    ELSE
        -- Insertar la cita
        INSERT INTO cita (cit_hora, cit_fecha, cit_id_medico, cit_id_paciente, cit_estado)
        VALUES (p_hora, p_fecha, p_medico_id, p_paciente_id, 'Programada');
        
        SET p_mensaje = 'Cita médica asignada exitosamente';
    END IF;
END //
DELIMITER ;