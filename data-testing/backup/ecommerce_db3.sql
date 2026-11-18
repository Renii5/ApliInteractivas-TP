-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce_db3
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ecommerce_db3`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ecommerce_db3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ecommerce_db3`;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKjo3wdfqn510qwk6ffx5v9nua8` (`usuario_id`),
  CONSTRAINT `FKbunaoq2qnb3gd29rcqv2e2dal` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (3,3);
INSERT INTO `carrito` VALUES (4,5);
INSERT INTO `carrito` VALUES (5,6);
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito_productos`
--

DROP TABLE IF EXISTS `carrito_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito_productos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `carrito_id` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKhl2fn0dglrc1wmq1n20o1ttkv` (`carrito_id`,`producto_id`),
  KEY `FKrr2eeenu25syrgds4bjnjpwvg` (`producto_id`),
  CONSTRAINT `FKgme90f3af0hqrr2cov1anylu` FOREIGN KEY (`carrito_id`) REFERENCES `carrito` (`id`),
  CONSTRAINT `FKrr2eeenu25syrgds4bjnjpwvg` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito_productos`
--

LOCK TABLES `carrito_productos` WRITE;
/*!40000 ALTER TABLE `carrito_productos` DISABLE KEYS */;
INSERT INTO `carrito_productos` VALUES (3,2,4,39);
INSERT INTO `carrito_productos` VALUES (5,1,4,94);
INSERT INTO `carrito_productos` VALUES (6,1,5,39);
/*!40000 ALTER TABLE `carrito_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Placas de video');
INSERT INTO `categorias` VALUES (2,'Procesadores');
INSERT INTO `categorias` VALUES (3,'Memorias RAM');
INSERT INTO `categorias` VALUES (4,'Almacenamiento');
INSERT INTO `categorias` VALUES (5,'Perifericos');
INSERT INTO `categorias` VALUES (6,'Monitores');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `producto_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKovhcwkc0487ugetvikcdu71sm` (`usuario_id`,`producto_id`),
  KEY `FKrxdxytf48cr005vej8540b0rr` (`producto_id`),
  CONSTRAINT `FKq9wif2hcqfxj8t49wo613wm0h` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `FKrxdxytf48cr005vej8540b0rr` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (2,39,5);
INSERT INTO `favoritos` VALUES (6,137,5);
INSERT INTO `favoritos` VALUES (7,39,6);
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_items`
--

DROP TABLE IF EXISTS `orden_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orden_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `precio_unitario` double NOT NULL,
  `orden_id` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKaod0hti8wc34ydrspxdy3p1u` (`orden_id`),
  KEY `FKbhwqeqpprymrjtleqds6i60hu` (`producto_id`),
  CONSTRAINT `FKaod0hti8wc34ydrspxdy3p1u` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `FKbhwqeqpprymrjtleqds6i60hu` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_items`
--

