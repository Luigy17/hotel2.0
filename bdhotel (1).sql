-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 03-03-2022 a las 06:35:32
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdhotel`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CAMBIA` (IN `codem` INT(20), IN `ape` VARCHAR(30), IN `nom` VARCHAR(30), IN `cargo` INT(11))  UPDATE bdhotel.empleado SET 
apempleado=ape,nomempleado=nom,codcargo=cargo
WHERE idempleado=codem$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spAdicion` (IN `ape` CHAR(30), IN `nom` CHAR(30), IN `cargo` CHAR(10))  begin 
declare idempleado char(4); 
declare nro int; 
 
select IFNULL(RIGHT(max(idempleado),3),0)+1 into NRO from empleado 
order by idempleado; 
SET idempleado=CONCAT("A",LPAD(NRO,3,"0")); 
insert into empleado values(idempleado,ape,nom,cargo); 
select idempleado; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPdetalle` (`fac` CHAR(8), `coda` CHAR(6), `can` INT)  BEGIN
insert into facdet values (fac,coda, can);
update servicios set Stock= Stock -can where idHabitacion=coda;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPFACTURA` (IN `codc` CHAR(8), IN `tot` NUMERIC(8,1))  BEGIN
declare nro int;
declare fac char(8);
select ifnull(max(nrofactura),0) + 1  from faccab into nro;
set fac = lpad(nro,8,'0');
insert into faccab values (fac,current_date(),codc,tot);
select fac;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargoempleado`
--

CREATE TABLE `cargoempleado` (
  `codcargo` int(11) NOT NULL,
  `tipocargo` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cargoempleado`
--

INSERT INTO `cargoempleado` (`codcargo`, `tipocargo`) VALUES
(1, 'Botones'),
(2, 'Recepcion'),
(3, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `DNI` int(11) NOT NULL,
  `Correo` varchar(33) NOT NULL,
  `Numero` int(11) NOT NULL,
  `Contraseña` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `Nombre`, `Apellido`, `DNI`, `Correo`, `Numero`, `Contraseña`) VALUES
(2, 'Alex', 'Topo', 85545678, 'asd@gmail.com', 978741978, '123'),
(3, 'Nito', 'Jorge', 18445678, 'ni12@gmail.com', 978975528, '123'),
(4, 'Jorge', 'Chan', 19525678, 'Jj1@gmail.com', 978978888, '123'),
(5, 'Sasha', 'Green', 12311478, 'ashas@gmail.com', 2147483647, '123'),
(7, 'Pablo', 'Backyardigans', 74852200, 'pablitosexy@gmail.com', 65656565, '123'),
(8, 'Pablitoo', 'Backyardigans', 74852200, 'pablitoricosexy@gmail.com', 65656565, '321'),
(9, 'Diego', 'Lancha', 54656562, 'u19204015@utp.edu.pe', 65656565, '456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idempleado` int(11) NOT NULL,
  `apempleado` varchar(22) NOT NULL,
  `nomempleado` varchar(22) NOT NULL,
  `codcargo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idempleado`, `apempleado`, `nomempleado`, `codcargo`) VALUES
