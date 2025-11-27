CREATE DATABASE  IF NOT EXISTS `sistema_curriculos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistema_curriculos`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_curriculos
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `id_admin` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidato`
--

DROP TABLE IF EXISTS `candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato` (
  `id_candidato` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id_candidato`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato`
--

LOCK TABLES `candidato` WRITE;
/*!40000 ALTER TABLE `candidato` DISABLE KEYS */;
INSERT INTO `candidato` VALUES (1,'Henrique Ferreira Santos','henrique.ferreira.santos@exemplo.com','+55 11 91896-2569','senha1'),(2,'Paula Moreira Pereira','paula.moreira.pereira@exemplo.com','+55 11 91288-1625','senha2'),(3,'Sofia Teixeira da Silva','sofia.teixeira.da.silva@exemplo.com','+55 11 91693-7084','senha3'),(4,'Carla Mendes Ferreira','carla.mendes.ferreira@exemplo.com','+55 11 96357-3867','senha4'),(5,'Tiago Barros Ferreira','tiago.barros.ferreira@exemplo.com','+55 11 94864-1445','senha5'),(6,'Eduarda Rocha Santos','eduarda.rocha.santos@exemplo.com','+55 11 97942-6822','senha6'),(7,'Eduarda Rocha Pereira','eduarda.rocha.pereira@exemplo.com','+55 11 98160-2097','senha7'),(8,'Tiago Barros Santos','tiago.barros.santos@exemplo.com','+55 11 91848-4102','senha8'),(9,'Eduarda Rocha Ferreira','eduarda.rocha.ferreira@exemplo.com','+55 11 97842-7648','senha9'),(11,'Ricardo Nunes Melo','ricardo.nunes.melo@exemplo.com','+55 11 96484-8086','senha11'),(12,'Natália Andrade Santos','natália.andrade.santos@exemplo.com','+55 11 92550-5003','senha12'),(13,'Karen Martins Ferreira','karen.martins.ferreira@exemplo.com','+55 11 97067-1473','senha13'),(14,'João Pereira da Silva','joão.pereira.da.silva@exemplo.com','+55 11 96463-5381','senha14'),(15,'Carla Mendes da Silva','carla.mendes.da.silva@exemplo.com','+55 11 91933-4621','senha15'),(16,'João Pereira Santos','joão.pereira.santos@exemplo.com','+55 11 94578-8734','senha16'),(17,'Henrique Ferreira Ferreira','henrique.ferreira.ferreira@exemplo.com','+55 11 98200-2508','senha17'),(18,'Sofia Teixeira Melo','sofia.teixeira.melo@exemplo.com','+55 11 98778-8642','senha18'),(20,'Lucas Ribeiro Pereira','lucas.ribeiro.pereira@exemplo.com','+55 11 91732-3024','senha20'),(22,'Natália Andrade Ferreira','natália.andrade.ferreira@exemplo.com','+55 11 96397-7659','senha22'),(23,'Henrique Ferreira Pereira','henrique.ferreira.pereira@exemplo.com','+55 11 96237-9686','senha23'),(24,'Diego Oliveira Pereira','diego.oliveira.pereira@exemplo.com','+55 11 98660-9779','senha24'),(25,'Isabela Costa Ferreira','isabela.costa.ferreira@exemplo.com','+55 11 97351-3959','senha25'),(27,'Sofia Teixeira Pereira','sofia.teixeira.pereira@exemplo.com','+55 11 93239-6571','senha27'),(28,'Bruno Lima Pereira','bruno.lima.pereira@exemplo.com','+55 11 94895-6230','senha28'),(29,'Henrique Ferreira Melo','henrique.ferreira.melo@exemplo.com','+55 11 91956-9574','senha29'),(30,'Tiago Barros Melo','tiago.barros.melo@exemplo.com','+55 11 98356-3547','senha30'),(31,'Diego Oliveira Melo','diego.oliveira.melo@exemplo.com','+55 11 93195-4098','senha31'),(32,'Ana Souza da Silva','ana.souza.da.silva@exemplo.com','+55 11 94560-3746','senha32'),(33,'Natália Andrade da Silva','natália.andrade.da.silva@exemplo.com','+55 11 97249-4169','senha33'),(35,'Paula Moreira da Silva','paula.moreira.da.silva@exemplo.com','+55 11 94386-9714','senha35'),(36,'João Pereira Melo','joão.pereira.melo@exemplo.com','+55 11 93776-7327','senha36'),(38,'Vanessa Lima Santos','vanessa.lima.santos@exemplo.com','+55 11 95849-1176','senha38'),(39,'Karen Martins Melo','karen.martins.melo@exemplo.com','+55 11 93234-4805','senha39'),(40,'Otávio Carvalho da Silva','otávio.carvalho.da.silva@exemplo.com','+55 11 98045-5074','senha40'),(42,'Carla Mendes Melo','carla.mendes.melo@exemplo.com','+55 11 94826-7912','senha42'),(43,'Felipe Alves da Silva','felipe.alves.da.silva@exemplo.com','+55 11 91244-5835','senha43'),(45,'Karen Martins da Silva','karen.martins.da.silva@exemplo.com','+55 11 94862-9191','senha45'),(46,'Ana Souza Melo','ana.souza.melo@exemplo.com','+55 11 94335-3009','senha46'),(47,'Ricardo Nunes da Silva','ricardo.nunes.da.silva@exemplo.com','+55 11 97368-7688','senha47'),(48,'Paula Moreira Santos','paula.moreira.santos@exemplo.com','+55 11 94818-5920','senha48'),(49,'Lucas Ribeiro da Silva','lucas.ribeiro.da.silva@exemplo.com','+55 11 93145-9025','senha49'),(51,'Tiago Barros Pereira','tiago.barros.pereira@exemplo.com','+55 11 99154-8917','senha51'),(52,'Mariana Gomes Melo','mariana.gomes.melo@exemplo.com','+55 11 93011-6948','senha52'),(53,'Vanessa Lima Pereira','vanessa.lima.pereira@exemplo.com','+55 11 98888-9417','senha53'),(54,'Ana Souza Santos','ana.souza.santos@exemplo.com','+55 11 98422-8597','senha54'),(55,'Henrique Ferreira da Silva','henrique.ferreira.da.silva@exemplo.com','+55 11 96502-6235','senha55'),(57,'João Pereira Ferreira','joão.pereira.ferreira@exemplo.com','+55 11 98239-6282','senha57'),(58,'Paula Moreira Melo','paula.moreira.melo@exemplo.com','+55 11 91453-7238','senha58'),(60,'Mariana Gomes Pereira','mariana.gomes.pereira@exemplo.com','+55 11 99333-4957','senha60'),(62,'Tiago Barros da Silva','tiago.barros.da.silva@exemplo.com','+55 11 97488-8663','senha62'),(65,'Ricardo Nunes Pereira','ricardo.nunes.pereira@exemplo.com','+55 11 99824-4662','senha65'),(69,'Mariana Gomes da Silva','mariana.gomes.da.silva@exemplo.com','+55 11 91885-5354','senha69'),(70,'Eduarda Rocha da Silva','eduarda.rocha.da.silva@exemplo.com','+55 11 97137-3569','senha70'),(71,'Ricardo Nunes Ferreira','ricardo.nunes.ferreira@exemplo.com','+55 11 91932-8205','senha71'),(74,'Lucas Ribeiro Santos','lucas.ribeiro.santos@exemplo.com','+55 11 98496-1304','senha74'),(77,'Ana Souza Pereira','ana.souza.pereira@exemplo.com','+55 11 97599-3377','senha77'),(80,'Otávio Carvalho Melo','otávio.carvalho.melo@exemplo.com','+55 11 92428-7368','senha80'),(81,'Vanessa Lima Melo','vanessa.lima.melo@exemplo.com','+55 11 94998-4700','senha81'),(83,'Karen Martins Santos','karen.martins.santos@exemplo.com','+55 11 98660-6243','senha83'),(86,'Isabela Costa Pereira','isabela.costa.pereira@exemplo.com','+55 11 97689-4004','senha86'),(90,'Sofia Teixeira Santos','sofia.teixeira.santos@exemplo.com','+55 11 91064-2664','senha90'),(93,'Otávio Carvalho Ferreira','otávio.carvalho.ferreira@exemplo.com','+55 11 95389-9831','senha93'),(94,'Gabriela Santos Santos','gabriela.santos.santos@exemplo.com','+55 11 97719-8994','senha94'),(99,'Felipe Alves Melo','felipe.alves.melo@exemplo.com','+55 11 93763-3865','senha99');
/*!40000 ALTER TABLE `candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidatura`
--

DROP TABLE IF EXISTS `candidatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidatura` (
  `id_candidato` int NOT NULL,
  `id_vaga` int NOT NULL,
  `data_candidatura` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_candidato`,`id_vaga`),
  KEY `id_vaga` (`id_vaga`),
  CONSTRAINT `candidatura_ibfk_1` FOREIGN KEY (`id_candidato`) REFERENCES `candidato` (`id_candidato`),
  CONSTRAINT `candidatura_ibfk_2` FOREIGN KEY (`id_vaga`) REFERENCES `vaga` (`id_vaga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidatura`
--

LOCK TABLES `candidatura` WRITE;
/*!40000 ALTER TABLE `candidatura` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculo`
--

DROP TABLE IF EXISTS `curriculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curriculo` (
  `id_curriculo` int NOT NULL AUTO_INCREMENT,
  `id_candidato` int NOT NULL,
  `formacao` varchar(255) DEFAULT NULL,
  `experiencia` text,
  `resumo` text,
  `certificacoes` text,
  PRIMARY KEY (`id_curriculo`),
  UNIQUE KEY `id_candidato` (`id_candidato`),
  CONSTRAINT `curriculo_ibfk_1` FOREIGN KEY (`id_candidato`) REFERENCES `candidato` (`id_candidato`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculo`
--

LOCK TABLES `curriculo` WRITE;
/*!40000 ALTER TABLE `curriculo` DISABLE KEYS */;
INSERT INTO `curriculo` VALUES (1,1,'Bacharelado em Sistemas de Informação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como React, PostgreSQL, MongoDB em projetos realizados em empresas como IBM Brasil. Possui certificações como Certified Kubernetes Administrator, Microsoft Certified: Azure Fundamentals, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, Microsoft Certified: Azure Fundamentals'),(2,2,'Engenharia da Computação','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como Kubernetes, TensorFlow, CSS em projetos realizados em empresas como TOTVS, IBM Brasil. Possui certificações como Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE'),(3,3,'Engenharia de Software','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como NoSQL, JavaScript, SQL em projetos realizados em empresas como IBM Brasil, Petrobras. Possui certificações como AWS Certified Solutions Architect, Scrum Master Certified, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Scrum Master Certified'),(4,4,'Bacharelado em Ciência da Computação','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como Azure, Node.js, Spark em projetos realizados em empresas como IBM Brasil. Possui certificações como Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP)'),(5,5,'Bacharelado em Sistemas de Informação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como React, Redis, Angular em projetos realizados em empresas como Microsoft Brasil, IBM Brasil. Possui certificações como Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer'),(6,6,'Engenharia de Software','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como Docker, Google Cloud, MySQL em projetos realizados em empresas como Petrobras, Mercado Livre. Possui certificações como Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP)'),(7,7,'Engenharia de Software','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como Spark, Kubernetes, PostgreSQL em projetos realizados em empresas como Itaú Unibanco, Google Brasil. Possui certificações como Oracle Certified Professional, Java SE, Scrum Master Certified, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Oracle Certified Professional, Java SE, Scrum Master Certified'),(8,8,'Engenharia da Computação','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como SQL, Spark, JavaScript em projetos realizados em empresas como Globo.com, Petrobras. Possui certificações como Scrum Master Certified, Certified Information Systems Security Professional (CISSP), Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Scrum Master Certified, Certified Information Systems Security Professional (CISSP), Certified Kubernetes Administrator'),(9,9,'Bacharelado em Sistemas de Informação','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como Kubernetes, Hadoop, PostgreSQL em projetos realizados em empresas como TOTVS. Possui certificações como AWS Certified Solutions Architect, Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Oracle Certified Professional, Java SE'),(11,11,'Engenharia de Software','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como SQL, MySQL, Hadoop em projetos realizados em empresas como Google Brasil. Possui certificações como Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer'),(12,12,'Engenharia de Software','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como Hadoop, MongoDB, AWS em projetos realizados em empresas como Microsoft Brasil, Vale. Possui certificações como AWS Certified Solutions Architect, Scrum Master Certified, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Scrum Master Certified, Certified Kubernetes Administrator'),(13,13,'Tecnólogo em Análise e Desenvolvimento de Sistemas','2 anos como especialista em segurança da informação','Profissional com 2 anos como especialista em segurança da informação, aplicando tecnologias como Google Cloud, PyTorch, JavaScript em projetos realizados em empresas como Vale. Possui certificações como Google Cloud Professional Data Engineer, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer, Certified Kubernetes Administrator'),(14,14,'Engenharia de Software','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como NoSQL, React, SQL em projetos realizados em empresas como TOTVS, Google Brasil. Possui certificações como AWS Certified Solutions Architect, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Certified Kubernetes Administrator'),(15,15,'Tecnólogo em Análise e Desenvolvimento de Sistemas','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como Google Cloud, Kubernetes, JavaScript em projetos realizados em empresas como TOTVS. Possui certificações como Certified Kubernetes Administrator, Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, Oracle Certified Professional, Java SE'),(16,16,'Bacharelado em Ciência da Computação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como React, Kubernetes, Node.js em projetos realizados em empresas como Google Brasil, TOTVS. Possui certificações como AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect'),(17,17,'Tecnólogo em Análise e Desenvolvimento de Sistemas','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como MongoDB, Docker, React em projetos realizados em empresas como Embraer, IBM Brasil. Possui certificações como Certified Kubernetes Administrator, AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, AWS Certified Solutions Architect'),(18,18,'Bacharelado em Sistemas de Informação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como Java, Node.js, React em projetos realizados em empresas como Petrobras, IBM Brasil. Possui certificações como Scrum Master Certified, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Scrum Master Certified'),(20,20,'Engenharia da Computação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como Docker, MongoDB, Azure em projetos realizados em empresas como Petrobras, PagSeguro. Possui certificações como Scrum Master Certified, Google Cloud Professional Data Engineer, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Scrum Master Certified, Google Cloud Professional Data Engineer, Certified Kubernetes Administrator'),(22,22,'Engenharia da Computação','6 anos como desenvolvedor full stack','Profissional com 6 anos como desenvolvedor full stack, aplicando tecnologias como TensorFlow, Azure, Google Cloud em projetos realizados em empresas como Itaú Unibanco. Possui certificações como Google Cloud Professional Data Engineer, Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer, Certified Information Systems Security Professional (CISSP)'),(23,23,'Bacharelado em Ciência da Computação','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como MongoDB, Angular, Google Cloud em projetos realizados em empresas como Amazon Brasil, Petrobras. Possui certificações como AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect'),(24,24,'Bacharelado em Sistemas de Informação','6 anos como desenvolvedor full stack','Profissional com 6 anos como desenvolvedor full stack, aplicando tecnologias como Node.js, SQL, MongoDB em projetos realizados em empresas como Itaú Unibanco. Possui certificações como Scrum Master Certified, AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Scrum Master Certified, AWS Certified Solutions Architect'),(25,25,'Engenharia da Computação','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como C#, Spark, HTML em projetos realizados em empresas como Vale. Possui certificações como Scrum Master Certified, Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Scrum Master Certified, Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE'),(27,27,'Engenharia de Software','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como Redis, JavaScript, PyTorch em projetos realizados em empresas como Itaú Unibanco. Possui certificações como Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer'),(28,28,'Engenharia de Software','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como Azure, Python, PyTorch em projetos realizados em empresas como IBM Brasil, Itaú Unibanco. Possui certificações como Microsoft Certified: Azure Fundamentals, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals'),(29,29,'Bacharelado em Ciência da Computação','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como Kubernetes, PyTorch, C# em projetos realizados em empresas como Nubank, Embraer. Possui certificações como Certified Information Systems Security Professional (CISSP), Google Cloud Professional Data Engineer, Scrum Master Certified, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP), Google Cloud Professional Data Engineer, Scrum Master Certified'),(30,30,'Bacharelado em Ciência da Computação','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como C#, MongoDB, CSS em projetos realizados em empresas como TOTVS, Google Brasil. Possui certificações como AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect'),(31,31,'Engenharia da Computação','2 anos como especialista em segurança da informação','Profissional com 2 anos como especialista em segurança da informação, aplicando tecnologias como TensorFlow, NoSQL, Spark em projetos realizados em empresas como Google Brasil, Amazon Brasil. Possui certificações como Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator'),(32,32,'Tecnólogo em Análise e Desenvolvimento de Sistemas','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como TensorFlow, React, Azure em projetos realizados em empresas como Nubank, Mercado Livre. Possui certificações como AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect'),(33,33,'Engenharia da Computação','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como Redis, PostgreSQL, AWS em projetos realizados em empresas como Itaú Unibanco, Petrobras. Possui certificações como Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer'),(35,35,'Tecnólogo em Análise e Desenvolvimento de Sistemas','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como MongoDB, Google Cloud, NoSQL em projetos realizados em empresas como PagSeguro. Possui certificações como Oracle Certified Professional, Java SE, AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Oracle Certified Professional, Java SE, AWS Certified Solutions Architect'),(36,36,'Engenharia da Computação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como Angular, HTML, Redis em projetos realizados em empresas como Embraer, Amazon Brasil. Possui certificações como Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP)'),(38,38,'Tecnólogo em Análise e Desenvolvimento de Sistemas','2 anos como especialista em segurança da informação','Profissional com 2 anos como especialista em segurança da informação, aplicando tecnologias como CSS, HTML, React em projetos realizados em empresas como Amazon Brasil, Nubank. Possui certificações como Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator'),(39,39,'Engenharia de Software','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como Java, SQL, NoSQL em projetos realizados em empresas como Embraer, Amazon Brasil. Possui certificações como Microsoft Certified: Azure Fundamentals, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Certified Kubernetes Administrator'),(40,40,'Bacharelado em Sistemas de Informação','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como Redis, HTML, Python em projetos realizados em empresas como Petrobras, Globo.com. Possui certificações como Microsoft Certified: Azure Fundamentals, Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Certified Information Systems Security Professional (CISSP)'),(42,42,'Engenharia de Software','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como SQL, Java, TensorFlow em projetos realizados em empresas como Petrobras. Possui certificações como AWS Certified Solutions Architect, Oracle Certified Professional, Java SE, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Oracle Certified Professional, Java SE, Google Cloud Professional Data Engineer'),(43,43,'Bacharelado em Ciência da Computação','6 anos como desenvolvedor full stack','Profissional com 6 anos como desenvolvedor full stack, aplicando tecnologias como AWS, Hadoop, PyTorch em projetos realizados em empresas como Amazon Brasil, Google Brasil. Possui certificações como Microsoft Certified: Azure Fundamentals, AWS Certified Solutions Architect, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, AWS Certified Solutions Architect, Google Cloud Professional Data Engineer'),(45,45,'Engenharia de Software','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como Redis, NoSQL, SQL em projetos realizados em empresas como Google Brasil. Possui certificações como Certified Kubernetes Administrator, Microsoft Certified: Azure Fundamentals, AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, Microsoft Certified: Azure Fundamentals, AWS Certified Solutions Architect'),(46,46,'Bacharelado em Ciência da Computação','2 anos como especialista em segurança da informação','Profissional com 2 anos como especialista em segurança da informação, aplicando tecnologias como Node.js, MySQL, Angular em projetos realizados em empresas como Embraer, PagSeguro. Possui certificações como Microsoft Certified: Azure Fundamentals, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals'),(47,47,'Bacharelado em Sistemas de Informação','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como Kubernetes, CSS, Docker em projetos realizados em empresas como IBM Brasil. Possui certificações como Certified Kubernetes Administrator, Google Cloud Professional Data Engineer, Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, Google Cloud Professional Data Engineer, Certified Information Systems Security Professional (CISSP)'),(48,48,'Engenharia de Software','6 anos como desenvolvedor full stack','Profissional com 6 anos como desenvolvedor full stack, aplicando tecnologias como Kubernetes, MongoDB, Java em projetos realizados em empresas como Amazon Brasil, Globo.com. Possui certificações como Google Cloud Professional Data Engineer, Oracle Certified Professional, Java SE, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer, Oracle Certified Professional, Java SE, Certified Kubernetes Administrator'),(49,49,'Bacharelado em Sistemas de Informação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como Python, Google Cloud, Vue.js em projetos realizados em empresas como IBM Brasil, Vale. Possui certificações como AWS Certified Solutions Architect, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Google Cloud Professional Data Engineer'),(51,51,'Tecnólogo em Análise e Desenvolvimento de Sistemas','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como PostgreSQL, HTML, Node.js em projetos realizados em empresas como Vale. Possui certificações como Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP)'),(52,52,'Bacharelado em Ciência da Computação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como JavaScript, AWS, C# em projetos realizados em empresas como PagSeguro, Google Brasil. Possui certificações como Microsoft Certified: Azure Fundamentals, Google Cloud Professional Data Engineer, Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Google Cloud Professional Data Engineer, Oracle Certified Professional, Java SE'),(53,53,'Engenharia da Computação','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como Hadoop, C#, Spark em projetos realizados em empresas como PagSeguro, Globo.com. Possui certificações como Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE'),(54,54,'Bacharelado em Ciência da Computação','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como Redis, C#, Angular em projetos realizados em empresas como IBM Brasil, Nubank. Possui certificações como Oracle Certified Professional, Java SE, AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Oracle Certified Professional, Java SE, AWS Certified Solutions Architect'),(55,55,'Tecnólogo em Análise e Desenvolvimento de Sistemas','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como PyTorch, SQL, Google Cloud em projetos realizados em empresas como Embraer. Possui certificações como Google Cloud Professional Data Engineer, Microsoft Certified: Azure Fundamentals, Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer, Microsoft Certified: Azure Fundamentals, Oracle Certified Professional, Java SE'),(57,57,'Tecnólogo em Análise e Desenvolvimento de Sistemas','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como PostgreSQL, Redis, Google Cloud em projetos realizados em empresas como Mercado Livre, Vale. Possui certificações como Oracle Certified Professional, Java SE, Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Oracle Certified Professional, Java SE, Certified Kubernetes Administrator'),(58,58,'Bacharelado em Sistemas de Informação','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como Docker, Redis, CSS em projetos realizados em empresas como Petrobras. Possui certificações como Scrum Master Certified, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Scrum Master Certified, Google Cloud Professional Data Engineer'),(60,60,'Engenharia de Software','5 anos como engenheiro de dados','Profissional com 5 anos como engenheiro de dados, aplicando tecnologias como AWS, Azure, Spark em projetos realizados em empresas como Microsoft Brasil, Petrobras. Possui certificações como Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP), Oracle Certified Professional, Java SE'),(62,62,'Bacharelado em Ciência da Computação','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como Python, MongoDB, NoSQL em projetos realizados em empresas como Globo.com. Possui certificações como Microsoft Certified: Azure Fundamentals, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Google Cloud Professional Data Engineer'),(65,65,'Engenharia da Computação','3 anos como desenvolvedor backend','Profissional com 3 anos como desenvolvedor backend, aplicando tecnologias como PostgreSQL, TensorFlow, Azure em projetos realizados em empresas como Mercado Livre, Petrobras. Possui certificações como Certified Kubernetes Administrator, AWS Certified Solutions Architect, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, AWS Certified Solutions Architect, Google Cloud Professional Data Engineer'),(69,69,'Engenharia da Computação','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como CSS, TensorFlow, Kubernetes em projetos realizados em empresas como Petrobras, Vale. Possui certificações como AWS Certified Solutions Architect, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Google Cloud Professional Data Engineer'),(70,70,'Bacharelado em Ciência da Computação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como PyTorch, Azure, AWS em projetos realizados em empresas como Embraer, TOTVS. Possui certificações como AWS Certified Solutions Architect, Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Oracle Certified Professional, Java SE'),(71,71,'Tecnólogo em Análise e Desenvolvimento de Sistemas','2 anos como especialista em segurança da informação','Profissional com 2 anos como especialista em segurança da informação, aplicando tecnologias como PostgreSQL, MongoDB, AWS em projetos realizados em empresas como Vale, Amazon Brasil. Possui certificações como AWS Certified Solutions Architect, Certified Kubernetes Administrator, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','AWS Certified Solutions Architect, Certified Kubernetes Administrator, Google Cloud Professional Data Engineer'),(74,74,'Engenharia da Computação','6 anos como desenvolvedor full stack','Profissional com 6 anos como desenvolvedor full stack, aplicando tecnologias como NoSQL, Google Cloud, Spark em projetos realizados em empresas como Vale, Nubank. Possui certificações como Microsoft Certified: Azure Fundamentals, Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Google Cloud Professional Data Engineer'),(77,77,'Bacharelado em Sistemas de Informação','4 anos como administrador de banco de dados','Profissional com 4 anos como administrador de banco de dados, aplicando tecnologias como Hadoop, Docker, Angular em projetos realizados em empresas como Amazon Brasil. Possui certificações como Google Cloud Professional Data Engineer, Scrum Master Certified, Microsoft Certified: Azure Fundamentals, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer, Scrum Master Certified, Microsoft Certified: Azure Fundamentals'),(80,80,'Bacharelado em Sistemas de Informação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como Kubernetes, Hadoop, Azure em projetos realizados em empresas como Google Brasil, Nubank. Possui certificações como Certified Kubernetes Administrator, Microsoft Certified: Azure Fundamentals, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, Microsoft Certified: Azure Fundamentals'),(81,81,'Bacharelado em Sistemas de Informação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como MongoDB, Node.js, NoSQL em projetos realizados em empresas como Nubank, Amazon Brasil. Possui certificações como Certified Kubernetes Administrator, Scrum Master Certified, AWS Certified Solutions Architect, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Kubernetes Administrator, Scrum Master Certified, AWS Certified Solutions Architect'),(83,83,'Engenharia da Computação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como HTML, Google Cloud, PostgreSQL em projetos realizados em empresas como IBM Brasil. Possui certificações como Microsoft Certified: Azure Fundamentals, Certified Information Systems Security Professional (CISSP), Certified Kubernetes Administrator, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Certified Information Systems Security Professional (CISSP), Certified Kubernetes Administrator'),(86,86,'Engenharia da Computação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como Angular, Vue.js, Python em projetos realizados em empresas como Vale. Possui certificações como Google Cloud Professional Data Engineer, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer'),(90,90,'Bacharelado em Sistemas de Informação','2 anos como engenheiro de software','Profissional com 2 anos como engenheiro de software, aplicando tecnologias como MongoDB, Java, MySQL em projetos realizados em empresas como Nubank. Possui certificações como Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP)'),(93,93,'Engenharia de Software','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como React, Kubernetes, Node.js em projetos realizados em empresas como Globo.com, Nubank. Possui certificações como Google Cloud Professional Data Engineer, Certified Kubernetes Administrator, Oracle Certified Professional, Java SE, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Google Cloud Professional Data Engineer, Certified Kubernetes Administrator, Oracle Certified Professional, Java SE'),(94,94,'Bacharelado em Sistemas de Informação','5 anos como analista de dados','Profissional com 5 anos como analista de dados, aplicando tecnologias como JavaScript, Python, PostgreSQL em projetos realizados em empresas como Vale, TOTVS. Possui certificações como Microsoft Certified: Azure Fundamentals, Scrum Master Certified, destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Microsoft Certified: Azure Fundamentals, Scrum Master Certified'),(99,99,'Engenharia da Computação','3 anos como cientista de dados','Profissional com 3 anos como cientista de dados, aplicando tecnologias como SQL, Node.js, Java em projetos realizados em empresas como IBM Brasil, Embraer. Possui certificações como Certified Information Systems Security Professional (CISSP), destacando-se pela capacidade de entregar soluções inovadoras e eficientes alinhadas às necessidades do negócio.','Certified Information Systems Security Professional (CISSP)');
/*!40000 ALTER TABLE `curriculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculo_habilidade`
--

DROP TABLE IF EXISTS `curriculo_habilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curriculo_habilidade` (
  `id_curriculo` int NOT NULL,
  `id_habilidade` int NOT NULL,
  PRIMARY KEY (`id_curriculo`,`id_habilidade`),
  KEY `id_habilidade` (`id_habilidade`),
  CONSTRAINT `curriculo_habilidade_ibfk_1` FOREIGN KEY (`id_curriculo`) REFERENCES `curriculo` (`id_curriculo`),
  CONSTRAINT `curriculo_habilidade_ibfk_2` FOREIGN KEY (`id_habilidade`) REFERENCES `habilidade` (`id_habilidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculo_habilidade`
--

LOCK TABLES `curriculo_habilidade` WRITE;
/*!40000 ALTER TABLE `curriculo_habilidade` DISABLE KEYS */;
INSERT INTO `curriculo_habilidade` VALUES (2,1),(4,1),(6,1),(7,1),(11,1),(12,1),(14,1),(17,1),(18,1),(24,1),(27,1),(29,1),(32,1),(33,1),(35,1),(43,1),(46,1),(49,1),(51,1),(52,1),(60,1),(70,1),(71,1),(81,1),(86,1),(1,2),(4,2),(6,2),(7,2),(9,2),(11,2),(12,2),(15,2),(16,2),(17,2),(22,2),(23,2),(27,2),(28,2),(32,2),(33,2),(39,2),(40,2),(46,2),(48,2),(49,2),(51,2),(53,2),(57,2),(58,2),(62,2),(77,2),(83,2),(86,2),(90,2),(94,2),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(11,4),(14,4),(15,4),(16,4),(17,4),(18,4),(23,4),(25,4),(27,4),(32,4),(38,4),(43,4),(54,4),(62,4),(70,4),(81,4),(93,4),(1,6),(3,6),(7,6),(11,6),(14,6),(28,6),(29,6),(31,6),(35,6),(38,6),(39,6),(43,6),(45,6),(52,6),(62,6),(74,6),(81,6),(1,7),(2,7),(3,7),(5,7),(8,7),(11,7),(16,7),(17,7),(18,7),(20,7),(27,7),(38,7),(39,7),(42,7),(48,7),(55,7),(58,7),(60,7),(74,7),(81,7),(90,7),(99,7),(1,8),(2,8),(3,8),(4,8),(5,8),(6,8),(8,8),(12,8),(13,8),(15,8),(17,8),(20,8),(22,8),(23,8),(25,8),(27,8),(29,8),(42,8),(43,8),(49,8),(52,8),(57,8),(58,8),(60,8),(62,8),(65,8),(74,8),(94,8),(1,9),(2,9),(6,9),(7,9),(8,9),(9,9),(11,9),(14,9),(15,9),(17,9),(18,9),(25,9),(33,9),(36,9),(38,9),(40,9),(46,9),(47,9),(51,9),(54,9),(55,9),(58,9),(77,9),(83,9),(1,13),(2,13),(3,13),(6,13),(7,13),(8,13),(11,13),(14,13),(24,13),(35,13),(38,13),(39,13),(42,13),(45,13),(46,13),(48,13),(55,13),(57,13),(58,13),(69,13),(70,13),(94,13),(99,13),(1,15),(4,15),(6,15),(7,15),(8,15),(11,15),(14,15),(18,15),(20,15),(22,15),(24,15),(25,15),(27,15),(29,15),(31,15),(35,15),(36,15),(39,15),(42,15),(51,15),(53,15),(54,15),(60,15),(74,15),(99,15),(1,16),(2,16),(4,16),(6,16),(8,16),(11,16),(17,16),(20,16),(22,16),(23,16),(33,16),(36,16),(46,16),(47,16),(52,16),(58,16),(65,16),(77,16),(90,16),(1,17),(2,17),(4,17),(11,17),(17,17),(20,17),(22,17),(28,17),(32,17),(33,17),(38,17),(45,17),(51,17),(52,17),(60,17),(65,17),(70,17),(74,17),(77,17),(80,17),(81,17),(3,20),(4,20),(9,20),(11,20),(12,20),(13,20),(18,20),(24,20),(27,20),(35,20),(38,20),(43,20),(53,20),(54,20),(57,20),(70,20),(77,20),(80,20),(81,20),(1,21),(2,21),(3,21),(4,21),(5,21),(6,21),(16,21),(17,21),(18,21),(24,21),(29,21),(32,21),(33,21),(43,21),(46,21),(51,21),(52,21),(57,21),(58,21),(74,21),(81,21),(93,21),(99,21),(2,22),(4,22),(6,22),(7,22),(9,22),(11,22),(13,22),(15,22),(16,22),(17,22),(24,22),(29,22),(31,22),(38,22),(43,22),(47,22),(48,22),(57,22),(69,22),(80,22),(81,22),(93,22),(2,23),(3,23),(7,23),(11,23),(20,23),(23,23),(25,23),(30,23),(32,23),(38,23),(43,23),(47,23),(51,23),(54,23),(58,23),(69,23),(77,23),(81,23),(83,23),(93,23),(99,23),(1,24),(2,24),(3,24),(7,24),(9,24),(12,24),(16,24),(17,24),(23,24),(27,24),(29,24),(33,24),(35,24),(39,24),(47,24),(51,24),(54,24),(57,24),(65,24),(71,24),(80,24),(81,24),(83,24),(94,24),(1,25),(2,25),(4,25),(6,25),(7,25),(11,25),(12,25),(13,25),(17,25),(20,25),(22,25),(23,25),(24,25),(25,25),(27,25),(30,25),(32,25),(35,25),(38,25),(40,25),(43,25),(45,25),(48,25),(54,25),(57,25),(62,25),(65,25),(69,25),(71,25),(81,25),(90,25),(2,26),(3,26),(13,26),(14,26),(17,26),(22,26),(29,26),(31,26),(32,26),(38,26),(42,26),(58,26),(62,26),(65,26),(69,26),(81,26),(93,26),(1,27),(3,27),(4,27),(6,27),(13,27),(14,27),(15,27),(22,27),(23,27),(32,27),(35,27),(38,27),(48,27),(49,27),(54,27),(55,27),(57,27),(60,27),(70,27),(71,27),(74,27),(83,27),(93,27),(2,28),(3,28),(6,28),(9,28),(11,28),(13,28),(15,28),(25,28),(30,28),(32,28),(35,28),(38,28),(46,28),(48,28),(49,28),(51,28),(55,28),(57,28),(58,28),(81,28),(86,28),(90,28),(2,29),(4,29),(7,29),(9,29),(16,29),(17,29),(23,29),(25,29),(29,29),(32,29),(39,29),(45,29),(49,29),(51,29),(53,29),(55,29),(58,29),(60,29),(86,29),(2,30),(3,30),(4,30),(5,30),(7,30),(16,30),(20,30),(23,30),(24,30),(28,30),(29,30),(31,30),(35,30),(36,30),(38,30),(40,30),(46,30),(54,30),(57,30),(74,30),(77,30),(86,30),(1,31),(2,31),(3,31),(5,31),(7,31),(11,31),(14,31),(15,31),(25,31),(27,31),(29,31),(30,31),(33,31),(36,31),(40,31),(45,31),(54,31),(57,31),(58,31),(69,31),(80,31),(81,31),(94,31),(2,32),(5,32),(14,32),(15,32),(20,32),(23,32),(25,32),(27,32),(29,32),(30,32),(51,32),(52,32),(53,32),(54,32),(57,32),(58,32),(71,32),(81,32),(83,32),(90,32),(1,33),(2,33),(3,33),(4,33),(13,33),(14,33),(17,33),(27,33),(28,33),(29,33),(32,33),(38,33),(43,33),(55,33),(69,33),(70,33),(77,33),(81,33),(90,33),(93,33),(99,33);
/*!40000 ALTER TABLE `curriculo_habilidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculo_idioma`
--

DROP TABLE IF EXISTS `curriculo_idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curriculo_idioma` (
  `id_curriculo` int NOT NULL,
  `id_idioma` int NOT NULL,
  PRIMARY KEY (`id_curriculo`,`id_idioma`),
  KEY `id_idioma` (`id_idioma`),
  CONSTRAINT `curriculo_idioma_ibfk_1` FOREIGN KEY (`id_curriculo`) REFERENCES `curriculo` (`id_curriculo`),
  CONSTRAINT `curriculo_idioma_ibfk_2` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id_idioma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculo_idioma`
--

LOCK TABLES `curriculo_idioma` WRITE;
/*!40000 ALTER TABLE `curriculo_idioma` DISABLE KEYS */;
INSERT INTO `curriculo_idioma` VALUES (1,1),(2,1),(6,1),(7,1),(9,1),(11,1),(14,1),(15,1),(16,1),(18,1),(22,1),(23,1),(28,1),(29,1),(31,1),(35,1),(38,1),(49,1),(53,1),(54,1),(57,1),(60,1),(71,1),(74,1),(77,1),(80,1),(81,1),(83,1),(1,2),(2,2),(3,2),(4,2),(6,2),(7,2),(8,2),(11,2),(12,2),(14,2),(15,2),(20,2),(22,2),(23,2),(24,2),(27,2),(28,2),(32,2),(38,2),(42,2),(45,2),(46,2),(48,2),(51,2),(53,2),(57,2),(58,2),(62,2),(65,2),(70,2),(71,2),(77,2),(81,2),(86,2),(90,2),(2,3),(3,3),(4,3),(6,3),(9,3),(12,3),(13,3),(14,3),(15,3),(20,3),(23,3),(25,3),(27,3),(28,3),(31,3),(33,3),(39,3),(43,3),(46,3),(47,3),(51,3),(53,3),(54,3),(55,3),(57,3),(58,3),(60,3),(69,3),(70,3),(71,3),(77,3),(81,3),(86,3),(90,3),(94,3),(99,3),(4,4),(5,4),(6,4),(11,4),(12,4),(14,4),(15,4),(16,4),(17,4),(23,4),(24,4),(25,4),(32,4),(38,4),(39,4),(40,4),(43,4),(45,4),(49,4),(52,4),(54,4),(55,4),(57,4),(65,4),(81,4),(99,4),(1,5),(2,5),(3,5),(4,5),(6,5),(7,5),(11,5),(15,5),(16,5),(17,5),(20,5),(25,5),(27,5),(29,5),(30,5),(31,5),(32,5),(33,5),(35,5),(36,5),(38,5),(39,5),(42,5),(43,5),(46,5),(49,5),(51,5),(52,5),(54,5),(55,5),(58,5),(81,5),(86,5),(90,5),(93,5);
/*!40000 ALTER TABLE `curriculo_idioma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empregador`
--

DROP TABLE IF EXISTS `empregador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empregador` (
  `id_empregador` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id_empregador`),
  UNIQUE KEY `email` (`email`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `empregador_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empregador`
--

LOCK TABLES `empregador` WRITE;
/*!40000 ALTER TABLE `empregador` DISABLE KEYS */;
/*!40000 ALTER TABLE `empregador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (16,'Amazon Brasil'),(7,'Azevedo'),(27,'Campos Costa - EI'),(4,'Campos S.A.'),(3,'Cavalcanti'),(13,'Costela Ltda.'),(6,'da Paz Ramos S/A'),(12,'Duarte Silveira Ltda.'),(25,'Embraer'),(22,'Ferreira'),(19,'Globo.com'),(26,'Gomes'),(20,'Google Brasil'),(14,'IBM Brasil'),(17,'Itaú Unibanco'),(28,'Lopes S/A'),(23,'Mercado Livre'),(18,'Microsoft Brasil'),(10,'Nogueira'),(9,'Peixoto'),(21,'Petrobras'),(11,'Porto - ME'),(5,'Ramos - ME'),(8,'Ramos Araújo - EI'),(15,'TOTVS'),(2,'Unesp'),(24,'Vale'),(1,'Whirpool');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habilidade`
--

DROP TABLE IF EXISTS `habilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habilidade` (
  `id_habilidade` int NOT NULL AUTO_INCREMENT,
  `nome_habilidade` varchar(100) NOT NULL,
  PRIMARY KEY (`id_habilidade`),
  UNIQUE KEY `nome_habilidade` (`nome_habilidade`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidade`
--

LOCK TABLES `habilidade` WRITE;
/*!40000 ALTER TABLE `habilidade` DISABLE KEYS */;
INSERT INTO `habilidade` VALUES (30,'Angular'),(1,'AWS'),(17,'Azure'),(32,'C#'),(5,'CI/CD'),(23,'CSS'),(16,'Docker'),(18,'GCP'),(14,'Git'),(27,'Google Cloud'),(20,'Hadoop'),(9,'HTML'),(7,'Java'),(8,'JavaScript'),(10,'Kanban'),(22,'Kubernetes'),(19,'Linux'),(25,'MongoDB'),(28,'MySQL'),(21,'Node.js'),(6,'NoSQL'),(24,'PostgreSQL'),(12,'Power BI'),(2,'Python'),(33,'PyTorch'),(4,'React'),(31,'Redis'),(3,'Scrum'),(15,'Spark'),(13,'SQL'),(11,'Tableau'),(26,'TensorFlow'),(29,'Vue.js');
/*!40000 ALTER TABLE `habilidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idioma`
--

DROP TABLE IF EXISTS `idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idioma` (
  `id_idioma` int NOT NULL AUTO_INCREMENT,
  `nome_idioma` varchar(100) NOT NULL,
  PRIMARY KEY (`id_idioma`),
  UNIQUE KEY `nome_idioma` (`nome_idioma`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idioma`
--

LOCK TABLES `idioma` WRITE;
/*!40000 ALTER TABLE `idioma` DISABLE KEYS */;
INSERT INTO `idioma` VALUES (5,'Alemão'),(4,'Espanhol'),(3,'Francês'),(1,'Inglês'),(2,'Português');
/*!40000 ALTER TABLE `idioma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rede_contatos`
--

DROP TABLE IF EXISTS `rede_contatos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rede_contatos` (
  `id_candidato_origem` int NOT NULL,
  `id_candidato_contato` int NOT NULL,
  PRIMARY KEY (`id_candidato_origem`,`id_candidato_contato`),
  KEY `id_candidato_contato` (`id_candidato_contato`),
  CONSTRAINT `rede_contatos_ibfk_1` FOREIGN KEY (`id_candidato_origem`) REFERENCES `candidato` (`id_candidato`),
  CONSTRAINT `rede_contatos_ibfk_2` FOREIGN KEY (`id_candidato_contato`) REFERENCES `candidato` (`id_candidato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rede_contatos`
--

LOCK TABLES `rede_contatos` WRITE;
/*!40000 ALTER TABLE `rede_contatos` DISABLE KEYS */;
INSERT INTO `rede_contatos` VALUES (6,1),(17,1),(35,1),(38,1),(39,1),(49,1),(51,1),(57,1),(74,1),(77,1),(81,1),(1,2),(4,2),(8,2),(17,2),(33,2),(36,2),(38,2),(47,2),(58,2),(80,2),(86,2),(7,3),(9,3),(15,3),(17,3),(18,3),(27,3),(45,3),(49,3),(69,3),(81,3),(1,4),(6,4),(7,4),(13,4),(17,4),(45,4),(51,4),(71,4),(81,4),(6,5),(14,5),(15,5),(17,5),(49,5),(51,5),(53,5),(57,5),(2,6),(3,6),(11,6),(17,6),(25,6),(33,6),(43,6),(49,6),(55,6),(60,6),(2,7),(16,7),(17,7),(39,7),(93,7),(1,8),(3,8),(12,8),(22,8),(23,8),(27,8),(30,8),(33,8),(53,8),(60,8),(62,8),(83,8),(99,8),(1,9),(2,9),(11,9),(17,9),(22,9),(38,9),(40,9),(57,9),(58,9),(1,11),(2,11),(3,11),(5,11),(7,11),(39,11),(48,11),(62,11),(70,11),(1,12),(3,12),(4,12),(7,12),(17,12),(27,12),(31,12),(35,12),(51,12),(58,12),(77,12),(1,13),(2,13),(7,13),(17,13),(20,13),(27,13),(30,13),(35,13),(38,13),(2,14),(3,14),(4,14),(6,14),(7,14),(9,14),(11,14),(27,14),(32,14),(46,14),(55,14),(58,14),(81,14),(86,14),(2,15),(7,15),(11,15),(14,15),(18,15),(22,15),(31,15),(32,15),(45,15),(46,15),(70,15),(81,15),(90,15),(2,16),(3,16),(5,16),(27,16),(39,16),(47,16),(54,16),(58,16),(11,17),(36,17),(38,17),(51,17),(58,17),(2,18),(4,18),(9,18),(11,18),(14,18),(17,18),(20,18),(45,18),(51,18),(74,18),(3,20),(7,20),(15,20),(17,20),(27,20),(46,20),(60,20),(81,20),(2,22),(3,22),(4,22),(38,22),(46,22),(54,22),(65,22),(93,22),(94,22),(99,22),(1,23),(4,23),(7,23),(13,23),(33,23),(39,23),(42,23),(43,23),(77,23),(90,23),(1,24),(7,24),(9,24),(14,24),(20,24),(22,24),(32,24),(38,24),(53,24),(70,24),(77,24),(94,24),(2,25),(3,25),(5,25),(7,25),(14,25),(15,25),(17,25),(22,25),(36,25),(43,25),(46,25),(53,25),(54,25),(65,25),(69,25),(70,25),(74,25),(1,27),(4,27),(7,27),(49,27),(57,27),(62,27),(81,27),(6,28),(15,28),(16,28),(17,28),(23,28),(24,28),(25,28),(27,28),(33,28),(39,28),(57,28),(70,28),(83,28),(90,28),(1,29),(2,29),(6,29),(16,29),(17,29),(33,29),(93,29),(6,30),(11,30),(16,30),(17,30),(27,30),(29,30),(38,30),(42,30),(43,30),(45,30),(74,30),(93,30),(4,31),(7,31),(11,31),(14,31),(20,31),(24,31),(25,31),(35,31),(38,31),(42,31),(55,31),(1,32),(4,32),(7,32),(9,32),(13,32),(29,32),(38,32),(45,32),(47,32),(54,32),(1,33),(11,33),(12,33),(13,33),(15,33),(30,33),(38,33),(51,33),(57,33),(62,33),(69,33),(77,33),(90,33),(6,35),(15,35),(17,35),(20,35),(29,35),(33,35),(43,35),(48,35),(51,35),(90,35),(93,35),(6,36),(15,36),(16,36),(20,36),(27,36),(35,36),(38,36),(47,36),(52,36),(57,36),(58,36),(81,36),(94,36),(6,38),(7,38),(14,38),(20,38),(27,38),(29,38),(40,38),(42,38),(43,38),(51,38),(58,38),(2,39),(6,39),(20,39),(24,39),(25,39),(38,39),(43,39),(51,39),(53,39),(71,39),(1,40),(17,40),(24,40),(27,40),(30,40),(32,40),(42,40),(43,40),(51,40),(57,40),(58,40),(74,40),(86,40),(1,42),(2,42),(7,42),(20,42),(22,42),(27,42),(35,42),(36,42),(54,42),(57,42),(74,42),(80,42),(81,42),(4,43),(11,43),(27,43),(29,43),(36,43),(47,43),(54,43),(57,43),(77,43),(7,45),(11,45),(14,45),(20,45),(27,45),(29,45),(31,45),(33,45),(35,45),(38,45),(46,45),(58,45),(1,46),(5,46),(11,46),(13,46),(16,46),(17,46),(18,46),(27,46),(31,46),(38,46),(42,46),(43,46),(52,46),(90,46),(93,46),(5,47),(6,47),(7,47),(14,47),(15,47),(20,47),(31,47),(33,47),(45,47),(49,47),(57,47),(58,47),(99,47),(2,48),(24,48),(25,48),(46,48),(58,48),(71,48),(17,49),(46,49),(57,49),(74,49),(90,49),(2,51),(13,51),(14,51),(43,51),(45,51),(81,51),(93,51),(7,52),(11,52),(12,52),(15,52),(17,52),(25,52),(33,52),(35,52),(38,52),(48,52),(55,52),(58,52),(60,52),(65,52),(74,52),(1,53),(4,53),(7,53),(12,53),(17,53),(20,53),(30,53),(35,53),(49,53),(55,53),(60,53),(65,53),(69,53),(90,53),(1,54),(3,54),(12,54),(17,54),(20,54),(35,54),(55,54),(58,54),(77,54),(81,54),(4,55),(11,55),(13,55),(18,55),(24,55),(25,55),(38,55),(39,55),(57,55),(69,55),(81,55),(94,55),(99,55),(3,57),(4,57),(11,57),(12,57),(14,57),(15,57),(17,57),(29,57),(32,57),(38,57),(48,57),(51,57),(53,57),(60,57),(62,57),(70,57),(93,57),(1,58),(5,58),(7,58),(24,58),(27,58),(35,58),(39,58),(51,58),(53,58),(65,58),(93,58),(94,58),(1,60),(2,60),(7,60),(15,60),(27,60),(28,60),(36,60),(38,60),(42,60),(48,60),(51,60),(70,60),(94,60),(3,62),(4,62),(32,62),(35,62),(38,62),(39,62),(45,62),(52,62),(53,62),(55,62),(58,62),(65,62),(69,62),(71,62),(74,62),(17,65),(36,65),(54,65),(86,65),(1,69),(2,69),(4,69),(5,69),(13,69),(14,69),(16,69),(17,69),(23,69),(24,69),(29,69),(39,69),(43,69),(57,69),(58,69),(74,69),(94,69),(1,70),(7,70),(8,70),(9,70),(23,70),(31,70),(32,70),(42,70),(51,70),(54,70),(58,70),(69,70),(1,71),(2,71),(3,71),(5,71),(8,71),(9,71),(15,71),(16,71),(17,71),(24,71),(25,71),(30,71),(33,71),(35,71),(38,71),(45,71),(49,71),(55,71),(13,74),(17,74),(27,74),(28,74),(31,74),(33,74),(36,74),(38,74),(55,74),(77,74),(13,77),(29,77),(36,77),(81,77),(94,77),(1,80),(8,80),(11,80),(27,80),(31,80),(55,80),(65,80),(83,80),(93,80),(2,81),(6,81),(13,81),(17,81),(39,81),(45,81),(47,81),(57,81),(58,81),(70,81),(2,83),(11,83),(14,83),(18,83),(22,83),(31,83),(52,83),(53,83),(54,83),(70,83),(1,86),(11,86),(12,86),(13,86),(17,86),(23,86),(25,86),(27,86),(28,86),(29,86),(36,86),(39,86),(51,86),(70,86),(81,86),(2,90),(3,90),(16,90),(17,90),(27,90),(43,90),(48,90),(51,90),(54,90),(55,90),(2,93),(3,93),(17,93),(25,93),(33,93),(38,93),(47,93),(53,93),(65,93),(69,93),(70,93),(1,94),(2,94),(4,94),(15,94),(17,94),(23,94),(25,94),(30,94),(31,94),(32,94),(43,94),(47,94),(74,94),(81,94),(99,94),(2,99),(36,99),(38,99),(39,99),(46,99),(90,99);
/*!40000 ALTER TABLE `rede_contatos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaga`
--

DROP TABLE IF EXISTS `vaga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaga` (
  `id_vaga` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text,
  `cidade` varchar(100) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `tipo_contratacao` varchar(50) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_vaga`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `vaga_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaga`
--

LOCK TABLES `vaga` WRITE;
/*!40000 ALTER TABLE `vaga` DISABLE KEYS */;
INSERT INTO `vaga` VALUES (1,1,'Desenvolvedor Frontend','Conduzir projetos de ciência de dados, desde a coleta e limpeza até a modelagem e visualização.','Rio Claro','SP','CLT',9020.00),(2,2,'Scrum Master','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','São Paulo','CE','Estágio',3431.00),(3,3,'Administrador de Banco de Dados','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Florianópolis','SC','CLT',10362.00),(4,4,'Cientista de Dados','Prestar suporte técnico a usuários, solucionando problemas de hardware e software.','Recife','PE','Estágio',14653.00),(5,5,'Desenvolvedor Fullstack','Projetar e treinar modelos de machine learning para resolver problemas complexos de negócio.','Florianópolis','SC','Temporário',5740.00),(6,6,'Especialista em Redes','Prestar suporte técnico a usuários, solucionando problemas de hardware e software.','Curitiba','PR','PJ',7875.00),(7,7,'Infra TI','Desenvolver soluções em nuvem utilizando AWS, Azure ou GCP, garantindo escalabilidade e confiabilidade.','Salvador','BA','Temporário',11742.00),(8,8,'Desenvolvedor Fullstack','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Brasília','DF','Estágio',12515.00),(9,9,'Desenvolvedor Backend','Coordenar equipes de desenvolvimento, assegurando a entrega de projetos no prazo e orçamento.','Rio de Janeiro','RJ','Estágio',6835.00),(10,10,'Arquiteto de Soluções','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Florianópolis','SC','PJ',3493.00),(11,11,'Especialista em Cloud Computing','Coordenar equipes de desenvolvimento, assegurando a entrega de projetos no prazo e orçamento.','Florianópolis','SC','Temporário',10707.00),(12,12,'Cientista de Dados','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Fortaleza','CE','Temporário',4106.00),(13,13,'Cientista de Dados','Desenvolver soluções em nuvem utilizando AWS, Azure ou GCP, garantindo escalabilidade e confiabilidade.','Curitiba','PR','Temporário',8034.00),(14,14,'Engenheiro DevOps','Responsável por desenvolver e manter aplicações escaláveis, garantindo alta performance e segurança.','Porto Alegre','RS','Estágio',11255.00),(15,14,'Designer de UX/UI','Projetar e treinar modelos de machine learning para resolver problemas complexos de negócio.','Florianópolis','SC','PJ',8110.00),(16,15,'Arquiteto de Soluções','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Recife','PE','Temporário',10633.00),(17,14,'Analista de Sistemas','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Salvador','BA','Estágio',9535.00),(18,14,'Product Owner','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Salvador','BA','PJ',8160.00),(19,1,'Engenheiro DevOps','Desenvolver soluções em nuvem utilizando AWS, Azure ou GCP, garantindo escalabilidade e confiabilidade.','Rio Claro','CE','CLT',7634.00),(20,15,'Designer de UX/UI','Atuar na análise, modelagem e otimização de processos de dados, criando pipelines eficientes.','Fortaleza','CE','Temporário',4757.00),(21,14,'Administrador de Banco de Dados','Atuar na análise, modelagem e otimização de processos de dados, criando pipelines eficientes.','Porto Alegre','RS','Temporário',3599.00),(22,15,'Especialista em Redes','Desenvolver soluções em nuvem utilizando AWS, Azure ou GCP, garantindo escalabilidade e confiabilidade.','Fortaleza','CE','Estágio',8036.00),(23,15,'Engenheiro de Machine Learning','Coordenar equipes de desenvolvimento, assegurando a entrega de projetos no prazo e orçamento.','Florianópolis','SC','PJ',11317.00),(24,16,'Desenvolvedor Backend','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Fortaleza','CE','Estágio',11004.00),(25,14,'Engenheiro DevOps','Desenvolver interfaces intuitivas e responsivas, focadas na melhor experiência do usuário.','Curitiba','PR','CLT',4181.00),(26,14,'Especialista em Cloud Computing','Prestar suporte técnico a usuários, solucionando problemas de hardware e software.','São Paulo','SP','Estágio',3145.00),(27,14,'Analista de BI','Desenvolver interfaces intuitivas e responsivas, focadas na melhor experiência do usuário.','Florianópolis','SC','Temporário',12205.00),(28,14,'Analista de Qualidade de Software','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Recife','PE','Estágio',6988.00),(29,17,'Arquiteto de Soluções','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Florianópolis','SC','PJ',12254.00),(30,18,'Infra TI','Projetar e treinar modelos de machine learning para resolver problemas complexos de negócio.','Belo Horizonte','MG','Temporário',9240.00),(31,19,'Engenheiro DevOps','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Florianópolis','SC','Estágio',14940.00),(32,20,'Arquiteto de Soluções','Atuar na análise, modelagem e otimização de processos de dados, criando pipelines eficientes.','Recife','PE','Temporário',12733.00),(33,21,'Arquiteto de Soluções','Desenvolver interfaces intuitivas e responsivas, focadas na melhor experiência do usuário.','Porto Alegre','RS','CLT',9882.00),(34,22,'Desenvolvedor Fullstack','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Rio de Janeiro','RJ','Temporário',8892.00),(35,14,'Administrador de Banco de Dados','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','São Paulo','SP','Temporário',7605.00),(36,15,'Desenvolvedor Backend','Responsável por desenvolver e manter aplicações escaláveis, garantindo alta performance e segurança.','Belo Horizonte','MG','PJ',3396.00),(37,21,'Especialista em Redes','Responsável por desenvolver e manter aplicações escaláveis, garantindo alta performance e segurança.','Recife','PE','Estágio',7866.00),(38,14,'Especialista em Redes','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','São Paulo','SP','Temporário',4913.00),(39,18,'Analista de Suporte Técnico','Administrar e otimizar bancos de dados relacionais e não relacionais, garantindo disponibilidade.','Porto Alegre','RS','Temporário',9016.00),(40,15,'Analista de BI','Coordenar equipes de desenvolvimento, assegurando a entrega de projetos no prazo e orçamento.','Belo Horizonte','MG','Estágio',4122.00),(41,16,'Desenvolvedor Backend','Projetar e treinar modelos de machine learning para resolver problemas complexos de negócio.','Rio de Janeiro','RJ','CLT',11319.00),(42,23,'Analista de BI','Conduzir projetos de ciência de dados, desde a coleta e limpeza até a modelagem e visualização.','Salvador','BA','Temporário',14391.00),(43,21,'Cientista de Dados','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Florianópolis','SC','PJ',14156.00),(44,19,'Engenheiro de Dados','Projetar e treinar modelos de machine learning para resolver problemas complexos de negócio.','Salvador','BA','CLT',9396.00),(45,19,'Engenheiro de Machine Learning','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Salvador','BA','CLT',11192.00),(46,24,'Analista de BI','Desenvolver soluções em nuvem utilizando AWS, Azure ou GCP, garantindo escalabilidade e confiabilidade.','São Paulo','SP','Estágio',13471.00),(47,25,'Especialista em Redes','Desenvolver soluções em nuvem utilizando AWS, Azure ou GCP, garantindo escalabilidade e confiabilidade.','Rio de Janeiro','RJ','Estágio',11234.00),(48,26,'Analista de Suporte Técnico','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Rio de Janeiro','RJ','PJ',12804.00),(49,27,'Engenheiro DevOps','Prestar suporte técnico a usuários, solucionando problemas de hardware e software.','Rio de Janeiro','RJ','PJ',4872.00),(50,28,'Analista de Segurança da Informação','Implementar e monitorar práticas de segurança da informação, mitigando riscos cibernéticos.','Florianópolis','SC','Temporário',10136.00);
/*!40000 ALTER TABLE `vaga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaga_habilidade`
--

DROP TABLE IF EXISTS `vaga_habilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaga_habilidade` (
  `id_vaga` int NOT NULL,
  `id_habilidade` int NOT NULL,
  PRIMARY KEY (`id_vaga`,`id_habilidade`),
  KEY `id_habilidade` (`id_habilidade`),
  CONSTRAINT `vaga_habilidade_ibfk_1` FOREIGN KEY (`id_vaga`) REFERENCES `vaga` (`id_vaga`),
  CONSTRAINT `vaga_habilidade_ibfk_2` FOREIGN KEY (`id_habilidade`) REFERENCES `habilidade` (`id_habilidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaga_habilidade`
--

LOCK TABLES `vaga_habilidade` WRITE;
/*!40000 ALTER TABLE `vaga_habilidade` DISABLE KEYS */;
INSERT INTO `vaga_habilidade` VALUES (1,1),(8,1),(13,1),(15,1),(18,1),(21,1),(29,1),(34,1),(39,1),(42,1),(46,1),(47,1),(48,1),(1,2),(5,2),(6,2),(16,2),(17,2),(18,2),(23,2),(28,2),(44,2),(45,2),(49,2),(1,3),(2,3),(3,3),(8,3),(10,3),(11,3),(16,3),(22,3),(36,3),(37,3),(38,3),(43,3),(44,3),(45,3),(2,4),(5,4),(15,4),(18,4),(21,4),(23,4),(33,4),(37,4),(43,4),(44,4),(46,4),(48,4),(2,5),(8,5),(13,5),(15,5),(30,5),(36,5),(40,5),(2,6),(3,6),(13,6),(17,6),(20,6),(27,6),(31,6),(49,6),(2,7),(15,7),(20,7),(28,7),(30,7),(32,7),(35,7),(40,7),(42,7),(44,7),(49,7),(3,8),(4,8),(11,8),(12,8),(20,8),(29,8),(31,8),(34,8),(42,8),(3,9),(5,9),(9,9),(17,9),(24,9),(25,9),(27,9),(38,9),(42,9),(45,9),(3,10),(13,10),(25,10),(35,10),(41,10),(3,11),(4,11),(9,11),(16,11),(23,11),(25,11),(37,11),(41,11),(43,11),(47,11),(4,12),(5,12),(6,12),(12,12),(17,12),(20,12),(26,12),(33,12),(39,12),(41,12),(5,13),(6,13),(8,13),(13,13),(15,13),(16,13),(17,13),(26,13),(35,13),(36,13),(41,13),(42,13),(46,13),(5,14),(10,14),(19,14),(26,14),(50,14),(6,15),(9,15),(18,15),(19,15),(20,15),(21,15),(25,15),(32,15),(36,15),(40,15),(50,15),(7,16),(8,16),(14,16),(18,16),(23,16),(29,16),(36,16),(39,16),(47,16),(49,16),(7,17),(10,17),(20,17),(22,17),(25,17),(30,17),(32,17),(37,17),(40,17),(43,17),(7,18),(9,18),(11,18),(17,18),(19,18),(29,18),(40,18),(48,18),(8,19),(13,19),(14,19),(27,19),(35,19),(43,19),(44,19),(47,19),(49,19),(50,19),(9,20),(11,20),(12,20),(19,20),(22,20),(24,20),(30,20),(33,20),(43,20),(49,20),(9,21),(12,21),(27,21),(28,21),(30,21),(34,21),(35,21),(38,21),(40,21),(41,21),(44,21),(50,21),(14,22),(24,22),(26,22),(30,22),(32,22),(34,22),(36,22),(39,22),(41,22),(18,23),(27,23),(31,23),(39,23);
/*!40000 ALTER TABLE `vaga_habilidade` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-27 19:55:24