LOCK TABLES `orden_items` WRITE;
/*!40000 ALTER TABLE `orden_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `orden_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes`
--

DROP TABLE IF EXISTS `ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime(6) NOT NULL,
  `total` double NOT NULL,
  `comprador_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfuraeosc5ddtyavbi3o1e46cv` (`comprador_id`),
  CONSTRAINT `FKfuraeosc5ddtyavbi3o1e46cv` FOREIGN KEY (`comprador_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes`
--

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_imagenes`
--

DROP TABLE IF EXISTS `producto_imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto_imagenes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `orden` int NOT NULL,
  `url` varchar(2048) NOT NULL,
  `producto_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKo89u1q4jan8gbgod33hv48u27` (`producto_id`),
  CONSTRAINT `FKo89u1q4jan8gbgod33hv48u27` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_imagenes`
--

LOCK TABLES `producto_imagenes` WRITE;
/*!40000 ALTER TABLE `producto_imagenes` DISABLE KEYS */;
INSERT INTO `producto_imagenes` VALUES (1,2,'http://localhost:8080/images/nvidia-geforce-rtx-5090-asus-rog-astral-32gb.jpg',20);
INSERT INTO `producto_imagenes` VALUES (2,1,'http://localhost:8080/images/nvidia-geforce-rtx-5090-asus-rog-astral-32gb.jpg',20);
INSERT INTO `producto_imagenes` VALUES (3,0,'http://localhost:8080/images/nvidia-geforce-rtx-5090-asus-rog-astral-32gb.jpg',20);
INSERT INTO `producto_imagenes` VALUES (4,2,'http://localhost:8080/images/nvidia-geforce-rtx-5080-msi-gaming-trio-16gb.jpg',21);
INSERT INTO `producto_imagenes` VALUES (5,1,'http://localhost:8080/images/nvidia-geforce-rtx-5080-msi-gaming-trio-16gb.jpg',21);
INSERT INTO `producto_imagenes` VALUES (6,0,'http://localhost:8080/images/nvidia-geforce-rtx-5080-msi-gaming-trio-16gb.jpg',21);
INSERT INTO `producto_imagenes` VALUES (7,2,'http://localhost:8080/images/nvidia-geforce-rtx-5070-ti-gigabyte-windforce-16gb.jpg',22);
INSERT INTO `producto_imagenes` VALUES (8,1,'http://localhost:8080/images/nvidia-geforce-rtx-5070-ti-gigabyte-windforce-16gb.jpg',22);
INSERT INTO `producto_imagenes` VALUES (9,0,'http://localhost:8080/images/nvidia-geforce-rtx-5070-ti-gigabyte-windforce-16gb.jpg',22);
INSERT INTO `producto_imagenes` VALUES (10,2,'http://localhost:8080/images/nvidia-geforce-rtx-5070-zotac-twin-edge-12gb.jpg',23);
INSERT INTO `producto_imagenes` VALUES (11,1,'http://localhost:8080/images/nvidia-geforce-rtx-5070-zotac-twin-edge-12gb.jpg',23);
INSERT INTO `producto_imagenes` VALUES (12,0,'http://localhost:8080/images/nvidia-geforce-rtx-5070-zotac-twin-edge-12gb.jpg',23);
INSERT INTO `producto_imagenes` VALUES (13,2,'http://localhost:8080/images/nvidia-geforce-rtx-5060-ti-asus-dual-16gb.jpg',24);
INSERT INTO `producto_imagenes` VALUES (14,1,'http://localhost:8080/images/nvidia-geforce-rtx-5060-ti-asus-dual-16gb.jpg',24);
INSERT INTO `producto_imagenes` VALUES (15,0,'http://localhost:8080/images/nvidia-geforce-rtx-5060-ti-asus-dual-16gb.jpg',24);
INSERT INTO `producto_imagenes` VALUES (16,2,'http://localhost:8080/images/nvidia-geforce-rtx-5060-pny-8gb.jpg',25);
INSERT INTO `producto_imagenes` VALUES (17,1,'http://localhost:8080/images/nvidia-geforce-rtx-5060-pny-8gb.jpg',25);
INSERT INTO `producto_imagenes` VALUES (18,0,'http://localhost:8080/images/nvidia-geforce-rtx-5060-pny-8gb.jpg',25);
INSERT INTO `producto_imagenes` VALUES (19,2,'http://localhost:8080/images/nvidia-geforce-rtx-4070-super-asus-dual-12gb.jpg',26);
INSERT INTO `producto_imagenes` VALUES (20,1,'http://localhost:8080/images/nvidia-geforce-rtx-4070-super-asus-dual-12gb.jpg',26);
INSERT INTO `producto_imagenes` VALUES (21,0,'http://localhost:8080/images/nvidia-geforce-rtx-4070-super-asus-dual-12gb.jpg',26);
INSERT INTO `producto_imagenes` VALUES (22,2,'http://localhost:8080/images/nvidia-geforce-rtx-4060-msi-ventus-2x-8gb.jpg',27);
INSERT INTO `producto_imagenes` VALUES (23,1,'http://localhost:8080/images/nvidia-geforce-rtx-4060-msi-ventus-2x-8gb.jpg',27);
INSERT INTO `producto_imagenes` VALUES (24,0,'http://localhost:8080/images/nvidia-geforce-rtx-4060-msi-ventus-2x-8gb.jpg',27);
INSERT INTO `producto_imagenes` VALUES (25,2,'http://localhost:8080/images/nvidia-geforce-rtx-3060-gigabyte-gaming-oc-12gb.jpg',28);
INSERT INTO `producto_imagenes` VALUES (26,1,'http://localhost:8080/images/nvidia-geforce-rtx-3060-gigabyte-gaming-oc-12gb.jpg',28);
INSERT INTO `producto_imagenes` VALUES (27,0,'http://localhost:8080/images/nvidia-geforce-rtx-3060-gigabyte-gaming-oc-12gb.jpg',28);
INSERT INTO `producto_imagenes` VALUES (28,2,'http://localhost:8080/images/amd-radeon-rx-9070-xt-sapphire-pulse-16gb.jpg',29);
INSERT INTO `producto_imagenes` VALUES (29,1,'http://localhost:8080/images/amd-radeon-rx-9070-xt-sapphire-pulse-16gb.jpg',29);
INSERT INTO `producto_imagenes` VALUES (30,0,'http://localhost:8080/images/amd-radeon-rx-9070-xt-sapphire-pulse-16gb.jpg',29);
INSERT INTO `producto_imagenes` VALUES (31,2,'http://localhost:8080/images/amd-radeon-rx-9070-powercolor-reaper-16gb.jpg',30);
INSERT INTO `producto_imagenes` VALUES (32,1,'http://localhost:8080/images/amd-radeon-rx-9070-powercolor-reaper-16gb.jpg',30);
INSERT INTO `producto_imagenes` VALUES (33,0,'http://localhost:8080/images/amd-radeon-rx-9070-powercolor-reaper-16gb.jpg',30);
INSERT INTO `producto_imagenes` VALUES (34,2,'http://localhost:8080/images/amd-radeon-rx-9060-xt-xfx-swift-16gb.jpg',31);
INSERT INTO `producto_imagenes` VALUES (35,1,'http://localhost:8080/images/amd-radeon-rx-9060-xt-xfx-swift-16gb.jpg',31);
INSERT INTO `producto_imagenes` VALUES (36,0,'http://localhost:8080/images/amd-radeon-rx-9060-xt-xfx-swift-16gb.jpg',31);
INSERT INTO `producto_imagenes` VALUES (37,2,'http://localhost:8080/images/amd-radeon-rx-7900-xtx-sapphire-nitro-24gb.jpg',32);
INSERT INTO `producto_imagenes` VALUES (38,1,'http://localhost:8080/images/amd-radeon-rx-7900-xtx-sapphire-nitro-24gb.jpg',32);
INSERT INTO `producto_imagenes` VALUES (39,0,'http://localhost:8080/images/amd-radeon-rx-7900-xtx-sapphire-nitro-24gb.jpg',32);
INSERT INTO `producto_imagenes` VALUES (40,2,'http://localhost:8080/images/amd-radeon-rx-7800-xt-asrock-challenger-16gb.jpg',33);
INSERT INTO `producto_imagenes` VALUES (41,1,'http://localhost:8080/images/amd-radeon-rx-7800-xt-asrock-challenger-16gb.jpg',33);
INSERT INTO `producto_imagenes` VALUES (42,0,'http://localhost:8080/images/amd-radeon-rx-7800-xt-asrock-challenger-16gb.jpg',33);
INSERT INTO `producto_imagenes` VALUES (43,2,'http://localhost:8080/images/amd-radeon-rx-7600-gigabyte-gaming-oc-8gb.jpg',34);
INSERT INTO `producto_imagenes` VALUES (44,1,'http://localhost:8080/images/amd-radeon-rx-7600-gigabyte-gaming-oc-8gb.jpg',34);
INSERT INTO `producto_imagenes` VALUES (45,0,'http://localhost:8080/images/amd-radeon-rx-7600-gigabyte-gaming-oc-8gb.jpg',34);
INSERT INTO `producto_imagenes` VALUES (46,2,'http://localhost:8080/images/intel-arc-b580-limited-edition-12gb.jpg',35);
INSERT INTO `producto_imagenes` VALUES (47,1,'http://localhost:8080/images/intel-arc-b580-limited-edition-12gb.jpg',35);
INSERT INTO `producto_imagenes` VALUES (48,0,'http://localhost:8080/images/intel-arc-b580-limited-edition-12gb.jpg',35);
INSERT INTO `producto_imagenes` VALUES (49,2,'http://localhost:8080/images/intel-arc-a750-asrock-challenger-8gb.jpg',36);
INSERT INTO `producto_imagenes` VALUES (50,1,'http://localhost:8080/images/intel-arc-a750-asrock-challenger-8gb.jpg',36);
INSERT INTO `producto_imagenes` VALUES (51,0,'http://localhost:8080/images/intel-arc-a750-asrock-challenger-8gb.jpg',36);
INSERT INTO `producto_imagenes` VALUES (52,2,'http://localhost:8080/images/nvidia-geforce-gtx-1650-msi-ventus-xs-4gb.jpg',37);
INSERT INTO `producto_imagenes` VALUES (53,1,'http://localhost:8080/images/nvidia-geforce-gtx-1650-msi-ventus-xs-4gb.jpg',37);
INSERT INTO `producto_imagenes` VALUES (54,0,'http://localhost:8080/images/nvidia-geforce-gtx-1650-msi-ventus-xs-4gb.jpg',37);
INSERT INTO `producto_imagenes` VALUES (55,2,'http://localhost:8080/images/nvidia-geforce-rtx-3050-asus-dual-6gb.jpg',38);
INSERT INTO `producto_imagenes` VALUES (56,1,'http://localhost:8080/images/nvidia-geforce-rtx-3050-asus-dual-6gb.jpg',38);
INSERT INTO `producto_imagenes` VALUES (57,0,'http://localhost:8080/images/nvidia-geforce-rtx-3050-asus-dual-6gb.jpg',38);
INSERT INTO `producto_imagenes` VALUES (58,2,'http://localhost:8080/images/amd-radeon-rx-6600-xfx-speedster-swft-8gb.jpg',39);
INSERT INTO `producto_imagenes` VALUES (59,1,'http://localhost:8080/images/amd-radeon-rx-6600-xfx-speedster-swft-8gb.jpg',39);
INSERT INTO `producto_imagenes` VALUES (60,0,'http://localhost:8080/images/amd-radeon-rx-6600-xfx-speedster-swft-8gb.jpg',39);
INSERT INTO `producto_imagenes` VALUES (61,2,'http://localhost:8080/images/amd-ryzen-9-9950x3d.jpg',40);
INSERT INTO `producto_imagenes` VALUES (62,1,'http://localhost:8080/images/amd-ryzen-9-9950x3d.jpg',40);
INSERT INTO `producto_imagenes` VALUES (63,0,'http://localhost:8080/images/amd-ryzen-9-9950x3d.jpg',40);
INSERT INTO `producto_imagenes` VALUES (64,2,'http://localhost:8080/images/amd-ryzen-9-9950x.jpg',41);
INSERT INTO `producto_imagenes` VALUES (65,1,'http://localhost:8080/images/amd-ryzen-9-9950x.jpg',41);
INSERT INTO `producto_imagenes` VALUES (66,0,'http://localhost:8080/images/amd-ryzen-9-9950x.jpg',41);
INSERT INTO `producto_imagenes` VALUES (67,2,'http://localhost:8080/images/amd-ryzen-9-9900x.jpg',42);
INSERT INTO `producto_imagenes` VALUES (68,1,'http://localhost:8080/images/amd-ryzen-9-9900x.jpg',42);
INSERT INTO `producto_imagenes` VALUES (69,0,'http://localhost:8080/images/amd-ryzen-9-9900x.jpg',42);
INSERT INTO `producto_imagenes` VALUES (70,2,'http://localhost:8080/images/amd-ryzen-7-9800x3d.jpg',43);
INSERT INTO `producto_imagenes` VALUES (71,1,'http://localhost:8080/images/amd-ryzen-7-9800x3d.jpg',43);
INSERT INTO `producto_imagenes` VALUES (72,0,'http://localhost:8080/images/amd-ryzen-7-9800x3d.jpg',43);
INSERT INTO `producto_imagenes` VALUES (73,2,'http://localhost:8080/images/amd-ryzen-7-9700x.jpg',44);
INSERT INTO `producto_imagenes` VALUES (74,1,'http://localhost:8080/images/amd-ryzen-7-9700x.jpg',44);
INSERT INTO `producto_imagenes` VALUES (75,0,'http://localhost:8080/images/amd-ryzen-7-9700x.jpg',44);
INSERT INTO `producto_imagenes` VALUES (76,2,'http://localhost:8080/images/amd-ryzen-7-7800x3d.jpg',45);
INSERT INTO `producto_imagenes` VALUES (77,1,'http://localhost:8080/images/amd-ryzen-7-7800x3d.jpg',45);
INSERT INTO `producto_imagenes` VALUES (78,0,'http://localhost:8080/images/amd-ryzen-7-7800x3d.jpg',45);
INSERT INTO `producto_imagenes` VALUES (79,2,'http://localhost:8080/images/amd-ryzen-7-7700.jpg',46);
INSERT INTO `producto_imagenes` VALUES (80,1,'http://localhost:8080/images/amd-ryzen-7-7700.jpg',46);
INSERT INTO `producto_imagenes` VALUES (81,0,'http://localhost:8080/images/amd-ryzen-7-7700.jpg',46);
INSERT INTO `producto_imagenes` VALUES (82,2,'http://localhost:8080/images/amd-ryzen-5-9600x.jpg',47);
INSERT INTO `producto_imagenes` VALUES (83,1,'http://localhost:8080/images/amd-ryzen-5-9600x.jpg',47);
INSERT INTO `producto_imagenes` VALUES (84,0,'http://localhost:8080/images/amd-ryzen-5-9600x.jpg',47);
INSERT INTO `producto_imagenes` VALUES (85,2,'http://localhost:8080/images/amd-ryzen-5-7600.jpg',48);
INSERT INTO `producto_imagenes` VALUES (86,1,'http://localhost:8080/images/amd-ryzen-5-7600.jpg',48);
INSERT INTO `producto_imagenes` VALUES (87,0,'http://localhost:8080/images/amd-ryzen-5-7600.jpg',48);
INSERT INTO `producto_imagenes` VALUES (88,2,'http://localhost:8080/images/amd-ryzen-5-5600x.jpg',49);
INSERT INTO `producto_imagenes` VALUES (89,1,'http://localhost:8080/images/amd-ryzen-5-5600x.jpg',49);
INSERT INTO `producto_imagenes` VALUES (90,0,'http://localhost:8080/images/amd-ryzen-5-5600x.jpg',49);
INSERT INTO `producto_imagenes` VALUES (91,2,'http://localhost:8080/images/amd-ryzen-5-5600g.jpg',50);
INSERT INTO `producto_imagenes` VALUES (92,1,'http://localhost:8080/images/amd-ryzen-5-5600g.jpg',50);
INSERT INTO `producto_imagenes` VALUES (93,0,'http://localhost:8080/images/amd-ryzen-5-5600g.jpg',50);
INSERT INTO `producto_imagenes` VALUES (94,2,'http://localhost:8080/images/amd-ryzen-7-5700x3d.jpg',51);
INSERT INTO `producto_imagenes` VALUES (95,1,'http://localhost:8080/images/amd-ryzen-7-5700x3d.jpg',51);
INSERT INTO `producto_imagenes` VALUES (96,0,'http://localhost:8080/images/amd-ryzen-7-5700x3d.jpg',51);
INSERT INTO `producto_imagenes` VALUES (97,2,'http://localhost:8080/images/intel-core-ultra-9-285k.jpg',52);
INSERT INTO `producto_imagenes` VALUES (98,1,'http://localhost:8080/images/intel-core-ultra-9-285k.jpg',52);
INSERT INTO `producto_imagenes` VALUES (99,0,'http://localhost:8080/images/intel-core-ultra-9-285k.jpg',52);
INSERT INTO `producto_imagenes` VALUES (100,2,'http://localhost:8080/images/intel-core-ultra-7-265k.jpg',53);
INSERT INTO `producto_imagenes` VALUES (101,1,'http://localhost:8080/images/intel-core-ultra-7-265k.jpg',53);
INSERT INTO `producto_imagenes` VALUES (102,0,'http://localhost:8080/images/intel-core-ultra-7-265k.jpg',53);
INSERT INTO `producto_imagenes` VALUES (103,2,'http://localhost:8080/images/intel-core-ultra-5-245k.jpg',54);
INSERT INTO `producto_imagenes` VALUES (104,1,'http://localhost:8080/images/intel-core-ultra-5-245k.jpg',54);
INSERT INTO `producto_imagenes` VALUES (105,0,'http://localhost:8080/images/intel-core-ultra-5-245k.jpg',54);
INSERT INTO `producto_imagenes` VALUES (106,2,'http://localhost:8080/images/intel-core-i9-14900k.jpg',55);
INSERT INTO `producto_imagenes` VALUES (107,1,'http://localhost:8080/images/intel-core-i9-14900k.jpg',55);
INSERT INTO `producto_imagenes` VALUES (108,0,'http://localhost:8080/images/intel-core-i9-14900k.jpg',55);
INSERT INTO `producto_imagenes` VALUES (109,2,'http://localhost:8080/images/intel-core-i7-14700k.jpg',56);
INSERT INTO `producto_imagenes` VALUES (110,1,'http://localhost:8080/images/intel-core-i7-14700k.jpg',56);
INSERT INTO `producto_imagenes` VALUES (111,0,'http://localhost:8080/images/intel-core-i7-14700k.jpg',56);
INSERT INTO `producto_imagenes` VALUES (112,2,'http://localhost:8080/images/intel-core-i5-14400f.jpg',57);
INSERT INTO `producto_imagenes` VALUES (113,1,'http://localhost:8080/images/intel-core-i5-14400f.jpg',57);
INSERT INTO `producto_imagenes` VALUES (114,0,'http://localhost:8080/images/intel-core-i5-14400f.jpg',57);
INSERT INTO `producto_imagenes` VALUES (115,2,'http://localhost:8080/images/intel-core-i5-12400f.jpg',58);
INSERT INTO `producto_imagenes` VALUES (116,1,'http://localhost:8080/images/intel-core-i5-12400f.jpg',58);
INSERT INTO `producto_imagenes` VALUES (117,0,'http://localhost:8080/images/intel-core-i5-12400f.jpg',58);
INSERT INTO `producto_imagenes` VALUES (118,2,'http://localhost:8080/images/intel-core-i3-12100.jpg',59);
INSERT INTO `producto_imagenes` VALUES (119,1,'http://localhost:8080/images/intel-core-i3-12100.jpg',59);
INSERT INTO `producto_imagenes` VALUES (120,0,'http://localhost:8080/images/intel-core-i3-12100.jpg',59);
INSERT INTO `producto_imagenes` VALUES (121,2,'http://localhost:8080/images/kingston-fury-beast-ddr5-32gb-2x16gb-6000mhz.jpg',60);
INSERT INTO `producto_imagenes` VALUES (122,1,'http://localhost:8080/images/kingston-fury-beast-ddr5-32gb-2x16gb-6000mhz.jpg',60);
INSERT INTO `producto_imagenes` VALUES (123,0,'http://localhost:8080/images/kingston-fury-beast-ddr5-32gb-2x16gb-6000mhz.jpg',60);
INSERT INTO `producto_imagenes` VALUES (124,2,'http://localhost:8080/images/kingston-fury-beast-rgb-ddr5-64gb-2x32gb-6000mhz.jpg',61);
INSERT INTO `producto_imagenes` VALUES (125,1,'http://localhost:8080/images/kingston-fury-beast-rgb-ddr5-64gb-2x32gb-6000mhz.jpg',61);
INSERT INTO `producto_imagenes` VALUES (126,0,'http://localhost:8080/images/kingston-fury-beast-rgb-ddr5-64gb-2x32gb-6000mhz.jpg',61);
INSERT INTO `producto_imagenes` VALUES (127,2,'http://localhost:8080/images/corsair-vengeance-rgb-ddr5-32gb-2x16gb-6400mhz.jpg',62);
INSERT INTO `producto_imagenes` VALUES (128,1,'http://localhost:8080/images/corsair-vengeance-rgb-ddr5-32gb-2x16gb-6400mhz.jpg',62);
INSERT INTO `producto_imagenes` VALUES (129,0,'http://localhost:8080/images/corsair-vengeance-rgb-ddr5-32gb-2x16gb-6400mhz.jpg',62);
INSERT INTO `producto_imagenes` VALUES (130,2,'http://localhost:8080/images/corsair-vengeance-ddr5-16gb-5600mhz.jpg',63);
INSERT INTO `producto_imagenes` VALUES (131,1,'http://localhost:8080/images/corsair-vengeance-ddr5-16gb-5600mhz.jpg',63);
INSERT INTO `producto_imagenes` VALUES (132,0,'http://localhost:8080/images/corsair-vengeance-ddr5-16gb-5600mhz.jpg',63);
INSERT INTO `producto_imagenes` VALUES (133,2,'http://localhost:8080/images/g-skill-trident-z5-rgb-ddr5-32gb-2x16gb-7200mhz.jpg',64);
INSERT INTO `producto_imagenes` VALUES (134,1,'http://localhost:8080/images/g-skill-trident-z5-rgb-ddr5-32gb-2x16gb-7200mhz.jpg',64);
INSERT INTO `producto_imagenes` VALUES (135,0,'http://localhost:8080/images/g-skill-trident-z5-rgb-ddr5-32gb-2x16gb-7200mhz.jpg',64);
INSERT INTO `producto_imagenes` VALUES (136,2,'http://localhost:8080/images/g-skill-flare-x5-ddr5-32gb-2x16gb-6000mhz.jpg',65);
INSERT INTO `producto_imagenes` VALUES (137,1,'http://localhost:8080/images/g-skill-flare-x5-ddr5-32gb-2x16gb-6000mhz.jpg',65);
INSERT INTO `producto_imagenes` VALUES (138,0,'http://localhost:8080/images/g-skill-flare-x5-ddr5-32gb-2x16gb-6000mhz.jpg',65);
INSERT INTO `producto_imagenes` VALUES (139,2,'http://localhost:8080/images/teamgroup-t-force-delta-rgb-ddr5-32gb-2x16gb-6000mhz.jpg',66);
INSERT INTO `producto_imagenes` VALUES (140,1,'http://localhost:8080/images/teamgroup-t-force-delta-rgb-ddr5-32gb-2x16gb-6000mhz.jpg',66);
INSERT INTO `producto_imagenes` VALUES (141,0,'http://localhost:8080/images/teamgroup-t-force-delta-rgb-ddr5-32gb-2x16gb-6000mhz.jpg',66);
INSERT INTO `producto_imagenes` VALUES (142,2,'http://localhost:8080/images/adata-xpg-lancer-blade-ddr5-32gb-2x16gb-6000mhz.jpg',67);
INSERT INTO `producto_imagenes` VALUES (143,1,'http://localhost:8080/images/adata-xpg-lancer-blade-ddr5-32gb-2x16gb-6000mhz.jpg',67);
INSERT INTO `producto_imagenes` VALUES (144,0,'http://localhost:8080/images/adata-xpg-lancer-blade-ddr5-32gb-2x16gb-6000mhz.jpg',67);
INSERT INTO `producto_imagenes` VALUES (145,2,'http://localhost:8080/images/crucial-pro-ddr5-64gb-2x32gb-5600mhz.jpg',68);
INSERT INTO `producto_imagenes` VALUES (146,1,'http://localhost:8080/images/crucial-pro-ddr5-64gb-2x32gb-5600mhz.jpg',68);
INSERT INTO `producto_imagenes` VALUES (147,0,'http://localhost:8080/images/crucial-pro-ddr5-64gb-2x32gb-5600mhz.jpg',68);
INSERT INTO `producto_imagenes` VALUES (148,2,'http://localhost:8080/images/kingston-fury-beast-ddr4-16gb-2x8gb-3200mhz.jpg',69);
INSERT INTO `producto_imagenes` VALUES (149,1,'http://localhost:8080/images/kingston-fury-beast-ddr4-16gb-2x8gb-3200mhz.jpg',69);
INSERT INTO `producto_imagenes` VALUES (150,0,'http://localhost:8080/images/kingston-fury-beast-ddr4-16gb-2x8gb-3200mhz.jpg',69);
INSERT INTO `producto_imagenes` VALUES (151,2,'http://localhost:8080/images/kingston-fury-beast-ddr4-32gb-2x16gb-3600mhz.jpg',70);
INSERT INTO `producto_imagenes` VALUES (152,1,'http://localhost:8080/images/kingston-fury-beast-ddr4-32gb-2x16gb-3600mhz.jpg',70);
INSERT INTO `producto_imagenes` VALUES (153,0,'http://localhost:8080/images/kingston-fury-beast-ddr4-32gb-2x16gb-3600mhz.jpg',70);
INSERT INTO `producto_imagenes` VALUES (154,2,'http://localhost:8080/images/corsair-vengeance-lpx-ddr4-16gb-2x8gb-3200mhz.jpg',71);
INSERT INTO `producto_imagenes` VALUES (155,1,'http://localhost:8080/images/corsair-vengeance-lpx-ddr4-16gb-2x8gb-3200mhz.jpg',71);
INSERT INTO `producto_imagenes` VALUES (156,0,'http://localhost:8080/images/corsair-vengeance-lpx-ddr4-16gb-2x8gb-3200mhz.jpg',71);
INSERT INTO `producto_imagenes` VALUES (157,2,'http://localhost:8080/images/corsair-vengeance-rgb-pro-ddr4-32gb-2x16gb-3600mhz.jpg',72);
INSERT INTO `producto_imagenes` VALUES (158,1,'http://localhost:8080/images/corsair-vengeance-rgb-pro-ddr4-32gb-2x16gb-3600mhz.jpg',72);
INSERT INTO `producto_imagenes` VALUES (159,0,'http://localhost:8080/images/corsair-vengeance-rgb-pro-ddr4-32gb-2x16gb-3600mhz.jpg',72);
INSERT INTO `producto_imagenes` VALUES (160,2,'http://localhost:8080/images/g-skill-ripjaws-v-ddr4-32gb-2x16gb-3200mhz.jpg',73);
INSERT INTO `producto_imagenes` VALUES (161,1,'http://localhost:8080/images/g-skill-ripjaws-v-ddr4-32gb-2x16gb-3200mhz.jpg',73);
INSERT INTO `producto_imagenes` VALUES (162,0,'http://localhost:8080/images/g-skill-ripjaws-v-ddr4-32gb-2x16gb-3200mhz.jpg',73);
INSERT INTO `producto_imagenes` VALUES (163,2,'http://localhost:8080/images/patriot-viper-steel-ddr4-16gb-3200mhz.jpg',74);
INSERT INTO `producto_imagenes` VALUES (164,1,'http://localhost:8080/images/patriot-viper-steel-ddr4-16gb-3200mhz.jpg',74);
INSERT INTO `producto_imagenes` VALUES (165,0,'http://localhost:8080/images/patriot-viper-steel-ddr4-16gb-3200mhz.jpg',74);
INSERT INTO `producto_imagenes` VALUES (166,2,'http://localhost:8080/images/kingston-valueram-ddr4-8gb-2666mhz.jpg',75);
INSERT INTO `producto_imagenes` VALUES (167,1,'http://localhost:8080/images/kingston-valueram-ddr4-8gb-2666mhz.jpg',75);
INSERT INTO `producto_imagenes` VALUES (168,0,'http://localhost:8080/images/kingston-valueram-ddr4-8gb-2666mhz.jpg',75);
INSERT INTO `producto_imagenes` VALUES (169,2,'http://localhost:8080/images/kingston-fury-impact-sodimm-ddr5-16gb-5600mhz.jpg',76);
INSERT INTO `producto_imagenes` VALUES (170,1,'http://localhost:8080/images/kingston-fury-impact-sodimm-ddr5-16gb-5600mhz.jpg',76);
INSERT INTO `producto_imagenes` VALUES (171,0,'http://localhost:8080/images/kingston-fury-impact-sodimm-ddr5-16gb-5600mhz.jpg',76);
INSERT INTO `producto_imagenes` VALUES (172,2,'http://localhost:8080/images/crucial-sodimm-ddr4-16gb-3200mhz.jpg',77);
INSERT INTO `producto_imagenes` VALUES (173,1,'http://localhost:8080/images/crucial-sodimm-ddr4-16gb-3200mhz.jpg',77);
INSERT INTO `producto_imagenes` VALUES (174,0,'http://localhost:8080/images/crucial-sodimm-ddr4-16gb-3200mhz.jpg',77);
INSERT INTO `producto_imagenes` VALUES (175,2,'http://localhost:8080/images/samsung-sodimm-ddr4-8gb-3200mhz.jpg',78);
INSERT INTO `producto_imagenes` VALUES (176,1,'http://localhost:8080/images/samsung-sodimm-ddr4-8gb-3200mhz.jpg',78);
INSERT INTO `producto_imagenes` VALUES (177,0,'http://localhost:8080/images/samsung-sodimm-ddr4-8gb-3200mhz.jpg',78);
INSERT INTO `producto_imagenes` VALUES (178,2,'http://localhost:8080/images/crucial-sodimm-ddr5-32gb-5600mhz.jpg',79);
INSERT INTO `producto_imagenes` VALUES (179,1,'http://localhost:8080/images/crucial-sodimm-ddr5-32gb-5600mhz.jpg',79);
INSERT INTO `producto_imagenes` VALUES (180,0,'http://localhost:8080/images/crucial-sodimm-ddr5-32gb-5600mhz.jpg',79);
INSERT INTO `producto_imagenes` VALUES (181,2,'http://localhost:8080/images/samsung-990-pro-ssd-nvme-2tb.jpg',80);
INSERT INTO `producto_imagenes` VALUES (182,1,'http://localhost:8080/images/samsung-990-pro-ssd-nvme-2tb.jpg',80);
INSERT INTO `producto_imagenes` VALUES (183,0,'http://localhost:8080/images/samsung-990-pro-ssd-nvme-2tb.jpg',80);
INSERT INTO `producto_imagenes` VALUES (184,2,'http://localhost:8080/images/samsung-990-pro-ssd-nvme-1tb-con-disipador.jpg',81);
INSERT INTO `producto_imagenes` VALUES (185,1,'http://localhost:8080/images/samsung-990-pro-ssd-nvme-1tb-con-disipador.jpg',81);
INSERT INTO `producto_imagenes` VALUES (186,0,'http://localhost:8080/images/samsung-990-pro-ssd-nvme-1tb-con-disipador.jpg',81);
INSERT INTO `producto_imagenes` VALUES (187,2,'http://localhost:8080/images/samsung-9100-pro-ssd-nvme-2tb.jpg',82);
INSERT INTO `producto_imagenes` VALUES (188,1,'http://localhost:8080/images/samsung-9100-pro-ssd-nvme-2tb.jpg',82);
INSERT INTO `producto_imagenes` VALUES (189,0,'http://localhost:8080/images/samsung-9100-pro-ssd-nvme-2tb.jpg',82);
INSERT INTO `producto_imagenes` VALUES (190,2,'http://localhost:8080/images/samsung-870-evo-ssd-sata-1tb.jpg',83);
INSERT INTO `producto_imagenes` VALUES (191,1,'http://localhost:8080/images/samsung-870-evo-ssd-sata-1tb.jpg',83);
INSERT INTO `producto_imagenes` VALUES (192,0,'http://localhost:8080/images/samsung-870-evo-ssd-sata-1tb.jpg',83);
INSERT INTO `producto_imagenes` VALUES (193,2,'http://localhost:8080/images/wd-black-sn850x-ssd-nvme-2tb.jpg',84);
INSERT INTO `producto_imagenes` VALUES (194,1,'http://localhost:8080/images/wd-black-sn850x-ssd-nvme-2tb.jpg',84);
INSERT INTO `producto_imagenes` VALUES (195,0,'http://localhost:8080/images/wd-black-sn850x-ssd-nvme-2tb.jpg',84);
INSERT INTO `producto_imagenes` VALUES (196,2,'http://localhost:8080/images/wd-black-sn7100-ssd-nvme-1tb.jpg',85);
INSERT INTO `producto_imagenes` VALUES (197,1,'http://localhost:8080/images/wd-black-sn7100-ssd-nvme-1tb.jpg',85);
INSERT INTO `producto_imagenes` VALUES (198,0,'http://localhost:8080/images/wd-black-sn7100-ssd-nvme-1tb.jpg',85);
INSERT INTO `producto_imagenes` VALUES (199,2,'http://localhost:8080/images/wd-blue-sn5000-ssd-nvme-1tb.jpg',86);
INSERT INTO `producto_imagenes` VALUES (200,1,'http://localhost:8080/images/wd-blue-sn5000-ssd-nvme-1tb.jpg',86);
INSERT INTO `producto_imagenes` VALUES (201,0,'http://localhost:8080/images/wd-blue-sn5000-ssd-nvme-1tb.jpg',86);
INSERT INTO `producto_imagenes` VALUES (202,2,'http://localhost:8080/images/kingston-nv3-ssd-nvme-1tb.jpg',87);
INSERT INTO `producto_imagenes` VALUES (203,1,'http://localhost:8080/images/kingston-nv3-ssd-nvme-1tb.jpg',87);
INSERT INTO `producto_imagenes` VALUES (204,0,'http://localhost:8080/images/kingston-nv3-ssd-nvme-1tb.jpg',87);
INSERT INTO `producto_imagenes` VALUES (205,2,'http://localhost:8080/images/kingston-nv3-ssd-nvme-2tb.jpg',88);
INSERT INTO `producto_imagenes` VALUES (206,1,'http://localhost:8080/images/kingston-nv3-ssd-nvme-2tb.jpg',88);
INSERT INTO `producto_imagenes` VALUES (207,0,'http://localhost:8080/images/kingston-nv3-ssd-nvme-2tb.jpg',88);
INSERT INTO `producto_imagenes` VALUES (208,2,'http://localhost:8080/images/kingston-a400-ssd-sata-480gb.jpg',89);
INSERT INTO `producto_imagenes` VALUES (209,1,'http://localhost:8080/images/kingston-a400-ssd-sata-480gb.jpg',89);
INSERT INTO `producto_imagenes` VALUES (210,0,'http://localhost:8080/images/kingston-a400-ssd-sata-480gb.jpg',89);
INSERT INTO `producto_imagenes` VALUES (211,2,'http://localhost:8080/images/kingston-kc3000-ssd-nvme-2tb.jpg',90);
INSERT INTO `producto_imagenes` VALUES (212,1,'http://localhost:8080/images/kingston-kc3000-ssd-nvme-2tb.jpg',90);
INSERT INTO `producto_imagenes` VALUES (213,0,'http://localhost:8080/images/kingston-kc3000-ssd-nvme-2tb.jpg',90);
INSERT INTO `producto_imagenes` VALUES (214,2,'http://localhost:8080/images/crucial-t705-ssd-nvme-2tb.jpg',91);
INSERT INTO `producto_imagenes` VALUES (215,1,'http://localhost:8080/images/crucial-t705-ssd-nvme-2tb.jpg',91);
INSERT INTO `producto_imagenes` VALUES (216,0,'http://localhost:8080/images/crucial-t705-ssd-nvme-2tb.jpg',91);
INSERT INTO `producto_imagenes` VALUES (217,2,'http://localhost:8080/images/crucial-p3-plus-ssd-nvme-1tb.jpg',92);
INSERT INTO `producto_imagenes` VALUES (218,1,'http://localhost:8080/images/crucial-p3-plus-ssd-nvme-1tb.jpg',92);
INSERT INTO `producto_imagenes` VALUES (219,0,'http://localhost:8080/images/crucial-p3-plus-ssd-nvme-1tb.jpg',92);
INSERT INTO `producto_imagenes` VALUES (220,2,'http://localhost:8080/images/crucial-bx500-ssd-sata-1tb.jpg',93);
INSERT INTO `producto_imagenes` VALUES (221,1,'http://localhost:8080/images/crucial-bx500-ssd-sata-1tb.jpg',93);
INSERT INTO `producto_imagenes` VALUES (222,0,'http://localhost:8080/images/crucial-bx500-ssd-sata-1tb.jpg',93);
INSERT INTO `producto_imagenes` VALUES (223,2,'http://localhost:8080/images/adata-legend-860-ssd-nvme-1tb.jpg',94);
INSERT INTO `producto_imagenes` VALUES (224,1,'http://localhost:8080/images/adata-legend-860-ssd-nvme-1tb.jpg',94);
INSERT INTO `producto_imagenes` VALUES (225,0,'http://localhost:8080/images/adata-legend-860-ssd-nvme-1tb.jpg',94);
INSERT INTO `producto_imagenes` VALUES (226,2,'http://localhost:8080/images/seagate-barracuda-hdd-2tb-7200rpm.jpg',95);
INSERT INTO `producto_imagenes` VALUES (227,1,'http://localhost:8080/images/seagate-barracuda-hdd-2tb-7200rpm.jpg',95);
INSERT INTO `producto_imagenes` VALUES (228,0,'http://localhost:8080/images/seagate-barracuda-hdd-2tb-7200rpm.jpg',95);
INSERT INTO `producto_imagenes` VALUES (229,2,'http://localhost:8080/images/seagate-ironwolf-hdd-4tb-nas.jpg',96);
INSERT INTO `producto_imagenes` VALUES (230,1,'http://localhost:8080/images/seagate-ironwolf-hdd-4tb-nas.jpg',96);
INSERT INTO `producto_imagenes` VALUES (231,0,'http://localhost:8080/images/seagate-ironwolf-hdd-4tb-nas.jpg',96);
INSERT INTO `producto_imagenes` VALUES (232,2,'http://localhost:8080/images/wd-blue-hdd-1tb-7200rpm.jpg',97);
INSERT INTO `producto_imagenes` VALUES (233,1,'http://localhost:8080/images/wd-blue-hdd-1tb-7200rpm.jpg',97);
INSERT INTO `producto_imagenes` VALUES (234,0,'http://localhost:8080/images/wd-blue-hdd-1tb-7200rpm.jpg',97);
INSERT INTO `producto_imagenes` VALUES (235,2,'http://localhost:8080/images/wd-red-plus-hdd-8tb-nas.jpg',98);
INSERT INTO `producto_imagenes` VALUES (236,1,'http://localhost:8080/images/wd-red-plus-hdd-8tb-nas.jpg',98);
INSERT INTO `producto_imagenes` VALUES (237,0,'http://localhost:8080/images/wd-red-plus-hdd-8tb-nas.jpg',98);
INSERT INTO `producto_imagenes` VALUES (238,2,'http://localhost:8080/images/samsung-t7-ssd-externo-1tb.jpg',99);
INSERT INTO `producto_imagenes` VALUES (239,1,'http://localhost:8080/images/samsung-t7-ssd-externo-1tb.jpg',99);
INSERT INTO `producto_imagenes` VALUES (240,0,'http://localhost:8080/images/samsung-t7-ssd-externo-1tb.jpg',99);
INSERT INTO `producto_imagenes` VALUES (241,2,'http://localhost:8080/images/sandisk-extreme-portable-ssd-2tb.jpg',100);
INSERT INTO `producto_imagenes` VALUES (242,1,'http://localhost:8080/images/sandisk-extreme-portable-ssd-2tb.jpg',100);
INSERT INTO `producto_imagenes` VALUES (243,0,'http://localhost:8080/images/sandisk-extreme-portable-ssd-2tb.jpg',100);
INSERT INTO `producto_imagenes` VALUES (244,2,'http://localhost:8080/images/wd-my-passport-hdd-externo-2tb.jpg',101);
INSERT INTO `producto_imagenes` VALUES (245,1,'http://localhost:8080/images/wd-my-passport-hdd-externo-2tb.jpg',101);
INSERT INTO `producto_imagenes` VALUES (246,0,'http://localhost:8080/images/wd-my-passport-hdd-externo-2tb.jpg',101);
INSERT INTO `producto_imagenes` VALUES (247,2,'http://localhost:8080/images/seagate-expansion-hdd-externo-4tb.jpg',102);
INSERT INTO `producto_imagenes` VALUES (248,1,'http://localhost:8080/images/seagate-expansion-hdd-externo-4tb.jpg',102);
INSERT INTO `producto_imagenes` VALUES (249,0,'http://localhost:8080/images/seagate-expansion-hdd-externo-4tb.jpg',102);
INSERT INTO `producto_imagenes` VALUES (250,2,'http://localhost:8080/images/sandisk-ultra-fit-pendrive-128gb.jpg',103);
INSERT INTO `producto_imagenes` VALUES (251,1,'http://localhost:8080/images/sandisk-ultra-fit-pendrive-128gb.jpg',103);
INSERT INTO `producto_imagenes` VALUES (252,0,'http://localhost:8080/images/sandisk-ultra-fit-pendrive-128gb.jpg',103);
INSERT INTO `producto_imagenes` VALUES (253,2,'http://localhost:8080/images/kingston-canvas-select-plus-microsd-256gb.jpg',104);
INSERT INTO `producto_imagenes` VALUES (254,1,'http://localhost:8080/images/kingston-canvas-select-plus-microsd-256gb.jpg',104);
INSERT INTO `producto_imagenes` VALUES (255,0,'http://localhost:8080/images/kingston-canvas-select-plus-microsd-256gb.jpg',104);
INSERT INTO `producto_imagenes` VALUES (256,2,'http://localhost:8080/images/logitech-g-pro-x-superlight-2-mouse-inalambrico.jpg',105);
INSERT INTO `producto_imagenes` VALUES (257,1,'http://localhost:8080/images/logitech-g-pro-x-superlight-2-mouse-inalambrico.jpg',105);
INSERT INTO `producto_imagenes` VALUES (258,0,'http://localhost:8080/images/logitech-g-pro-x-superlight-2-mouse-inalambrico.jpg',105);
INSERT INTO `producto_imagenes` VALUES (259,2,'http://localhost:8080/images/logitech-g502-x-plus-mouse-inalambrico.jpg',106);
INSERT INTO `producto_imagenes` VALUES (260,1,'http://localhost:8080/images/logitech-g502-x-plus-mouse-inalambrico.jpg',106);
INSERT INTO `producto_imagenes` VALUES (261,0,'http://localhost:8080/images/logitech-g502-x-plus-mouse-inalambrico.jpg',106);
INSERT INTO `producto_imagenes` VALUES (262,2,'http://localhost:8080/images/logitech-g203-lightsync-mouse-gamer.jpg',107);
INSERT INTO `producto_imagenes` VALUES (263,1,'http://localhost:8080/images/logitech-g203-lightsync-mouse-gamer.jpg',107);
INSERT INTO `producto_imagenes` VALUES (264,0,'http://localhost:8080/images/logitech-g203-lightsync-mouse-gamer.jpg',107);
INSERT INTO `producto_imagenes` VALUES (265,2,'http://localhost:8080/images/logitech-mx-master-3s-mouse-inalambrico.jpg',108);
INSERT INTO `producto_imagenes` VALUES (266,1,'http://localhost:8080/images/logitech-mx-master-3s-mouse-inalambrico.jpg',108);
INSERT INTO `producto_imagenes` VALUES (267,0,'http://localhost:8080/images/logitech-mx-master-3s-mouse-inalambrico.jpg',108);
INSERT INTO `producto_imagenes` VALUES (268,2,'http://localhost:8080/images/razer-deathadder-v3-mouse-gamer.jpg',109);
INSERT INTO `producto_imagenes` VALUES (269,1,'http://localhost:8080/images/razer-deathadder-v3-mouse-gamer.jpg',109);
INSERT INTO `producto_imagenes` VALUES (270,0,'http://localhost:8080/images/razer-deathadder-v3-mouse-gamer.jpg',109);
INSERT INTO `producto_imagenes` VALUES (271,2,'http://localhost:8080/images/razer-viper-v3-pro-mouse-inalambrico.jpg',110);
INSERT INTO `producto_imagenes` VALUES (272,1,'http://localhost:8080/images/razer-viper-v3-pro-mouse-inalambrico.jpg',110);
INSERT INTO `producto_imagenes` VALUES (273,0,'http://localhost:8080/images/razer-viper-v3-pro-mouse-inalambrico.jpg',110);
INSERT INTO `producto_imagenes` VALUES (274,2,'http://localhost:8080/images/hyperx-pulsefire-haste-2-mouse-gamer.jpg',111);
INSERT INTO `producto_imagenes` VALUES (275,1,'http://localhost:8080/images/hyperx-pulsefire-haste-2-mouse-gamer.jpg',111);
INSERT INTO `producto_imagenes` VALUES (276,0,'http://localhost:8080/images/hyperx-pulsefire-haste-2-mouse-gamer.jpg',111);
INSERT INTO `producto_imagenes` VALUES (277,2,'http://localhost:8080/images/redragon-cobra-m711-mouse-gamer.jpg',112);
INSERT INTO `producto_imagenes` VALUES (278,1,'http://localhost:8080/images/redragon-cobra-m711-mouse-gamer.jpg',112);
INSERT INTO `producto_imagenes` VALUES (279,0,'http://localhost:8080/images/redragon-cobra-m711-mouse-gamer.jpg',112);
INSERT INTO `producto_imagenes` VALUES (280,2,'http://localhost:8080/images/logitech-g-pro-x-tkl-teclado-mecanico-inalambrico.jpg',113);
INSERT INTO `producto_imagenes` VALUES (281,1,'http://localhost:8080/images/logitech-g-pro-x-tkl-teclado-mecanico-inalambrico.jpg',113);
INSERT INTO `producto_imagenes` VALUES (282,0,'http://localhost:8080/images/logitech-g-pro-x-tkl-teclado-mecanico-inalambrico.jpg',113);
INSERT INTO `producto_imagenes` VALUES (283,2,'http://localhost:8080/images/logitech-g413-se-teclado-mecanico.jpg',114);
INSERT INTO `producto_imagenes` VALUES (284,1,'http://localhost:8080/images/logitech-g413-se-teclado-mecanico.jpg',114);
INSERT INTO `producto_imagenes` VALUES (285,0,'http://localhost:8080/images/logitech-g413-se-teclado-mecanico.jpg',114);
INSERT INTO `producto_imagenes` VALUES (286,2,'http://localhost:8080/images/razer-blackwidow-v4-teclado-mecanico.jpg',115);
INSERT INTO `producto_imagenes` VALUES (287,1,'http://localhost:8080/images/razer-blackwidow-v4-teclado-mecanico.jpg',115);
INSERT INTO `producto_imagenes` VALUES (288,0,'http://localhost:8080/images/razer-blackwidow-v4-teclado-mecanico.jpg',115);
INSERT INTO `producto_imagenes` VALUES (289,2,'http://localhost:8080/images/hyperx-alloy-origins-core-teclado-mecanico.jpg',116);
INSERT INTO `producto_imagenes` VALUES (290,1,'http://localhost:8080/images/hyperx-alloy-origins-core-teclado-mecanico.jpg',116);
INSERT INTO `producto_imagenes` VALUES (291,0,'http://localhost:8080/images/hyperx-alloy-origins-core-teclado-mecanico.jpg',116);
INSERT INTO `producto_imagenes` VALUES (292,2,'http://localhost:8080/images/redragon-kumara-k552-rgb-teclado-mecanico.jpg',117);
INSERT INTO `producto_imagenes` VALUES (293,1,'http://localhost:8080/images/redragon-kumara-k552-rgb-teclado-mecanico.jpg',117);
INSERT INTO `producto_imagenes` VALUES (294,0,'http://localhost:8080/images/redragon-kumara-k552-rgb-teclado-mecanico.jpg',117);
INSERT INTO `producto_imagenes` VALUES (295,2,'http://localhost:8080/images/keychron-k2-pro-teclado-mecanico-inalambrico.jpg',118);
INSERT INTO `producto_imagenes` VALUES (296,1,'http://localhost:8080/images/keychron-k2-pro-teclado-mecanico-inalambrico.jpg',118);
INSERT INTO `producto_imagenes` VALUES (297,0,'http://localhost:8080/images/keychron-k2-pro-teclado-mecanico-inalambrico.jpg',118);
INSERT INTO `producto_imagenes` VALUES (298,2,'http://localhost:8080/images/logitech-mx-keys-s-teclado-inalambrico.jpg',119);
INSERT INTO `producto_imagenes` VALUES (299,1,'http://localhost:8080/images/logitech-mx-keys-s-teclado-inalambrico.jpg',119);
INSERT INTO `producto_imagenes` VALUES (300,0,'http://localhost:8080/images/logitech-mx-keys-s-teclado-inalambrico.jpg',119);
INSERT INTO `producto_imagenes` VALUES (301,2,'http://localhost:8080/images/hyperx-cloud-iii-auriculares-gamer.jpg',120);
INSERT INTO `producto_imagenes` VALUES (302,1,'http://localhost:8080/images/hyperx-cloud-iii-auriculares-gamer.jpg',120);
INSERT INTO `producto_imagenes` VALUES (303,0,'http://localhost:8080/images/hyperx-cloud-iii-auriculares-gamer.jpg',120);
INSERT INTO `producto_imagenes` VALUES (304,2,'http://localhost:8080/images/hyperx-cloud-alpha-wireless-auriculares-gamer.jpg',121);
INSERT INTO `producto_imagenes` VALUES (305,1,'http://localhost:8080/images/hyperx-cloud-alpha-wireless-auriculares-gamer.jpg',121);
INSERT INTO `producto_imagenes` VALUES (306,0,'http://localhost:8080/images/hyperx-cloud-alpha-wireless-auriculares-gamer.jpg',121);
INSERT INTO `producto_imagenes` VALUES (307,2,'http://localhost:8080/images/logitech-g733-lightspeed-auriculares-inalambricos.jpg',122);
INSERT INTO `producto_imagenes` VALUES (308,1,'http://localhost:8080/images/logitech-g733-lightspeed-auriculares-inalambricos.jpg',122);
INSERT INTO `producto_imagenes` VALUES (309,0,'http://localhost:8080/images/logitech-g733-lightspeed-auriculares-inalambricos.jpg',122);
INSERT INTO `producto_imagenes` VALUES (310,2,'http://localhost:8080/images/razer-blackshark-v2-x-auriculares-gamer.jpg',123);
INSERT INTO `producto_imagenes` VALUES (311,1,'http://localhost:8080/images/razer-blackshark-v2-x-auriculares-gamer.jpg',123);
INSERT INTO `producto_imagenes` VALUES (312,0,'http://localhost:8080/images/razer-blackshark-v2-x-auriculares-gamer.jpg',123);
INSERT INTO `producto_imagenes` VALUES (313,2,'http://localhost:8080/images/sony-wh-1000xm5-auriculares-bluetooth.jpg',124);
INSERT INTO `producto_imagenes` VALUES (314,1,'http://localhost:8080/images/sony-wh-1000xm5-auriculares-bluetooth.jpg',124);
INSERT INTO `producto_imagenes` VALUES (315,0,'http://localhost:8080/images/sony-wh-1000xm5-auriculares-bluetooth.jpg',124);
INSERT INTO `producto_imagenes` VALUES (316,2,'http://localhost:8080/images/jbl-tune-520bt-auriculares-bluetooth.jpg',125);
INSERT INTO `producto_imagenes` VALUES (317,1,'http://localhost:8080/images/jbl-tune-520bt-auriculares-bluetooth.jpg',125);
INSERT INTO `producto_imagenes` VALUES (318,0,'http://localhost:8080/images/jbl-tune-520bt-auriculares-bluetooth.jpg',125);
INSERT INTO `producto_imagenes` VALUES (319,2,'http://localhost:8080/images/logitech-c920s-pro-webcam-full-hd.jpg',126);
INSERT INTO `producto_imagenes` VALUES (320,1,'http://localhost:8080/images/logitech-c920s-pro-webcam-full-hd.jpg',126);
INSERT INTO `producto_imagenes` VALUES (321,0,'http://localhost:8080/images/logitech-c920s-pro-webcam-full-hd.jpg',126);
INSERT INTO `producto_imagenes` VALUES (322,2,'http://localhost:8080/images/logitech-brio-4k-webcam.jpg',127);
INSERT INTO `producto_imagenes` VALUES (323,1,'http://localhost:8080/images/logitech-brio-4k-webcam.jpg',127);
INSERT INTO `producto_imagenes` VALUES (324,0,'http://localhost:8080/images/logitech-brio-4k-webcam.jpg',127);
INSERT INTO `producto_imagenes` VALUES (325,2,'http://localhost:8080/images/razer-kiyo-pro-webcam.jpg',128);
INSERT INTO `producto_imagenes` VALUES (326,1,'http://localhost:8080/images/razer-kiyo-pro-webcam.jpg',128);
INSERT INTO `producto_imagenes` VALUES (327,0,'http://localhost:8080/images/razer-kiyo-pro-webcam.jpg',128);
INSERT INTO `producto_imagenes` VALUES (328,2,'http://localhost:8080/images/hyperx-quadcast-s-microfono-usb.jpg',129);
INSERT INTO `producto_imagenes` VALUES (329,1,'http://localhost:8080/images/hyperx-quadcast-s-microfono-usb.jpg',129);
INSERT INTO `producto_imagenes` VALUES (330,0,'http://localhost:8080/images/hyperx-quadcast-s-microfono-usb.jpg',129);
INSERT INTO `producto_imagenes` VALUES (331,2,'http://localhost:8080/images/fifine-k669b-microfono-usb.jpg',130);
INSERT INTO `producto_imagenes` VALUES (332,1,'http://localhost:8080/images/fifine-k669b-microfono-usb.jpg',130);
INSERT INTO `producto_imagenes` VALUES (333,0,'http://localhost:8080/images/fifine-k669b-microfono-usb.jpg',130);
INSERT INTO `producto_imagenes` VALUES (334,2,'http://localhost:8080/images/logitech-g240-mousepad-gamer.jpg',131);
INSERT INTO `producto_imagenes` VALUES (335,1,'http://localhost:8080/images/logitech-g240-mousepad-gamer.jpg',131);
INSERT INTO `producto_imagenes` VALUES (336,0,'http://localhost:8080/images/logitech-g240-mousepad-gamer.jpg',131);
INSERT INTO `producto_imagenes` VALUES (337,2,'http://localhost:8080/images/logitech-z313-parlantes-2-1.jpg',133);
INSERT INTO `producto_imagenes` VALUES (338,1,'http://localhost:8080/images/logitech-z313-parlantes-2-1.jpg',133);
INSERT INTO `producto_imagenes` VALUES (339,0,'http://localhost:8080/images/logitech-z313-parlantes-2-1.jpg',133);
INSERT INTO `producto_imagenes` VALUES (340,2,'http://localhost:8080/images/xbox-wireless-controller-joystick.jpg',134);
INSERT INTO `producto_imagenes` VALUES (341,1,'http://localhost:8080/images/xbox-wireless-controller-joystick.jpg',134);
INSERT INTO `producto_imagenes` VALUES (342,0,'http://localhost:8080/images/xbox-wireless-controller-joystick.jpg',134);
INSERT INTO `producto_imagenes` VALUES (343,2,'http://localhost:8080/images/sony-dualsense-joystick-ps5.jpg',135);
INSERT INTO `producto_imagenes` VALUES (344,1,'http://localhost:8080/images/sony-dualsense-joystick-ps5.jpg',135);
INSERT INTO `producto_imagenes` VALUES (345,0,'http://localhost:8080/images/sony-dualsense-joystick-ps5.jpg',135);
INSERT INTO `producto_imagenes` VALUES (346,2,'http://localhost:8080/images/tp-link-archer-t3u-plus-adaptador-wifi-usb.jpg',136);
INSERT INTO `producto_imagenes` VALUES (347,1,'http://localhost:8080/images/tp-link-archer-t3u-plus-adaptador-wifi-usb.jpg',136);
INSERT INTO `producto_imagenes` VALUES (348,0,'http://localhost:8080/images/tp-link-archer-t3u-plus-adaptador-wifi-usb.jpg',136);
INSERT INTO `producto_imagenes` VALUES (349,2,'http://localhost:8080/images/samsung-odyssey-g5-27-qhd-165hz.jpg',138);
INSERT INTO `producto_imagenes` VALUES (350,1,'http://localhost:8080/images/samsung-odyssey-g5-27-qhd-165hz.jpg',138);
INSERT INTO `producto_imagenes` VALUES (351,0,'http://localhost:8080/images/samsung-odyssey-g5-27-qhd-165hz.jpg',138);
INSERT INTO `producto_imagenes` VALUES (352,2,'http://localhost:8080/images/samsung-odyssey-g7-32-4k-144hz.jpg',139);
INSERT INTO `producto_imagenes` VALUES (353,1,'http://localhost:8080/images/samsung-odyssey-g7-32-4k-144hz.jpg',139);
INSERT INTO `producto_imagenes` VALUES (354,0,'http://localhost:8080/images/samsung-odyssey-g7-32-4k-144hz.jpg',139);
INSERT INTO `producto_imagenes` VALUES (355,2,'http://localhost:8080/images/samsung-odyssey-oled-g6-27-qhd-360hz.jpg',140);
INSERT INTO `producto_imagenes` VALUES (356,1,'http://localhost:8080/images/samsung-odyssey-oled-g6-27-qhd-360hz.jpg',140);
INSERT INTO `producto_imagenes` VALUES (357,0,'http://localhost:8080/images/samsung-odyssey-oled-g6-27-qhd-360hz.jpg',140);
INSERT INTO `producto_imagenes` VALUES (358,2,'http://localhost:8080/images/samsung-viewfinity-s6-27-qhd.jpg',141);
INSERT INTO `producto_imagenes` VALUES (359,1,'http://localhost:8080/images/samsung-viewfinity-s6-27-qhd.jpg',141);
INSERT INTO `producto_imagenes` VALUES (360,0,'http://localhost:8080/images/samsung-viewfinity-s6-27-qhd.jpg',141);
INSERT INTO `producto_imagenes` VALUES (361,2,'http://localhost:8080/images/samsung-essential-s3-24-full-hd.jpg',142);
INSERT INTO `producto_imagenes` VALUES (362,1,'http://localhost:8080/images/samsung-essential-s3-24-full-hd.jpg',142);
INSERT INTO `producto_imagenes` VALUES (363,0,'http://localhost:8080/images/samsung-essential-s3-24-full-hd.jpg',142);
INSERT INTO `producto_imagenes` VALUES (364,2,'http://localhost:8080/images/lg-ultragear-27gr75q-27-qhd-165hz.jpg',143);
INSERT INTO `producto_imagenes` VALUES (365,1,'http://localhost:8080/images/lg-ultragear-27gr75q-27-qhd-165hz.jpg',143);
INSERT INTO `producto_imagenes` VALUES (366,0,'http://localhost:8080/images/lg-ultragear-27gr75q-27-qhd-165hz.jpg',143);
INSERT INTO `producto_imagenes` VALUES (367,2,'http://localhost:8080/images/lg-ultragear-oled-27gs95qe-27-qhd-240hz.jpg',145);
INSERT INTO `producto_imagenes` VALUES (368,1,'http://localhost:8080/images/lg-ultragear-oled-27gs95qe-27-qhd-240hz.jpg',145);
INSERT INTO `producto_imagenes` VALUES (369,0,'http://localhost:8080/images/lg-ultragear-oled-27gs95qe-27-qhd-240hz.jpg',145);
INSERT INTO `producto_imagenes` VALUES (370,2,'http://localhost:8080/images/lg-ultrawide-34wq60c-34-wqhd.jpg',146);
INSERT INTO `producto_imagenes` VALUES (371,1,'http://localhost:8080/images/lg-ultrawide-34wq60c-34-wqhd.jpg',146);
INSERT INTO `producto_imagenes` VALUES (372,0,'http://localhost:8080/images/lg-ultrawide-34wq60c-34-wqhd.jpg',146);
INSERT INTO `producto_imagenes` VALUES (373,2,'http://localhost:8080/images/lg-27up850n-27-4k.jpg',147);
INSERT INTO `producto_imagenes` VALUES (374,1,'http://localhost:8080/images/lg-27up850n-27-4k.jpg',147);
INSERT INTO `producto_imagenes` VALUES (375,0,'http://localhost:8080/images/lg-27up850n-27-4k.jpg',147);
INSERT INTO `producto_imagenes` VALUES (376,2,'http://localhost:8080/images/asus-tuf-gaming-vg27aq3a-27-qhd-180hz.jpg',149);
INSERT INTO `producto_imagenes` VALUES (377,1,'http://localhost:8080/images/asus-tuf-gaming-vg27aq3a-27-qhd-180hz.jpg',149);
INSERT INTO `producto_imagenes` VALUES (378,0,'http://localhost:8080/images/asus-tuf-gaming-vg27aq3a-27-qhd-180hz.jpg',149);
INSERT INTO `producto_imagenes` VALUES (379,2,'http://localhost:8080/images/asus-rog-swift-pg27aqdm-27-oled-240hz.jpg',150);
INSERT INTO `producto_imagenes` VALUES (380,1,'http://localhost:8080/images/asus-rog-swift-pg27aqdm-27-oled-240hz.jpg',150);
INSERT INTO `producto_imagenes` VALUES (381,0,'http://localhost:8080/images/asus-rog-swift-pg27aqdm-27-oled-240hz.jpg',150);
INSERT INTO `producto_imagenes` VALUES (382,2,'http://localhost:8080/images/asus-va24ehf-24-full-hd-100hz.jpg',151);
INSERT INTO `producto_imagenes` VALUES (383,1,'http://localhost:8080/images/asus-va24ehf-24-full-hd-100hz.jpg',151);
INSERT INTO `producto_imagenes` VALUES (384,0,'http://localhost:8080/images/asus-va24ehf-24-full-hd-100hz.jpg',151);
INSERT INTO `producto_imagenes` VALUES (385,2,'http://localhost:8080/images/asus-proart-pa278cv-27-qhd.jpg',152);
INSERT INTO `producto_imagenes` VALUES (386,1,'http://localhost:8080/images/asus-proart-pa278cv-27-qhd.jpg',152);
INSERT INTO `producto_imagenes` VALUES (387,0,'http://localhost:8080/images/asus-proart-pa278cv-27-qhd.jpg',152);
INSERT INTO `producto_imagenes` VALUES (388,2,'http://localhost:8080/images/msi-g2412-24-full-hd-170hz.jpg',153);
INSERT INTO `producto_imagenes` VALUES (389,1,'http://localhost:8080/images/msi-g2412-24-full-hd-170hz.jpg',153);
INSERT INTO `producto_imagenes` VALUES (390,0,'http://localhost:8080/images/msi-g2412-24-full-hd-170hz.jpg',153);
INSERT INTO `producto_imagenes` VALUES (391,2,'http://localhost:8080/images/msi-mag-341cqp-qd-oled-34-uwqhd.jpg',155);
INSERT INTO `producto_imagenes` VALUES (392,1,'http://localhost:8080/images/msi-mag-341cqp-qd-oled-34-uwqhd.jpg',155);
INSERT INTO `producto_imagenes` VALUES (393,0,'http://localhost:8080/images/msi-mag-341cqp-qd-oled-34-uwqhd.jpg',155);
INSERT INTO `producto_imagenes` VALUES (394,2,'http://localhost:8080/images/dell-s2725ds-27-qhd-100hz.jpg',156);
INSERT INTO `producto_imagenes` VALUES (395,1,'http://localhost:8080/images/dell-s2725ds-27-qhd-100hz.jpg',156);
INSERT INTO `producto_imagenes` VALUES (396,0,'http://localhost:8080/images/dell-s2725ds-27-qhd-100hz.jpg',156);
INSERT INTO `producto_imagenes` VALUES (397,2,'http://localhost:8080/images/dell-ultrasharp-u2724d-27-qhd.jpg',157);
INSERT INTO `producto_imagenes` VALUES (398,1,'http://localhost:8080/images/dell-ultrasharp-u2724d-27-qhd.jpg',157);
INSERT INTO `producto_imagenes` VALUES (399,0,'http://localhost:8080/images/dell-ultrasharp-u2724d-27-qhd.jpg',157);
INSERT INTO `producto_imagenes` VALUES (400,2,'http://localhost:8080/images/dell-p2425h-24-full-hd.jpg',158);
INSERT INTO `producto_imagenes` VALUES (401,1,'http://localhost:8080/images/dell-p2425h-24-full-hd.jpg',158);
INSERT INTO `producto_imagenes` VALUES (402,0,'http://localhost:8080/images/dell-p2425h-24-full-hd.jpg',158);
INSERT INTO `producto_imagenes` VALUES (403,2,'http://localhost:8080/images/aoc-q27g4-27-qhd-180hz.jpg',160);
INSERT INTO `producto_imagenes` VALUES (404,1,'http://localhost:8080/images/aoc-q27g4-27-qhd-180hz.jpg',160);
INSERT INTO `producto_imagenes` VALUES (405,0,'http://localhost:8080/images/aoc-q27g4-27-qhd-180hz.jpg',160);
INSERT INTO `producto_imagenes` VALUES (406,2,'http://localhost:8080/images/philips-241v8lb-24-full-hd.jpg',162);
INSERT INTO `producto_imagenes` VALUES (407,1,'http://localhost:8080/images/philips-241v8lb-24-full-hd.jpg',162);
INSERT INTO `producto_imagenes` VALUES (408,0,'http://localhost:8080/images/philips-241v8lb-24-full-hd.jpg',162);
INSERT INTO `producto_imagenes` VALUES (409,2,'http://localhost:8080/images/b1701941-e9b6-4bd8-aed0-f13d8c9f924f.png',165);
INSERT INTO `producto_imagenes` VALUES (410,1,'http://localhost:8080/images/b1701941-e9b6-4bd8-aed0-f13d8c9f924f.png',165);
INSERT INTO `producto_imagenes` VALUES (411,0,'http://localhost:8080/images/b1701941-e9b6-4bd8-aed0-f13d8c9f924f.png',165);
INSERT INTO `producto_imagenes` VALUES (412,2,'http://localhost:8080/images/a84f144e-98a3-4e3e-92d1-878c10b65e47.png',166);
INSERT INTO `producto_imagenes` VALUES (413,1,'http://localhost:8080/images/a84f144e-98a3-4e3e-92d1-878c10b65e47.png',166);
INSERT INTO `producto_imagenes` VALUES (414,0,'http://localhost:8080/images/a84f144e-98a3-4e3e-92d1-878c10b65e47.png',166);
/*!40000 ALTER TABLE `producto_imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `precio` double DEFAULT NULL,
  `categoria_id` bigint NOT NULL,
  `stock` int NOT NULL,
  `vendedor_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2fwq10nwymfv7fumctxt9vpgb` (`categoria_id`),
  KEY `FK9ldwxe2d6e82fy5k9ovg7mn18` (`vendedor_id`),
  CONSTRAINT `FK2fwq10nwymfv7fumctxt9vpgb` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  CONSTRAINT `FK9ldwxe2d6e82fy5k9ovg7mn18` FOREIGN KEY (`vendedor_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (20,'32GB GDDR7, 21760 CUDA cores, DLSS 4, triple ventilador, PCIe 5.0, fuente recomendada 1000W','NVIDIA GeForce RTX 5090 ASUS ROG Astral 32GB',4890000,1,5,3);
INSERT INTO `productos` VALUES (21,'16GB GDDR7, DLSS 4 con Multi Frame Generation, 3x DisplayPort 2.1b, 1x HDMI 2.1b','NVIDIA GeForce RTX 5080 MSI Gaming Trio 16GB',2150000,1,12,4);
INSERT INTO `productos` VALUES (22,'16GB GDDR7, bus 256 bits, ideal 1440p y 4K, triple ventilador Windforce','NVIDIA GeForce RTX 5070 Ti Gigabyte Windforce 16GB',1420000,1,32,3);
INSERT INTO `productos` VALUES (23,'12GB GDDR7, DLSS 4, diseno compacto doble ventilador, consumo 250W','NVIDIA GeForce RTX 5070 Zotac Twin Edge 12GB',1050000,1,37,4);
INSERT INTO `productos` VALUES (24,'16GB GDDR7, bus 128 bits, doble ventilador Axial-tech, ideal 1080p/1440p','NVIDIA GeForce RTX 5060 Ti ASUS Dual 16GB',760000,1,34,3);
INSERT INTO `productos` VALUES (25,'8GB GDDR7, DLSS 4, consumo 145W, un solo conector de 8 pines','NVIDIA GeForce RTX 5060 PNY 8GB',545000,1,5,4);
INSERT INTO `productos` VALUES (26,'12GB GDDR6X, DLSS 3, ray tracing de 3ra generacion, 2 ventiladores','NVIDIA GeForce RTX 4070 Super Asus Dual 12GB',920000,1,3,3);
INSERT INTO `productos` VALUES (27,'8GB GDDR6, DLSS 3, consumo 115W, ideal gaming 1080p','NVIDIA GeForce RTX 4060 MSI Ventus 2X 8GB',480000,1,34,4);
INSERT INTO `productos` VALUES (28,'12GB GDDR6, bus 192 bits, triple ventilador, RGB Fusion','NVIDIA GeForce RTX 3060 Gigabyte Gaming OC 12GB',410000,1,0,3);
INSERT INTO `productos` VALUES (29,'16GB GDDR6, arquitectura RDNA 4, FSR 4, 2x DisplayPort 2.1a','AMD Radeon RX 9070 XT Sapphire Pulse 16GB',1180000,1,37,4);
INSERT INTO `productos` VALUES (30,'16GB GDDR6, RDNA 4, diseno de 2 slots, consumo 220W','AMD Radeon RX 9070 PowerColor Reaper 16GB',990000,1,19,3);
INSERT INTO `productos` VALUES (31,'16GB GDDR6, RDNA 4, FSR 4, ideal 1080p alto refresco','AMD Radeon RX 9060 XT XFX Swift 16GB',590000,1,28,4);
INSERT INTO `productos` VALUES (32,'24GB GDDR6, bus 384 bits, Infinity Cache 96MB, RGB ARGB','AMD Radeon RX 7900 XTX Sapphire Nitro+ 24GB',1650000,1,28,3);
INSERT INTO `productos` VALUES (33,'16GB GDDR6, ideal 1440p, triple ventilador, backplate metalico','AMD Radeon RX 7800 XT ASRock Challenger 16GB',720000,1,38,4);
INSERT INTO `productos` VALUES (34,'8GB GDDR6, RDNA 3, FSR 3, triple ventilador Windforce','AMD Radeon RX 7600 Gigabyte Gaming OC 8GB',360000,1,27,3);
INSERT INTO `productos` VALUES (35,'12GB GDDR6, arquitectura Battlemage, XeSS 2, AV1 encode por hardware','Intel Arc B580 Limited Edition 12GB',420000,1,5,4);
INSERT INTO `productos` VALUES (36,'8GB GDDR6, ray tracing por hardware, XeSS, buena opcion calidad-precio','Intel Arc A750 ASRock Challenger 8GB',285000,1,4,3);
INSERT INTO `productos` VALUES (37,'4GB GDDR6, sin conector de alimentacion externo, ideal PCs de oficina','NVIDIA GeForce GTX 1650 MSI Ventus XS 4GB',210000,1,5,4);
INSERT INTO `productos` VALUES (38,'6GB GDDR6, consumo 70W, alimentacion por slot PCIe','NVIDIA GeForce RTX 3050 Asus Dual 6GB',260000,1,3,3);
INSERT INTO `productos` VALUES (39,'8GB GDDR6, ideal 1080p, doble ventilador, consumo 132W','AMD Radeon RX 6600 XFX Speedster SWFT 8GB',315000,1,33,4);
INSERT INTO `productos` VALUES (40,'16 nucleos, 32 hilos, hasta 5.7GHz, 128MB L3 con 3D V-Cache, AM5, sin cooler','AMD Ryzen 9 9950X3D',1150000,2,5,3);
INSERT INTO `productos` VALUES (41,'16 nucleos, 32 hilos, hasta 5.7GHz, Zen 5, AM5, TDP 170W, sin cooler','AMD Ryzen 9 9950X',890000,2,13,4);
INSERT INTO `productos` VALUES (42,'12 nucleos, 24 hilos, hasta 5.6GHz, Zen 5, AM5, TDP 120W','AMD Ryzen 9 9900X',640000,2,37,3);
INSERT INTO `productos` VALUES (43,'8 nucleos, 16 hilos, hasta 5.2GHz, 96MB L3 3D V-Cache, el mejor para gaming','AMD Ryzen 7 9800X3D',780000,2,39,4);
INSERT INTO `productos` VALUES (44,'8 nucleos, 16 hilos, hasta 5.5GHz, Zen 5, AM5, TDP 65W','AMD Ryzen 7 9700X',470000,2,4,3);
INSERT INTO `productos` VALUES (45,'8 nucleos, 16 hilos, hasta 5.0GHz, 96MB L3 3D V-Cache, AM5','AMD Ryzen 7 7800X3D',560000,2,36,4);
INSERT INTO `productos` VALUES (46,'8 nucleos, 16 hilos, hasta 5.3GHz, AM5, incluye cooler Wraith Prism','AMD Ryzen 7 7700',360000,2,7,3);
INSERT INTO `productos` VALUES (47,'6 nucleos, 12 hilos, hasta 5.4GHz, Zen 5, AM5, sin cooler','AMD Ryzen 5 9600X',330000,2,14,4);
INSERT INTO `productos` VALUES (48,'6 nucleos, 12 hilos, hasta 5.1GHz, AM5, graficos Radeon integrados, con cooler','AMD Ryzen 5 7600',250000,2,39,3);
INSERT INTO `productos` VALUES (49,'6 nucleos, 12 hilos, hasta 4.6GHz, AM4, incluye cooler Wraith Stealth','AMD Ryzen 5 5600X',175000,2,12,4);
INSERT INTO `productos` VALUES (50,'6 nucleos, 12 hilos, AM4, graficos Radeon Vega 7 integrados, con cooler','AMD Ryzen 5 5600G',165000,2,33,3);
INSERT INTO `productos` VALUES (51,'8 nucleos, 16 hilos, 96MB L3 3D V-Cache, AM4, upgrade ideal para gaming','AMD Ryzen 7 5700X3D',310000,2,36,4);
INSERT INTO `productos` VALUES (52,'24 nucleos (8P+16E), hasta 5.7GHz, LGA1851, NPU integrada, sin cooler','Intel Core Ultra 9 285K',870000,2,13,3);
INSERT INTO `productos` VALUES (53,'20 nucleos (8P+12E), hasta 5.5GHz, LGA1851, graficos Intel integrados','Intel Core Ultra 7 265K',560000,2,35,4);
INSERT INTO `productos` VALUES (54,'14 nucleos (6P+8E), hasta 5.2GHz, LGA1851, desbloqueado para OC','Intel Core Ultra 5 245K',390000,2,40,3);
INSERT INTO `productos` VALUES (55,'24 nucleos (8P+16E), hasta 6.0GHz, LGA1700, sin cooler','Intel Core i9 14900K',720000,2,4,4);
INSERT INTO `productos` VALUES (56,'20 nucleos (8P+12E), hasta 5.6GHz, LGA1700, graficos UHD 770','Intel Core i7 14700K',520000,2,25,3);
INSERT INTO `productos` VALUES (57,'10 nucleos (6P+4E), hasta 4.7GHz, LGA1700, sin graficos integrados, con cooler','Intel Core i5 14400F',235000,2,38,4);
INSERT INTO `productos` VALUES (58,'6 nucleos, 12 hilos, hasta 4.4GHz, LGA1700, incluye cooler Laminar','Intel Core i5 12400F',155000,2,31,3);
INSERT INTO `productos` VALUES (59,'4 nucleos, 8 hilos, hasta 4.3GHz, LGA1700, graficos UHD 730, con cooler','Intel Core i3 12100',120000,2,24,4);
INSERT INTO `productos` VALUES (60,'Kit dual channel, CL36, perfil AMD EXPO e Intel XMP 3.0, disipador negro','Kingston Fury Beast DDR5 32GB (2x16GB) 6000MHz',155000,3,6,3);
INSERT INTO `productos` VALUES (61,'Kit dual channel, CL30, iluminacion RGB, EXPO/XMP 3.0','Kingston Fury Beast RGB DDR5 64GB (2x32GB) 6000MHz',320000,3,0,4);
INSERT INTO `productos` VALUES (62,'CL32, compatible iCUE, 10 LEDs RGB por modulo, XMP 3.0','Corsair Vengeance RGB DDR5 32GB (2x16GB) 6400MHz',185000,3,35,3);
INSERT INTO `productos` VALUES (63,'Modulo simple, CL40, perfil bajo, XMP 3.0','Corsair Vengeance DDR5 16GB 5600MHz',72000,3,37,4);
INSERT INTO `productos` VALUES (64,'CL34, optimizada para Intel, disipador de aluminio cepillado','G.Skill Trident Z5 RGB DDR5 32GB (2x16GB) 7200MHz',230000,3,18,3);
INSERT INTO `productos` VALUES (65,'CL30, optimizada para AMD EXPO, perfil bajo 33mm','G.Skill Flare X5 DDR5 32GB (2x16GB) 6000MHz',168000,3,4,4);
INSERT INTO `productos` VALUES (66,'CL38, RGB con difusor de 120 grados, color blanco','TeamGroup T-Force Delta RGB DDR5 32GB (2x16GB) 6000MHz',150000,3,37,3);
INSERT INTO `productos` VALUES (67,'CL30, perfil bajo, PMIC integrado, EXPO/XMP','ADATA XPG Lancer Blade DDR5 32GB (2x16GB) 6000MHz',158000,3,8,4);
INSERT INTO `productos` VALUES (68,'CL46, disipador minimalista, ideal workstation y edicion','Crucial Pro DDR5 64GB (2x32GB) 5600MHz',265000,3,26,3);
INSERT INTO `productos` VALUES (69,'Kit dual channel, CL16, XMP 2.0, disipador negro','Kingston Fury Beast DDR4 16GB (2x8GB) 3200MHz',62000,3,12,4);
INSERT INTO `productos` VALUES (70,'Kit dual channel, CL18, ideal plataformas AM4','Kingston Fury Beast DDR4 32GB (2x16GB) 3600MHz',115000,3,38,3);
INSERT INTO `productos` VALUES (71,'CL16, perfil bajo, compatible con coolers grandes','Corsair Vengeance LPX DDR4 16GB (2x8GB) 3200MHz',64000,3,2,4);
INSERT INTO `productos` VALUES (72,'CL18, 10 LEDs RGB por modulo, control via iCUE','Corsair Vengeance RGB Pro DDR4 32GB (2x16GB) 3600MHz',128000,3,36,3);
INSERT INTO `productos` VALUES (73,'CL16, disipador rojo, XMP 2.0, alta compatibilidad','G.Skill Ripjaws V DDR4 32GB (2x16GB) 3200MHz',105000,3,23,4);
INSERT INTO `productos` VALUES (74,'Modulo simple, CL16, disipador de aluminio gris','Patriot Viper Steel DDR4 16GB 3200MHz',38000,3,29,3);
INSERT INTO `productos` VALUES (75,'Modulo simple, CL19, sin disipador, ideal PCs de oficina','Kingston ValueRAM DDR4 8GB 2666MHz',22000,3,4,4);
INSERT INTO `productos` VALUES (76,'Memoria para notebook, CL40, plug and play','Kingston Fury Impact SODIMM DDR5 16GB 5600MHz',68000,3,1,3);
INSERT INTO `productos` VALUES (77,'Memoria para notebook, CL22, 1.2V','Crucial SODIMM DDR4 16GB 3200MHz',45000,3,4,4);
INSERT INTO `productos` VALUES (78,'Memoria para notebook, CL22, modulo original OEM','Samsung SODIMM DDR4 8GB 3200MHz',26000,3,11,3);
INSERT INTO `productos` VALUES (79,'Memoria para notebook, CL46, ideal upgrade de laptops gamer','Crucial SODIMM DDR5 32GB 5600MHz',120000,3,18,4);
INSERT INTO `productos` VALUES (80,'PCIe 4.0 x4, lectura 7450 MB/s, escritura 6900 MB/s, M.2 2280','Samsung 990 Pro SSD NVMe 2TB',245000,4,5,3);
INSERT INTO `productos` VALUES (81,'PCIe 4.0, lectura 7450 MB/s, disipador RGB, compatible PS5','Samsung 990 Pro SSD NVMe 1TB con disipador',165000,4,0,4);
INSERT INTO `productos` VALUES (82,'PCIe 5.0 x4, lectura 14700 MB/s, escritura 13400 MB/s, M.2 2280','Samsung 9100 Pro SSD NVMe 2TB',390000,4,23,3);
INSERT INTO `productos` VALUES (83,'2.5 pulgadas, lectura 560 MB/s, escritura 530 MB/s, 5 anos de garantia','Samsung 870 EVO SSD SATA 1TB',105000,4,28,4);
INSERT INTO `productos` VALUES (84,'PCIe 4.0, lectura 7300 MB/s, modo gaming, M.2 2280','WD Black SN850X SSD NVMe 2TB',230000,4,3,3);
INSERT INTO `productos` VALUES (85,'PCIe 4.0, lectura 7250 MB/s, bajo consumo, ideal notebooks','WD Black SN7100 SSD NVMe 1TB',115000,4,37,4);
INSERT INTO `productos` VALUES (86,'PCIe 4.0, lectura 5150 MB/s, M.2 2280','WD Blue SN5000 SSD NVMe 1TB',89000,4,14,3);
INSERT INTO `productos` VALUES (87,'PCIe 4.0, lectura 6000 MB/s, escritura 4000 MB/s, M.2 2280','Kingston NV3 SSD NVMe 1TB',78000,4,36,4);
INSERT INTO `productos` VALUES (88,'PCIe 4.0, lectura 6000 MB/s, escritura 5000 MB/s, M.2 2280','Kingston NV3 SSD NVMe 2TB',138000,4,38,3);
INSERT INTO `productos` VALUES (89,'2.5 pulgadas, lectura 500 MB/s, ideal para revivir PCs viejas','Kingston A400 SSD SATA 480GB',38000,4,4,4);
INSERT INTO `productos` VALUES (90,'PCIe 4.0, lectura 7000 MB/s, disipador de grafeno','Kingston KC3000 SSD NVMe 2TB',215000,4,14,3);
INSERT INTO `productos` VALUES (91,'PCIe 5.0, lectura 14500 MB/s, con disipador de aluminio','Crucial T705 SSD NVMe 2TB',420000,4,25,4);
INSERT INTO `productos` VALUES (92,'PCIe 4.0, lectura 5000 MB/s, M.2 2280','Crucial P3 Plus SSD NVMe 1TB',76000,4,30,3);
INSERT INTO `productos` VALUES (93,'2.5 pulgadas, lectura 540 MB/s, escritura 500 MB/s','Crucial BX500 SSD SATA 1TB',72000,4,39,4);
INSERT INTO `productos` VALUES (94,'PCIe 4.0, lectura 6000 MB/s, incluye disipador','ADATA Legend 860 SSD NVMe 1TB',74000,4,30,3);
INSERT INTO `productos` VALUES (95,'Disco rigido 3.5 pulgadas, SATA 6Gb/s, cache 256MB','Seagate Barracuda HDD 2TB 7200rpm',82000,4,0,4);
INSERT INTO `productos` VALUES (96,'Disco rigido 3.5 pulgadas, 5400rpm, optimizado para NAS 24/7','Seagate IronWolf HDD 4TB NAS',165000,4,1,3);
INSERT INTO `productos` VALUES (97,'Disco rigido 3.5 pulgadas, SATA 6Gb/s, cache 64MB','WD Blue HDD 1TB 7200rpm',56000,4,3,4);
INSERT INTO `productos` VALUES (98,'Disco rigido 3.5 pulgadas, 5640rpm, CMR, cache 256MB','WD Red Plus HDD 8TB NAS',340000,4,7,3);
INSERT INTO `productos` VALUES (99,'USB 3.2 Gen 2 tipo C, lectura 1050 MB/s, cuerpo de aluminio','Samsung T7 SSD Externo 1TB',125000,4,0,4);
INSERT INTO `productos` VALUES (100,'USB-C, lectura 1050 MB/s, resistencia IP65 al agua y polvo','SanDisk Extreme Portable SSD 2TB',210000,4,25,3);
INSERT INTO `productos` VALUES (101,'USB 3.2, cifrado AES de 256 bits, software de backup incluido','WD My Passport HDD Externo 2TB',95000,4,13,4);
INSERT INTO `productos` VALUES (102,'USB 3.0, plug and play, compatible Windows y Mac','Seagate Expansion HDD Externo 4TB',145000,4,35,3);
INSERT INTO `productos` VALUES (103,'USB 3.2, lectura 400 MB/s, formato ultra compacto','SanDisk Ultra Fit Pendrive 128GB',18000,4,16,4);
INSERT INTO `productos` VALUES (104,'Clase 10, UHS-I U3, V30, A1, incluye adaptador SD','Kingston Canvas Select Plus microSD 256GB',26000,4,5,3);
INSERT INTO `productos` VALUES (105,'60 g, sensor HERO 2 de 32000 DPI, LIGHTSPEED, 95 h de bateria','Logitech G Pro X Superlight 2 Mouse Inalambrico',210000,5,5,4);
INSERT INTO `productos` VALUES (106,'Sensor HERO 25K, switches LIGHTFORCE, RGB LIGHTSYNC, 13 botones','Logitech G502 X Plus Mouse Inalambrico',185000,5,5,3);
INSERT INTO `productos` VALUES (107,'8000 DPI, 6 botones programables, iluminacion RGB','Logitech G203 Lightsync Mouse Gamer',32000,5,1,4);
INSERT INTO `productos` VALUES (108,'8000 DPI, clicks silenciosos, scroll MagSpeed, Bluetooth y Bolt','Logitech MX Master 3S Mouse Inalambrico',145000,5,8,3);
INSERT INTO `productos` VALUES (109,'Cableado, 59 g, sensor Focus Pro 30K, switches opticos gen-3','Razer DeathAdder V3 Mouse Gamer',98000,5,2,4);
INSERT INTO `productos` VALUES (110,'54 g, sensor Focus Pro 35K, polling 8000 Hz, 95 h de bateria','Razer Viper V3 Pro Mouse Inalambrico',225000,5,0,3);
INSERT INTO `productos` VALUES (111,'53 g, sensor 26000 DPI, cable HyperFlex 2','HyperX Pulsefire Haste 2 Mouse Gamer',52000,5,9,4);
INSERT INTO `productos` VALUES (112,'10000 DPI, 7 botones programables, RGB Chroma','Redragon Cobra M711 Mouse Gamer',19500,5,18,3);
INSERT INTO `productos` VALUES (113,'Tenkeyless, switches GX Brown tactiles, LIGHTSPEED y Bluetooth','Logitech G Pro X TKL Teclado Mecanico Inalambrico',260000,5,7,4);
INSERT INTO `productos` VALUES (114,'Full size, switches tactiles, retroiluminacion blanca, aluminio','Logitech G413 SE Teclado Mecanico',79000,5,5,3);
INSERT INTO `productos` VALUES (115,'Switches Razer Green, RGB Chroma, 6 teclas macro, reposamunecas','Razer BlackWidow V4 Teclado Mecanico',195000,5,5,4);
INSERT INTO `productos` VALUES (116,'TKL, switches HyperX Red lineales, cuerpo de aluminio, RGB','HyperX Alloy Origins Core Teclado Mecanico',95000,5,14,3);
INSERT INTO `productos` VALUES (117,'TKL, switches Outemu Red, layout espanol, RGB','Redragon Kumara K552 RGB Teclado Mecanico',42000,5,2,4);
INSERT INTO `productos` VALUES (118,'75%, hot-swap, switches K Pro Brown, Bluetooth y USB-C, Mac/Windows','Keychron K2 Pro Teclado Mecanico Inalambrico',165000,5,33,3);
INSERT INTO `productos` VALUES (119,'Teclas retroiluminadas inteligentes, multi-dispositivo, USB-C recargable','Logitech MX Keys S Teclado Inalambrico',150000,5,11,4);
INSERT INTO `productos` VALUES (120,'Drivers de 53 mm, microfono desmontable con cancelacion de ruido, DTS:X','HyperX Cloud III Auriculares Gamer',110000,5,17,3);
INSERT INTO `productos` VALUES (121,'Hasta 300 h de bateria, drivers de doble camara, DTS Headphone:X','HyperX Cloud Alpha Wireless Auriculares Gamer',205000,5,3,4);
INSERT INTO `productos` VALUES (122,'Sonido 7.1, RGB, 278 g, microfono Blue VO!CE','Logitech G733 Lightspeed Auriculares Inalambricos',175000,5,32,3);
INSERT INTO `productos` VALUES (123,'Drivers TriForce de 50 mm, sonido 7.1, 240 g, jack 3.5 mm','Razer BlackShark V2 X Auriculares Gamer',62000,5,2,4);
INSERT INTO `productos` VALUES (124,'Cancelacion activa de ruido lider, 30 h de bateria, carga rapida','Sony WH-1000XM5 Auriculares Bluetooth',520000,5,4,3);
INSERT INTO `productos` VALUES (125,'Sonido JBL Pure Bass, 57 h de bateria, multipunto','JBL Tune 520BT Auriculares Bluetooth',65000,5,39,4);
INSERT INTO `productos` VALUES (126,'1080p a 30 fps, microfono estereo, tapa de privacidad','Logitech C920s Pro Webcam Full HD',92000,5,23,3);
INSERT INTO `productos` VALUES (127,'4K Ultra HD, HDR, Windows Hello, campo visual ajustable','Logitech Brio 4K Webcam',260000,5,19,4);
INSERT INTO `productos` VALUES (128,'1080p 60 fps, sensor de luz adaptativo, HDR','Razer Kiyo Pro Webcam',175000,5,1,3);
INSERT INTO `productos` VALUES (129,'Condensador, 4 patrones polares, RGB, sensor anti-vibracion','HyperX QuadCast S Microfono USB',185000,5,27,4);
INSERT INTO `productos` VALUES (130,'Condensador cardioide, control de volumen, plug and play','Fifine K669B Microfono USB',38000,5,17,3);
INSERT INTO `productos` VALUES (131,'340 x 280 mm, superficie de tela, base de goma antideslizante','Logitech G240 Mousepad Gamer',18000,5,28,4);
INSERT INTO `productos` VALUES (132,'940 x 410 mm, superficie texturizada micro-tejida, base de goma','Razer Gigantus V2 XXL Mousepad',48000,5,28,3);
INSERT INTO `productos` VALUES (133,'25 W RMS, subwoofer incluido, control de volumen cableado','Logitech Z313 Parlantes 2.1',72000,5,40,4);
INSERT INTO `productos` VALUES (134,'Bluetooth y USB-C, compatible PC y Xbox Series X|S, boton compartir','Xbox Wireless Controller Joystick',98000,5,5,3);
INSERT INTO `productos` VALUES (135,'Gatillos adaptativos, respuesta haptica, compatible PC por Bluetooth','Sony DualSense Joystick PS5',115000,5,19,4);
INSERT INTO `productos` VALUES (136,'Dual band AC1300, antena de alta ganancia, USB 3.0','TP-Link Archer T3U Plus Adaptador WiFi USB',32000,5,23,3);
INSERT INTO `productos` VALUES (137,'HDMI 4K 60Hz, 2x USB-A 3.0, lector SD/microSD, PD 100W','Ugreen Hub USB-C 7 en 1',48000,5,14,4);
INSERT INTO `productos` VALUES (138,'Panel VA curvo 1000R, 2560x1440, 1 ms, FreeSync Premium, HDR10','Samsung Odyssey G5 27 QHD 165Hz',420000,6,3,3);
INSERT INTO `productos` VALUES (139,'Panel IPS, 3840x2160, 1 ms, G-Sync compatible, HDR400','Samsung Odyssey G7 32 4K 144Hz',890000,6,4,4);
INSERT INTO `productos` VALUES (140,'Panel QD-OLED, 2560x1440, 0.03 ms, HDR True Black 400','Samsung Odyssey OLED G6 27 QHD 360Hz',1350000,6,1,3);
INSERT INTO `productos` VALUES (141,'Panel IPS, 2560x1440, 100Hz, USB-C 90W, ideal oficina y diseno','Samsung ViewFinity S6 27 QHD',380000,6,17,4);
INSERT INTO `productos` VALUES (142,'Panel IPS, 1920x1080, 100Hz, bordes ultra delgados, Eye Saver Mode','Samsung Essential S3 24 Full HD',145000,6,12,3);
INSERT INTO `productos` VALUES (143,'Panel IPS, 2560x1440, 1 ms GtG, G-Sync compatible, HDR10','LG UltraGear 27GR75Q 27 QHD 165Hz',450000,6,23,4);
INSERT INTO `productos` VALUES (144,'Panel IPS, 1920x1080, 1 ms, FreeSync Premium, HDR10','LG UltraGear 24GS60F 24 Full HD 180Hz',210000,6,10,3);
INSERT INTO `productos` VALUES (145,'Panel OLED, 2560x1440, 0.03 ms, HDR True Black 400','LG UltraGear OLED 27GS95QE 27 QHD 240Hz',1490000,6,3,4);
INSERT INTO `productos` VALUES (146,'Panel IPS curvo, 3440x1440, 100Hz, USB-C, HDR10','LG UltraWide 34WQ60C 34 WQHD',590000,6,3,3);
INSERT INTO `productos` VALUES (147,'Panel IPS, 3840x2160, 60Hz, USB-C 96W, 95% DCI-P3, HDR400','LG 27UP850N 27 4K',610000,6,4,4);
INSERT INTO `productos` VALUES (148,'Panel VA, 1920x1080, 100Hz, AMD FreeSync, modo lectura','LG 22MR410 22 Full HD',115000,6,22,3);
INSERT INTO `productos` VALUES (149,'Panel IPS, 2560x1440, 1 ms, ELMB Sync, G-Sync compatible','ASUS TUF Gaming VG27AQ3A 27 QHD 180Hz',435000,6,6,4);
INSERT INTO `productos` VALUES (150,'Panel OLED, 2560x1440, 0.03 ms, disipador personalizado, HDR10','ASUS ROG Swift PG27AQDM 27 OLED 240Hz',1520000,6,2,3);
INSERT INTO `productos` VALUES (151,'Panel IPS, 1920x1080, 1 ms MPRT, Eye Care, montaje VESA','ASUS VA24EHF 24 Full HD 100Hz',135000,6,0,4);
INSERT INTO `productos` VALUES (152,'Panel IPS, 2560x1440, 100% sRGB, Calman Verified, USB-C 65W','ASUS ProArt PA278CV 27 QHD',560000,6,5,3);
INSERT INTO `productos` VALUES (153,'Panel IPS, 1920x1080, 1 ms, FreeSync Premium, base inclinable','MSI G2412 24 Full HD 170Hz',175000,6,28,4);
INSERT INTO `productos` VALUES (154,'Panel Rapid IPS con Quantum Dot, 2560x1440, 1 ms, HDR Ready','MSI MAG 274QRF QD E2 27 QHD 180Hz',470000,6,4,3);
INSERT INTO `productos` VALUES (155,'Panel QD-OLED curvo 1800R, 3440x1440, 175Hz, 0.03 ms','MSI MAG 341CQP QD-OLED 34 UWQHD',1290000,6,8,4);
INSERT INTO `productos` VALUES (156,'Panel IPS, 2560x1440, parlantes integrados, base regulable en altura','Dell S2725DS 27 QHD 100Hz',330000,6,26,3);
INSERT INTO `productos` VALUES (157,'Panel IPS Black, 2560x1440, 120Hz, 100% sRGB, base ergonomica','Dell UltraSharp U2724D 27 QHD',640000,6,35,4);
INSERT INTO `productos` VALUES (158,'Panel IPS, 1920x1080, 100Hz, base ajustable altura/giro/pivote','Dell P2425H 24 Full HD',220000,6,13,3);
INSERT INTO `productos` VALUES (159,'Panel IPS, 1920x1080, 1 ms, Adaptive-Sync, base regulable','AOC 24G4 24 Full HD 180Hz',185000,6,38,4);
INSERT INTO `productos` VALUES (160,'Panel IPS, 2560x1440, 1 ms, HDR10, base ergonomica','AOC Q27G4 27 QHD 180Hz',340000,6,22,3);
INSERT INTO `productos` VALUES (161,'Panel SS IPS, 1920x1080, 1 ms, 95% DCI-P3, KVM integrado','Gigabyte G27F 2 27 Full HD 170Hz',245000,6,28,4);
INSERT INTO `productos` VALUES (162,'Panel VA, 1920x1080, 100Hz, Adaptive-Sync, ideal oficina','Philips 241V8LB 24 Full HD',112000,6,4,3);
INSERT INTO `productos` VALUES (163,'Panel IPS, 1920x1080, 0.5 ms, FreeSync Premium, parlantes','ViewSonic VX2728J 27 Full HD 180Hz',230000,6,24,4);
INSERT INTO `productos` VALUES (165,'Panel IPS, 2560x1440, 0.5 ms, FreeSync Premium, HDR400, base regulable en altura','Lenovo Legion R27q-30 27 QHD 180Hz',410000,6,5,5);
INSERT INTO `productos` VALUES (166,'Teclado mecánico retroiluminado','Teclado mecánico',45000,1,10,5);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `apellido` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('ADMIN','USER','VENDEDOR') DEFAULT NULL,
  `nombre_usuario` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKkfsp0s1tflm1cwlj8idhqsad0` (`email`),
  UNIQUE KEY `UKof5vabgukahdwmgxk4kjrbu98` (`nombre_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Lopez','maria@mail.com','Maria','$2a$10$EmF/DGh1.RsQDxBJjNCZBuGGemFtYgHRhzW266RDYV6cfdyFCR.EC','USER','marial');
INSERT INTO `usuarios` VALUES (2,'Sistema','admin@mail.com','Admin','$2a$10$9T014H7vIuDrG/TG.SsOVO42RTz0SuLOdCaNjjbuncc3WmkviIsAi','ADMIN','admin');
INSERT INTO `usuarios` VALUES (3,'Perez','juan@mail.com','Juan','$2a$10$eaxFuvnt7pTASxb3hxtF2O6IzuBZAaqKUWKLrEFRnbyhwegOG9NFS','USER','juanp');
INSERT INTO `usuarios` VALUES (4,'Fernandez','lucia@mail.com','Lucia','$2a$10$VG.qiZ0KQ6YepXh4P2POcuq3Ga75SE3PQ5I/bqHSpdPLGPXSbOieS','USER','luciaf');
INSERT INTO `usuarios` VALUES (5,'Metz','mmetz@uade.edu.ar','Miguel','$2a$10$YjPmYn3OG.i32iml/KXoXOcBr5aRjMXTwm03n7GEwZ81ait5Vqogm','USER','miguel22');
INSERT INTO `usuarios` VALUES (6,'Nuevo','miguel-nuevo@email.com','Miguel','$2a$10$X/ac69Fm9KMl5tcQum8iaeJ9BtsMh9ChclNOP/2v7O4tLcsvoBBs2','USER','miguelnuevo');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
