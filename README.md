# 🏥 MYsalud - Sistema de Gestión de Citas Médicas

Un sistema completo de gestión de citas médicas para clínicas en el Eje Cafetero de Colombia. Construido con Oracle Database y diseñado para manejar pacientes, médicos, especialidades y citas médicas de forma eficiente.

## 🚀 Características del Sistema

- **Gestión de Pacientes** - Registro completo con datos personales y de contacto
- **Administración de Médicos** - Control de especialistas y sus especialidades
- **Sistema de Citas** - Programación y seguimiento de citas médicas
- **Especialidades Médicas** - Catálogo completo de especialidades disponibles
- **Procedimientos Almacenados** - Lógica de negocio implementada en la base de datos
- **Validaciones Automáticas** - Prevención de conflictos de horarios

## 📁 Estructura del Proyecto

```
MYsalud/
├── database/
│   ├── schema.sql          # Estructura completa de la base de datos
│   ├── procedures.sql      # Procedimientos almacenados
│   ├── functions.sql       # Funciones de negocio
│   └── sample_data.sql     # Datos de prueba
├── docs/
│   ├── database_design.md  # Documentación del diseño
│   └── user_manual.md      # Manual de usuario
└── README.md               # Este archivo
```

## 🎯 Instalación Rápida

### Prerrequisitos
- Oracle Database 11g o superior
- SQL*Plus o herramienta de administración compatible
- Permisos de creación de tablas y procedimientos

### Pasos de Instalación

1. **Conectar a Oracle**
   ```sql
   sqlplus usuario/contraseña@servidor
   ```

2. **Ejecutar el Script Principal**
   ```sql
   @schema.sql
   ```

3. **Verificar la Instalación**
   ```sql
   SELECT * FROM v_medicos;
   ```

## 🗄️ Estructura de la Base de Datos

### Tablas Principales

- **tipos_identificacion** - Catálogo de tipos de documento
- **especialidades_medicas** - Especialidades disponibles en la clínica
- **medicos** - Información completa de los médicos
- **pacientes** - Registro de pacientes
- **citas_medicas** - Gestión de citas y consultas

### Procedimientos Almacenados

- **sp_asignarCitaMedica** - Programa nuevas citas con validaciones
- **sp_consultarCitas** - Consulta citas de un médico en los últimos 5 días

### Funciones

- **fn_contarCitasHoy** - Cuenta las citas programadas para hoy

### Vistas

- **v_medicos** - Vista completa de médicos con información consolidada

## 💻 Ejemplos de Uso

### Asignar una Nueva Cita

```sql
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
END;
/
```

### Consultar Citas de un Médico

```sql
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    sp_consultarCitas('12345678', v_cursor);
    -- Procesar resultados del cursor
END;
/
```

### Contar Citas del Día

```sql
SELECT fn_contarCitasHoy('12345678') AS citas_hoy FROM DUAL;
```

## 🔧 Personalización

### Agregar Nuevas Especialidades

```sql
INSERT INTO especialidades_medicas VALUES 
(seq_especialidades.NEXTVAL, 'PSIQUIATRIA', 'Especialidad en Psiquiatría');
```

### Modificar Estados de Cita

```sql
-- Agregar nuevos estados según necesidades de la clínica
UPDATE citas_medicas SET estado_cita = 'CONFIRMADA' WHERE id_cita = 1;
```

### Crear Nuevos Reportes

```sql
-- Ejemplo: Reporte de citas por especialidad
SELECT 
    e.nombre_especialidad,
    COUNT(*) as total_citas
FROM citas_medicas c
INNER JOIN medicos m ON c.id_medico = m.id_medico
INNER JOIN especialidades_medicas e ON m.id_especialidad = e.id_especialidad
GROUP BY e.nombre_especialidad;
```

## 📊 Funcionalidades Avanzadas

### Validaciones Implementadas

- **Conflictos de Horario** - Previene doble programación
- **Médicos y Pacientes Activos** - Solo permite citas con usuarios activos
- **Tipos de Identificación** - Validación de documentos colombianos

### Características de Seguridad

- **Transacciones ACID** - Integridad de datos garantizada
- **Manejo de Excepciones** - Control robusto de errores
- **Auditoría** - Registro de fechas de creación y modificación

## 🌟 Casos de Uso

### Para Clínicas Pequeñas
- Control básico de citas y pacientes
- Gestión simple de especialidades
- Reportes de productividad médica

### Para Clínicas Medianas
- Múltiples especialidades y médicos
- Control de disponibilidad avanzado
- Integración con sistemas externos

### Para Hospitales
- Base sólida para sistemas más complejos
- Escalabilidad para múltiples servicios
- Fundamento para historias clínicas

## 📚 Recursos de Aprendizaje

### Conceptos de Base de Datos
- **Normalización** - Diseño eficiente de tablas relacionales
- **Procedimientos Almacenados** - Lógica de negocio en la base de datos
- **Cursores** - Manejo de conjuntos de resultados
- **Secuencias** - Auto-incremento en Oracle

### Oracle Database
- [Documentación Oracle](https://docs.oracle.com/database/) - Guía oficial
- [Oracle SQL Tutorial](https://www.oracle.com/database/technologies/appdev/sql.html) - Tutoriales oficiales
- [PL/SQL Guide](https://docs.oracle.com/database/121/LNPLS/toc.htm) - Manual de PL/SQL

## 🔄 Próximas Mejoras

- **Interface Web** - Frontend para usuarios finales
- **API REST** - Servicios web para integración
- **Reportes Avanzados** - Dashboard con métricas
- **Notificaciones** - Recordatorios automáticos de citas
- **Historia Clínica** - Expediente médico digital

## 🎯 Perfecto Para

- **Estudiantes de Sistemas** - Aprender diseño de bases de datos
- **Desarrolladores Junior** - Entender lógica de negocio médica
- **Administradores de BD** - Practicar Oracle y PL/SQL
- **Emprendedores** - Base para software médico

## 🏢 Contexto Regional

Diseñado específicamente para el **Eje Cafetero Colombiano**:
- Manizales, Pereira, Armenia
- Tipos de identificación colombianos
- Estructura de nombres latinos
- Consideraciones culturales locales

**¿Listo para gestionar citas médicas?** Comienza instalando el esquema y explora cómo los sistemas médicos manejan información crítica de pacientes.
