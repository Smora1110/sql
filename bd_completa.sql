-- =====================================================
-- CREACIÓN BASE DE DATOS
-- =====================================================

DROP DATABASE IF EXISTS orientacion1;
CREATE DATABASE orientacion1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE orientacion1;

-- =====================================================
-- TABLAS CATÁLOGO
-- =====================================================

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tipo_identificacion (
    id_tipo_identificacion INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE orientacion_sexual (
    id_orientacion_sexual INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE condicion_ocupacional (
    id_condicion_ocupacional INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE nivel_educativo (
    id_nivel_educativo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE zona (
    id_zona INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE comuna (
    id_comuna INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE barrio (
    id_barrio INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE grupo_etnico (
    id_grupo_etnico INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tipo_discapacidad (
    id_tipo_discapacidad INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- =====================================================
-- TABLAS PRINCIPALES
-- =====================================================

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_identificacion INT NOT NULL,
    id_genero INT NOT NULL,
    id_orientacion_sexual INT NOT NULL,
    id_condicion_ocupacional INT NOT NULL,
    id_nivel_educativo INT NOT NULL,
    id_zona INT NOT NULL,
    id_comuna INT NOT NULL,
    id_barrio INT NOT NULL,
    id_grupo_etnico INT NOT NULL,
    cabeza_familia BOOLEAN NOT NULL,
    experiencia_migratoria_familia BOOLEAN NOT NULL,
    persona_condicion_discapacidad BOOLEAN NOT NULL,

    FOREIGN KEY (id_tipo_identificacion) REFERENCES tipo_identificacion(id_tipo_identificacion),
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero),
    FOREIGN KEY (id_orientacion_sexual) REFERENCES orientacion_sexual(id_orientacion_sexual),
    FOREIGN KEY (id_condicion_ocupacional) REFERENCES condicion_ocupacional(id_condicion_ocupacional),
    FOREIGN KEY (id_nivel_educativo) REFERENCES nivel_educativo(id_nivel_educativo),
    FOREIGN KEY (id_zona) REFERENCES zona(id_zona),
    FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna),
    FOREIGN KEY (id_barrio) REFERENCES barrio(id_barrio),
    FOREIGN KEY (id_grupo_etnico) REFERENCES grupo_etnico(id_grupo_etnico)
) ENGINE=InnoDB;

CREATE TABLE programa_orientacion (
    id_programa INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    periodo VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
) ENGINE=InnoDB;

CREATE TABLE usuario_programa (
    id_usuario INT,
    id_programa INT,
    fecha_inscripcion DATE NOT NULL,
    PRIMARY KEY (id_usuario, id_programa),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_programa) REFERENCES programa_orientacion(id_programa) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE usuario_discapacidad (
    id_usuario INT,
    id_tipo_discapacidad INT,
    PRIMARY KEY (id_usuario, id_tipo_discapacidad),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_discapacidad) REFERENCES tipo_discapacidad(id_tipo_discapacidad) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA RAW
-- =====================================================

CREATE TABLE usuario_raw (
    id_raw INT AUTO_INCREMENT PRIMARY KEY,
    CATEGORIA VARCHAR(100),
    PERIODO VARCHAR(20),
    GENERO VARCHAR(50),
    EDAD INT,
    TIPO_DE_IDENTIFICACION VARCHAR(100),
    PERSONAS_EN_CONDICION_DE_DISCAPACIDAD VARCHAR(10),
    TIPO_DE_DISCAPACIDAD VARCHAR(100),
    HOMBRES_Y_MUJERES_CABEZA_DE_FAMILIA VARCHAR(10),
    ORIENTACION_SEXUAL_COMUNIDAD_LGTBI VARCHAR(100),
    EXPERIENCIA_MIGRATORIA_DENTRO_DEL_NUCLEO_FAMILIAR VARCHAR(10),
    GRUPOS_ETNICOS_AFRO_INDIGENA VARCHAR(100),
    NIVEL_EDUCATIVO_QUE_TIENE_O_CURSA VARCHAR(100),
    CONDICION_OCUPACIONAL VARCHAR(100),
    BARRIO_O_VEREDA_DE_RESIDENCIA VARCHAR(150),
    COMUNA_O_CORREGIMIENTO_DE_RESIDENCIA VARCHAR(100),
    ZONA_DE_RESIDENCIA VARCHAR(50)
) ENGINE=InnoDB;

-- =====================================================
-- CARGAR CSV EN TABLA RAW
-- =====================================================

LOAD DATA INFILE '/Users/sebastianmora/downloads/Consolidado_de_usuarios_orientados_en_el_programa_de_apoyo_social_a_la_juventud_y_adulto_mayor_20260205.csv'

INTO TABLE usuario_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    CATEGORIA,
    PERIODO,
    GENERO,
    EDAD,
    TIPO_DE_IDENTIFICACION,
    PERSONAS_EN_CONDICION_DE_DISCAPACIDAD,
    TIPO_DE_DISCAPACIDAD,
    HOMBRES_Y_MUJERES_CABEZA_DE_FAMILIA,
    ORIENTACION_SEXUAL_COMUNIDAD_LGTBI,
    EXPERIENCIA_MIGRATORIA_DENTRO_DEL_NUCLEO_FAMILIAR,
    GRUPOS_ETNICOS_AFRO_INDIGENA,
    NIVEL_EDUCATIVO_QUE_TIENE_O_CURSA,
    CONDICION_OCUPACIONAL,
    BARRIO_O_VEREDA_DE_RESIDENCIA,
    COMUNA_O_CORREGIMIENTO_DE_RESIDENCIA,
    ZONA_DE_RESIDENCIA
);
-- =====================================================
-- ÍNDICES PARA OPTIMIZAR JOIN
-- =====================================================

CREATE INDEX idx_genero_desc ON genero(descripcion);
CREATE INDEX idx_tipo_id_desc ON tipo_identificacion(descripcion);
CREATE INDEX idx_orientacion_desc ON orientacion_sexual(descripcion);
CREATE INDEX idx_condicion_desc ON condicion_ocupacional(descripcion);
CREATE INDEX idx_nivel_desc ON nivel_educativo(descripcion);
CREATE INDEX idx_zona_desc ON zona(descripcion);
CREATE INDEX idx_comuna_desc ON comuna(descripcion);
CREATE INDEX idx_barrio_desc ON barrio(descripcion);
CREATE INDEX idx_grupo_desc ON grupo_etnico(descripcion);
CREATE INDEX idx_categoria_desc ON categoria(descripcion);
CREATE INDEX idx_discapacidad_desc ON tipo_discapacidad(descripcion);

-- =====================================================
-- INSERTS A TABLAS CATÁLOGO
-- =====================================================

INSERT INTO categoria (descripcion)
SELECT DISTINCT CATEGORIA FROM usuario_raw WHERE CATEGORIA IS NOT NULL AND CATEGORIA <> '';

INSERT INTO tipo_identificacion (descripcion)
SELECT DISTINCT TIPO_DE_IDENTIFICACION FROM usuario_raw WHERE TIPO_DE_IDENTIFICACION IS NOT NULL AND TIPO_DE_IDENTIFICACION <> '';

INSERT INTO genero (descripcion)
SELECT DISTINCT GENERO FROM usuario_raw WHERE GENERO IS NOT NULL AND GENERO <> '';

INSERT INTO orientacion_sexual (descripcion)
SELECT DISTINCT ORIENTACION_SEXUAL_COMUNIDAD_LGTBI FROM usuario_raw WHERE ORIENTACION_SEXUAL_COMUNIDAD_LGTBI IS NOT NULL AND ORIENTACION_SEXUAL_COMUNIDAD_LGTBI <> '';

INSERT INTO condicion_ocupacional (descripcion)
SELECT DISTINCT CONDICION_OCUPACIONAL FROM usuario_raw WHERE CONDICION_OCUPACIONAL IS NOT NULL AND CONDICION_OCUPACIONAL <> '';

INSERT INTO nivel_educativo (descripcion)
SELECT DISTINCT NIVEL_EDUCATIVO_QUE_TIENE_O_CURSA FROM usuario_raw WHERE NIVEL_EDUCATIVO_QUE_TIENE_O_CURSA IS NOT NULL AND NIVEL_EDUCATIVO_QUE_TIENE_O_CURSA <> '';

INSERT INTO zona (descripcion)
SELECT DISTINCT ZONA_DE_RESIDENCIA FROM usuario_raw WHERE ZONA_DE_RESIDENCIA IS NOT NULL AND ZONA_DE_RESIDENCIA <> '';

INSERT INTO comuna (descripcion)
SELECT DISTINCT COMUNA_O_CORREGIMIENTO_DE_RESIDENCIA FROM usuario_raw WHERE COMUNA_O_CORREGIMIENTO_DE_RESIDENCIA IS NOT NULL AND COMUNA_O_CORREGIMIENTO_DE_RESIDENCIA <> '';

INSERT INTO barrio (descripcion)
SELECT DISTINCT BARRIO_O_VEREDA_DE_RESIDENCIA FROM usuario_raw WHERE BARRIO_O_VEREDA_DE_RESIDENCIA IS NOT NULL AND BARRIO_O_VEREDA_DE_RESIDENCIA <> '';

INSERT INTO grupo_etnico (descripcion)
SELECT DISTINCT GRUPOS_ETNICOS_AFRO_INDIGENA FROM usuario_raw WHERE GRUPOS_ETNICOS_AFRO_INDIGENA IS NOT NULL AND GRUPOS_ETNICOS_AFRO_INDIGENA <> '';

INSERT INTO tipo_discapacidad (descripcion)
SELECT DISTINCT TIPO_DE_DISCAPACIDAD FROM usuario_raw 
WHERE TIPO_DE_DISCAPACIDAD IS NOT NULL 
AND TIPO_DE_DISCAPACIDAD <> '' 
AND UPPER(TIPO_DE_DISCAPACIDAD) <> 'NINGUNA';

-- =====================================================
-- INSERTAR PROGRAMAS
-- =====================================================

INSERT INTO programa_orientacion (id_categoria, periodo)
SELECT cat.id_categoria, r.PERIODO
FROM usuario_raw r
JOIN categoria cat ON cat.descripcion = r.CATEGORIA
GROUP BY cat.id_categoria, r.PERIODO;

-- =====================================================
-- INSERTAR USUARIOS
-- =====================================================

INSERT INTO usuario (
    id_tipo_identificacion,
    id_genero,
    id_orientacion_sexual,
    id_condicion_ocupacional,
    id_nivel_educativo,
    id_zona,
    id_comuna,
    id_barrio,
    id_grupo_etnico,
    cabeza_familia,
    experiencia_migratoria_familia,
    persona_condicion_discapacidad
)
SELECT 
    ti.id_tipo_identificacion,
    g.id_genero,
    os.id_orientacion_sexual,
    co.id_condicion_ocupacional,
    ne.id_nivel_educativo,
    z.id_zona,
    c.id_comuna,
    b.id_barrio,
    ge.id_grupo_etnico,
    IF(UPPER(r.HOMBRES_Y_MUJERES_CABEZA_DE_FAMILIA)='SI',1,0),
    IF(UPPER(r.EXPERIENCIA_MIGRATORIA_DENTRO_DEL_NUCLEO_FAMILIAR)='SI',1,0),
    IF(UPPER(r.PERSONAS_EN_CONDICION_DE_DISCAPACIDAD)='SI',1,0)
FROM usuario_raw r
JOIN tipo_identificacion ti ON ti.descripcion = r.TIPO_DE_IDENTIFICACION
JOIN genero g ON g.descripcion = r.GENERO
JOIN orientacion_sexual os ON os.descripcion = r.ORIENTACION_SEXUAL_COMUNIDAD_LGTBI
JOIN condicion_ocupacional co ON co.descripcion = r.CONDICION_OCUPACIONAL
JOIN nivel_educativo ne ON ne.descripcion = r.NIVEL_EDUCATIVO_QUE_TIENE_O_CURSA
JOIN zona z ON z.descripcion = r.ZONA_DE_RESIDENCIA
JOIN comuna c ON c.descripcion = r.COMUNA_O_CORREGIMIENTO_DE_RESIDENCIA
JOIN barrio b ON b.descripcion = r.BARRIO_O_VEREDA_DE_RESIDENCIA
JOIN grupo_etnico ge ON ge.descripcion = r.GRUPOS_ETNICOS_AFRO_INDIGENA;

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================