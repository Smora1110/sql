CREATE DATABASE orientacion;
USE orientacion;


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

    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
) ENGINE=InnoDB;


CREATE TABLE usuario_programa (
    id_usuario INT,
    id_programa INT,
    fecha_inscripcion DATE NOT NULL,

    PRIMARY KEY (id_usuario, id_programa),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_programa)
        REFERENCES programa_orientacion(id_programa)
        ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE usuario_discapacidad (
    id_usuario INT,
    id_tipo_discapacidad INT,

    PRIMARY KEY (id_usuario, id_tipo_discapacidad),

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE,

    FOREIGN KEY (id_tipo_discapacidad)
        REFERENCES tipo_discapacidad(id_tipo_discapacidad)
        ON DELETE CASCADE
) ENGINE=InnoDB;