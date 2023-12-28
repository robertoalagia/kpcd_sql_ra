-- Limpieza de tablas antes de ejecutar la Query
DROP TABLE IF EXISTS purchase;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS subject;
DROP TABLE IF EXISTS content;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS student;

-- Crear la tabla student
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    lastname VARCHAR(255),
    identification VARCHAR(50),
    identification_type VARCHAR(20),
    email VARCHAR(255),
    phone VARCHAR(20),
    status VARCHAR(20),
    bank_account VARCHAR(50)
);

ALTER TABLE student
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE student
ALTER COLUMN email SET NOT NULL;

-- Crear la tabla teacher
CREATE TABLE teacher (
    teacher_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    lastname VARCHAR(255),
    identification VARCHAR(50),
    identification_type VARCHAR(20),
    email VARCHAR(255),
    phone VARCHAR(20),
    status VARCHAR(20),
    bank_account VARCHAR(50)
);

-- Crear la tabla content
CREATE TABLE content (
    content_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    url_media VARCHAR(100),
    url_attachments VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

-- Crear la tabla subject
CREATE TABLE subject (
    subject_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    content_id INT,
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

-- Crear la tabla course
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    edition VARCHAR(10),
    initial_date DATE,
    end_date DATE,
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

-- Crear la tabla purchase
CREATE TABLE purchase (
    purchase_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    purchase_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);


INSERT INTO student (name, lastname, identification, identification_type, email, phone, status, bank_account) VALUES
('Carlos', 'Ramírez', '12345678', 'DNI', 'carlos.ramirez@email.com', '981-828384', 'ACTIVE', 'ES12345678901234567890'),
('Julia', 'Santos', '87654321', 'DNI', 'julia.santos@email.com', '985-868788', 'ACTIVE', 'ES09876543210987654321'),
('Andrés', 'Luna', '56789012', 'DNI', 'andres.luna@email.com', '989-909192', 'ALUMNI', 'ES56789012345678901234'),
('Marina', 'Gómez', '90123456', 'DNI', 'marina.gomez@email.com', '993-939495', 'ACTIVE', 'ES90123456789012345678'),
('Roberto', 'Vega', '34567890', 'DNI', 'roberto.vega@email.com', '997-979899', 'ALUMNI', 'ES34567890123456789012'),
('Adriana', 'Mendoza', '23456789', 'DNI', 'adriana.mendoza@email.com', '901-020304', 'ACTIVE', 'ES23456789012345678901'),
('Ricardo', 'Herrera', '78901234', 'DNI', 'ricardo.herrera@email.com', '905-060708', 'ALUMNI', 'ES78901234567890123456'),
('Diana', 'Cruz', '67890123', 'DNI', 'diana.cruz@email.com', '909-101112', 'ACTIVE', 'ES67890123456789012345'),
('Fernando', 'Paz', '01234567', 'DNI', 'fernando.paz@email.com', '913-131415', 'ALUMNI', 'ES01234567890123456789'),
('Carolina', 'Rojas', '45678901', 'DNI', 'carolina.rojas@email.com', '917-161718', 'ACTIVE', 'ES45678901234567890123'),
('Gabriel', 'Ortega', '21098765', 'DNI', 'gabriel.ortega@email.com', '921-212223', 'ALUMNI', 'ES21098765432109876543'),
('Valeria', 'Silva', '54321098', 'DNI', 'valeria.silva@email.com', '925-262728', 'ACTIVE', 'ES54321098765432109876'),
('Mateo', 'Torres', '78901234', 'DNI', 'mateo.torres@email.com', '929-303132', 'ALUMNI', 'ES78901234567890123456'),
('Camila', 'Flores', '34567890', 'DNI', 'camila.flores@email.com', '933-343536', 'ACTIVE', 'ES34567890123456789012'),
('Alejandro', 'García', '90123456', 'DNI', 'alejandro.garcia@email.com', '937-373839', 'ALUMNI', 'ES90123456789012345678'),
('Luisa', 'Martínez', '67890123', 'DNI', 'luisa.martinez@email.com', '941-414243', 'ACTIVE', 'ES67890123456789012345'),
('Martín', 'Reyes', '12345678', 'DNI', 'martin.reyes@email.com', '945-454647', 'ALUMNI', 'ES12345678901234567890'),
('Sandra', 'Hernández', '21098765', 'DNI', 'sandra.hernandez@email.com', '949-495051', 'ACTIVE', 'ES21098765432109876543'),
('Esteban', 'Gómez', '45678901', 'DNI', 'esteban.gomez@email.com', '953-535455', 'ALUMNI', 'ES45678901234567890123'),
('Paola', 'Vargas', '78901234', 'DNI', 'paola.vargas@email.com', '957-575859', 'ACTIVE', 'ES78901234567890123456');

INSERT INTO teacher (name, lastname, identification, identification_type, email, phone, status, bank_account) VALUES
('Gabriela', 'López', '1234567A', 'DNI', 'gabriela.lopez@email.com', '981-828384', 'ACTIVO', 'ES1234567890'),
('Martín', 'Sánchez', '7654321B', 'DNI', 'martin.sanchez@email.com', '985-868788', 'INACTIVO', 'ES0987654321'),
('Laura', 'García', '9876543C', 'DNI', 'laura.garcia@email.com', '989-909192', 'ACTIVO', 'ES5678901234'),
('Diego', 'Martínez', '2345678D', 'DNI', 'diego.martinez@email.com', '993-939495', 'INACTIVO', 'ES9012345678'),
('Carolina', 'Fernández', '8765432E', 'DNI', 'carolina.fernandez@email.com', '997-979899', 'ACTIVO', 'ES3456789012'),
('Andrés', 'Rodríguez', '3456789F', 'DNI', 'andres.rodriguez@email.com', '901-020304', 'INACTIVO', 'ES2345678901'),
('Sofía', 'Gómez', '6543210G', 'DNI', 'sofia.gomez@email.com', '905-060708', 'ACTIVO', 'ES7890123456');

INSERT INTO content (name, description, url_media, url_attachments, teacher_id) VALUES
('Programación Básica - Introducción', 'Conceptos iniciales de programación', 'https://ejemplo.com/media1', 'https://ejemplo.com/attachments1', 1),
('Bases de Datos - Modelado', 'Modelado de datos y normalización', 'https://ejemplo.com/media2', 'https://ejemplo.com/attachments2', 2),
('Desarrollo Web Frontend - HTML', 'Fundamentos de HTML para desarrollo web', 'https://ejemplo.com/media3', 'https://ejemplo.com/attachments3', 3),
('Programación Orientada a Objetos - Principios', 'Principios básicos de la programación orientada a objetos', 'https://ejemplo.com/media4', 'https://ejemplo.com/attachments4', 4),
('Frameworks de Desarrollo Web - Introducción', 'Introducción a frameworks populares para desarrollo web', 'https://ejemplo.com/media5', 'https://ejemplo.com/attachments5', 5),
('Algoritmos y Estructuras de Datos - Fundamentos', 'Conceptos fundamentales de algoritmos y estructuras de datos', 'https://ejemplo.com/media6', 'https://ejemplo.com/attachments6', 6),
('Inteligencia Artificial - Bases', 'Bases de la inteligencia artificial y machine learning', 'https://ejemplo.com/media7', 'https://ejemplo.com/attachments7', 7),
('Desarrollo Móvil - Android', 'Desarrollo de aplicaciones para Android', 'https://ejemplo.com/media8', 'https://ejemplo.com/attachments8', 1),
('Big Data Fundamentals - Introducción', 'Conceptos básicos de Big Data', 'https://ejemplo.com/media9', 'https://ejemplo.com/attachments9', 2),
('Machine Learning Avanzado - Práctica', 'Aplicaciones avanzadas de machine learning', 'https://ejemplo.com/media10', 'https://ejemplo.com/attachments10', 3),
('Cloud Computing - Servicios', 'Principales servicios en la nube', 'https://ejemplo.com/media11', 'https://ejemplo.com/attachments11', 4),
('Seguridad Informática - Fundamentos', 'Principios básicos de seguridad informática', 'https://ejemplo.com/media12', 'https://ejemplo.com/attachments12', 5),
('Redes y Comunicaciones - Conceptos', 'Conceptos básicos de redes y comunicaciones', 'https://ejemplo.com/media13', 'https://ejemplo.com/attachments13', 6),
('Análisis de Datos - Herramientas', 'Herramientas para análisis de datos', 'https://ejemplo.com/media14', 'https://ejemplo.com/attachments14', 7),
('Desarrollo Ágil - Metodologías', 'Metodologías ágiles en el desarrollo de software', 'https://ejemplo.com/media15', 'https://ejemplo.com/attachments15', 1),
('Programación Avanzada - Avances', 'Avances en programación avanzada', 'https://ejemplo.com/media16', 'https://ejemplo.com/attachments16', 2),
('UX/UI Design - Principios', 'Principios de diseño de experiencia de usuario e interfaz', 'https://ejemplo.com/media17', 'https://ejemplo.com/attachments17', 3),
('Arquitectura de Software - Diseño', 'Diseño y arquitectura de software', 'https://ejemplo.com/media18', 'https://ejemplo.com/attachments18', 4),
('Gestión de Proyectos - Fundamentos', 'Fundamentos de gestión de proyectos de software', 'https://ejemplo.com/media19', 'https://ejemplo.com/attachments19', 5),
('Ética en la Tecnología - Consideraciones', 'Consideraciones éticas en la industria tecnológica', 'https://ejemplo.com/media20', 'https://ejemplo.com/attachments20', 6),
('Emprendimiento Tecnológico - Aspectos', 'Aspectos empresariales y emprendimiento en tecnología', 'https://ejemplo.com/media21', 'https://ejemplo.com/attachments21', 7),
('Automatización de Pruebas - Herramientas', 'Herramientas para automatización de pruebas', 'https://ejemplo.com/media22', 'https://ejemplo.com/attachments22', 1),
('IoT y Dispositivos Conectados - Conceptos', 'Conceptos fundamentales de IoT y dispositivos conectados', 'https://ejemplo.com/media23', 'https://ejemplo.com/attachments23', 2),
('Blockchain Fundamentals - Introducción', 'Introducción a los fundamentos de la tecnología blockchain', 'https://ejemplo.com/media24', 'https://ejemplo.com/attachments24', 3),
('Realidad Virtual y Aumentada - Conceptos', 'Conceptos y aplicaciones en realidad virtual y aumentada', 'https://ejemplo.com/media25', 'https://ejemplo.com/attachments25', 4),
('Desarrollo de Videojuegos - Principios', 'Principios y conceptos básicos en desarrollo de videojuegos', 'https://ejemplo.com/media26', 'https://ejemplo.com/attachments26', 5),
('Ciberseguridad Avanzada - Práctica', 'Prácticas avanzadas en seguridad informática', 'https://ejemplo.com/media27', 'https://ejemplo.com/attachments27', 6),
('Computación Cuántica - Introducción', 'Introducción a los conceptos de computación cuántica', 'https://ejemplo.com/media28', 'https://ejemplo.com/attachments28', 7),
('Robótica y Automatización - Aplicaciones', 'Aplicaciones de robótica y automatización', 'https://ejemplo.com/media29', 'https://ejemplo.com/attachments29', 1),
('Economía Digital - Perspectivas', 'Perspectivas económicas en la era digital', 'https://ejemplo.com/media30', 'https://ejemplo.com/attachments30', 2),
('Programación Básica - Estructuras', 'Estructuras de programación básica', 'https://ejemplo.com/media31', 'https://ejemplo.com/attachments31', 3),
('Bases de Datos - SQL Avanzado', 'Conceptos avanzados de SQL y bases de datos', 'https://ejemplo.com/media32', 'https://ejemplo.com/attachments32', 4),
('Desarrollo Web Frontend - CSS Avanzado', 'Uso avanzado de CSS en desarrollo web', 'https://ejemplo.com/media33', 'https://ejemplo.com/attachments33', 5),
('Programación Orientada a Objetos - Patrones', 'Patrones en programación orientada a objetos', 'https://ejemplo.com/media34', 'https://ejemplo.com/attachments34', 6),
('Frameworks de Desarrollo Web - Práctica', 'Prácticas avanzadas en frameworks de desarrollo web', 'https://ejemplo.com/media35', 'https://ejemplo.com/attachments35', 7);

INSERT INTO subject (name, description, content_id) VALUES
('Programación Básica', 'Fundamentos de la lógica de programación y estructuras de control', 1),
('Bases de Datos', 'Introducción a bases de datos relacionales y SQL', 2),
('Desarrollo Web Frontend', 'HTML, CSS y JavaScript para la construcción de interfaces web', 3),
('Programación Orientada a Objetos', 'Conceptos y prácticas en la programación orientada a objetos', 4),
('Frameworks de Desarrollo Web', 'Uso de frameworks populares para desarrollo web', 5),
('Algoritmos y Estructuras de Datos', 'Estudio de algoritmos y estructuras de datos básicas', 6),
('Inteligencia Artificial', 'Conceptos básicos de inteligencia artificial y machine learning', 7),
('Desarrollo Móvil', 'Creación de aplicaciones móviles para sistemas iOS y Android', 8),
('Big Data Fundamentals', 'Introducción a los fundamentos del Big Data', 9),
('Machine Learning Avanzado', 'Aplicaciones avanzadas de machine learning', 10),
('Cloud Computing', 'Conceptos y prácticas en servicios de computación en la nube', 11),
('Seguridad Informática', 'Principios básicos de seguridad informática', 12),
('Redes y Comunicaciones', 'Estudio de redes de computadoras y comunicaciones', 13),
('Análisis de Datos', 'Herramientas y técnicas para análisis de datos', 14),
('Desarrollo Ágil', 'Metodologías ágiles en el desarrollo de software', 15),
('Programación Avanzada', 'Programación avanzada en diversos lenguajes', 16),
('UX/UI Design', 'Principios de diseño de experiencia de usuario e interfaz', 17),
('Arquitectura de Software', 'Diseño y arquitectura de software', 18),
('Gestión de Proyectos', 'Fundamentos de gestión y dirección de proyectos de software', 19),
('Ética en la Tecnología', 'Consideraciones éticas en la industria tecnológica', 20),
('Emprendimiento Tecnológico', 'Aspectos empresariales y emprendimiento en tecnología', 21),
('Automatización de Pruebas', 'Uso de herramientas para automatización de pruebas', 22),
('IoT y Dispositivos Conectados', 'Internet de las cosas y dispositivos conectados', 23),
('Blockchain Fundamentals', 'Introducción a la tecnología blockchain', 24),
('Realidad Virtual y Aumentada', 'Conceptos y aplicaciones en VR y AR', 25),
('Desarrollo de Videojuegos', 'Creación de videojuegos y conceptos básicos', 26),
('Ciberseguridad Avanzada', 'Técnicas avanzadas en seguridad informática', 27),
('Computación Cuántica', 'Introducción a la computación cuántica', 28),
('Robótica y Automatización', 'Conceptos y aplicaciones en robótica', 29),
('Economía Digital', 'Aspectos económicos de la era digital', 30);

INSERT INTO course (name, edition, initial_date, end_date, subject_id) VALUES
('Aprende a Programar desde Cero Full Stack Jr. Bootcamp', 1, '2018-06-10', '2018-12-15', 1),
('Big Data, Inteligencia Artificial & Machine Learning Full Stack Bootcamp', 1, '2019-02-20', '2019-08-25', 6),
('Desarrollo de Apps Móviles iOS Full Stack Bootcamp', 1, '2020-04-05', '2020-10-10', 11),
('Aprende a Programar desde Cero Full Stack Jr. Bootcamp', 2, '2018-08-15', '2019-02-20', 2),
('Big Data, Inteligencia Artificial & Machine Learning Full Stack Bootcamp', 2, '2019-06-25', '2020-01-30', 7),
('Desarrollo de Apps Móviles iOS Full Stack Bootcamp', 2, '2020-09-10', '2021-03-17', 12),
('Aprende a Programar desde Cero Full Stack Jr. Bootcamp', 3, '2019-10-20', '2020-04-25', 3),
('Big Data, Inteligencia Artificial & Machine Learning Full Stack Bootcamp', 3, '2020-12-05', '2021-06-10', 8),
('Desarrollo de Apps Móviles iOS Full Stack Bootcamp', 3, '2021-11-15', '2022-05-20', 13),
('Aprende a Programar desde Cero Full Stack Jr. Bootcamp', 4, '2020-01-30', '2020-08-05', 4),
('Big Data, Inteligencia Artificial & Machine Learning Full Stack Bootcamp', 4, '2021-03-10', '2021-09-15', 9),
('Desarrollo de Apps Móviles iOS Full Stack Bootcamp', 4, '2022-02-25', '2022-09-30', 14),
('Aprende a Programar desde Cero Full Stack Jr. Bootcamp', 5, '2021-05-05', '2021-11-10', 5),
('Big Data, Inteligencia Artificial & Machine Learning Full Stack Bootcamp', 5, '2022-06-15', '2022-12-20', 10),
('Desarrollo de Apps Móviles iOS Full Stack Bootcamp', 5, '2023-04-10', '2023-10-15', 15);

INSERT INTO purchase (student_id, course_id, purchase_date, status) VALUES
(1, 1, '2020-05-12', 'APPROVED'),
(2, 2, '2020-07-23', 'APPROVED'),
(3, 3, '2020-09-05', 'DENIED'),
(4, 1, '2020-10-18', 'APPROVED'),
(5, 2, '2021-01-22', 'APPROVED'),
(6, 3, '2021-03-14', 'APPROVED'),
(7, 1, '2021-06-30', 'APPROVED'),
(8, 2, '2021-09-17', 'APPROVED'),
(9, 3, '2021-11-04', 'APPROVED'),
(10, 1, '2022-02-08', 'APPROVED'),
(11, 2, '2022-04-19', 'APPROVED'),
(12, 3, '2022-07-07', 'APPROVED'),
(13, 1, '2022-09-25', 'APPROVED'),
(14, 2, '2022-11-11', 'APPROVED'),
(15, 3, '2023-01-03', 'APPROVED'),
(16, 1, '2023-03-18', 'APPROVED'),
(17, 2, '2023-06-22', 'APPROVED'),
(18, 3, '2023-08-09', 'DENIED'),
(19, 1, '2023-10-30', 'APPROVED'),
(20, 2, '2023-12-15', 'APPROVED'),
(1, 3, '2020-08-11', 'APPROVED'),
(2, 1, '2020-11-28', 'APPROVED'),
(3, 2, '2021-02-14', 'APPROVED'),
(4, 3, '2021-04-29', 'APPROVED'),
(5, 1, '2021-07-07', 'APPROVED'),
(6, 2, '2021-10-12', 'DENIED'),
(7, 3, '2022-01-20', 'APPROVED'),
(8, 1, '2022-04-05', 'APPROVED'),
(9, 2, '2022-06-19', 'APPROVED'),
(10, 3, '2022-09-03', 'APPROVED');