(1, 'Sam', 'Alexa', 1),
(2, 'Salvini', 'Susana', 2),
(3, 'Lozano', 'Cinthia', 3),
(4, 'Lola', 'Alberto', 3),
(5, 'Sam', 'Andres', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `faccab`
--

CREATE TABLE `faccab` (
  `NroFact` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `Total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facdet`
--

CREATE TABLE `facdet` (
  `NroFact` int(11) NOT NULL,
  `IdHabitacion` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `IdTipo` char(5) NOT NULL,
  `Descripcion` varchar(33) NOT NULL,
  `Imagen` varchar(33) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `habitaciones`
--

INSERT INTO `habitaciones` (`IdTipo`, `Descripcion`, `Imagen`) VALUES
('H0001', 'SUPERIOR ROOM', 'HAB1.png'),
('H0002', 'SUPERIOR PLUS ROOM', 'HAB2.jpg'),
('H0003', 'EXECUTIVE ROOM', 'HAB3.jpg'),
('H0004', 'JUNIOR SUITE', 'HAB4.jpg'),
('H0005', 'SENIOR SUITE', 'HAB5.jpg'),
('H0006', 'DELUXE SUITE', 'HAB6.jpg'),
('H0007', 'OLIMPO SUITE', 'HAB7.jfif'),
('H0008', 'LUXURY SUITE', 'HAB8.jpg'),
('H0009', 'DIAMOND SUITE', 'HAB9.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `idHabitacion` char(5) NOT NULL,
  `IdTipo` char(5) NOT NULL,
  `Descripcion` varchar(33) NOT NULL,
  `Precio` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `Imagen` varchar(33) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`idHabitacion`, `IdTipo`, `Descripcion`, `Precio`, `Stock`, `Imagen`) VALUES
('A0001', 'H0001', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0002', 'H0001', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0003', 'H0001', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0004', 'H0001', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0005', 'H0001', 'SPA', 55, 2, 'SPA.jpg'),
('A0006', 'H0001', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0007', 'H0001', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0008', 'H0001', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0009', 'H0001', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0010', 'H0001', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0011', 'H0001', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0012', 'H0001', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0013', 'H0002', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0014', 'H0002', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0015', 'H0002', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0016', 'H0002', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0017', 'H0002', 'SPA', 55, 2, 'SPA.jpg'),
('A0018', 'H0002', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0019', 'H0002', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0020', 'H0002', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0021', 'H0002', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0022', 'H0002', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0023', 'H0002', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0024', 'H0002', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0025', 'H0003', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0026', 'H0003', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0027', 'H0003', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0028', 'H0003', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0029', 'H0003', 'SPA', 55, 2, 'SPA.jpg'),
('A0030', 'H0003', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0031', 'H0003', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0032', 'H0003', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0033', 'H0003', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0034', 'H0003', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0035', 'H0003', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0036', 'H0003', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0037', 'H0004', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0038', 'H0004', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0039', 'H0004', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0040', 'H0004', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0041', 'H0004', 'SPA', 55, 2, 'SPA.jpg'),
('A0042', 'H0004', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0043', 'H0004', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0044', 'H0004', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0045', 'H0004', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0046', 'H0004', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0047', 'H0004', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0048', 'H0004', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0049', 'H0005', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0050', 'H0005', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0051', 'H0005', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0052', 'H0005', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0053', 'H0005', 'SPA', 55, 2, 'SPA.jpg'),
('A0054', 'H0005', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0055', 'H0005', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0056', 'H0005', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0057', 'H0005', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0058', 'H0005', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0059', 'H0005', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0060', 'H0005', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0061', 'H0006', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0062', 'H0006', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0063', 'H0006', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0064', 'H0006', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0065', 'H0006', 'SPA', 55, 2, 'SPA.jpg'),
('A0066', 'H0006', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0067', 'H0006', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0068', 'H0006', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0069', 'H0006', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0070', 'H0006', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0071', 'H0006', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0072', 'H0006', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0073', 'H0007', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0074', 'H0007', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0075', 'H0007', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0076', 'H0007', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0077', 'H0007', 'SPA', 55, 2, 'SPA.jpg'),
('A0078', 'H0007', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0079', 'H0007', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0080', 'H0007', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0081', 'H0007', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0082', 'H0007', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0083', 'H0007', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0084', 'H0007', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0085', 'H0008', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0086', 'H0008', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0087', 'H0008', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0088', 'H0008', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0089', 'H0008', 'SPA', 55, 2, 'SPA.jpg'),
('A0090', 'H0008', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0091', 'H0008', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0092', 'H0008', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0093', 'H0008', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0094', 'H0008', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0095', 'H0008', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0096', 'H0008', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0097', 'H0009', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0098', 'H0009', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0099', 'H0009', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0100', 'H0009', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0101', 'H0009', 'SPA', 55, 2, 'SPA.jpg'),
('A0102', 'H0009', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0103', 'H0009', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0104', 'H0009', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0105', 'H0009', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0106', 'H0009', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0107', 'H0009', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0108', 'H0009', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0109', 'H0010', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0110', 'H0010', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0111', 'H0010', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0112', 'H0010', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0113', 'H0010', 'SPA', 55, 2, 'SPA.jpg'),
('A0114', 'H0010', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0115', 'H0010', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0116', 'H0010', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0117', 'H0010', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0118', 'H0010', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0119', 'H0010', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0120', 'H0010', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0121', 'H0011', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0122', 'H0011', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0123', 'H0011', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0124', 'H0011', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0125', 'H0011', 'SPA', 55, 2, 'SPA.jpg'),
('A0126', 'H0011', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0127', 'H0011', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0128', 'H0011', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0129', 'H0011', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0130', 'H0011', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0131', 'H0011', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0132', 'H0011', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg'),
('A0133', 'H0012', 'DESAYUNO ALMUERZO Y CENA', 150, 100, 'DAC.jpg'),
('A0134', 'H0012', 'COCHERA 24Hrs', 50, 100, 'COCHERA.jpg'),
('A0135', 'H0012', 'LAVANDERIA', 10, 500, 'LAVANDERIA.jpg'),
('A0136', 'H0012', 'LIMOSINA', 60, 15, 'LIMO.jpeg'),
('A0137', 'H0012', 'SPA', 55, 2, 'SPA.jpg'),
('A0138', 'H0012', 'CALEFACCION', 10, 44, 'CALEFACCION.jpg'),
('A0139', 'H0012', 'PLAY STATION 5', 70, 155, 'PLAY.jpg'),
('A0140', 'H0012', 'XBOX', 65, 55, 'XBOX.jpg'),
('A0141', 'H0012', 'NINTENDO SWITCH', 40, 150, 'NINTENDO.jpg'),
('A0142', 'H0012', 'PELICULAS', 5, 150, 'PELICULAS.jpg'),
('A0143', 'H0012', 'BOCADILLOS SALADO', 10, 150, 'SALADO.jpg'),
('A0144', 'H0012', 'BOCADILLOS DULCES', 10, 150, 'DULCE.jpg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cargoempleado`
--
ALTER TABLE `cargoempleado`
  ADD PRIMARY KEY (`codcargo`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idempleado`);

--
-- Indices de la tabla `faccab`
--
ALTER TABLE `faccab`
  ADD PRIMARY KEY (`NroFact`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`IdTipo`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`idHabitacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idempleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `faccab`
--
ALTER TABLE `faccab`
  MODIFY `NroFact` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
