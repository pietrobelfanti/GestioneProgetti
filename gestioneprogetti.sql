-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.1.19-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win32
-- HeidiSQL Versione:            9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dump della struttura del database gestioneprogetti
CREATE DATABASE IF NOT EXISTS `gestioneprogetti` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gestioneprogetti`;


-- Dump della struttura di tabella gestioneprogetti.appartenenza
CREATE TABLE IF NOT EXISTS `appartenenza` (
  `id_appartenenza` int(11) NOT NULL AUTO_INCREMENT,
  `id_utente` int(11) NOT NULL,
  `id_team` int(11) NOT NULL,
  PRIMARY KEY (`id_appartenenza`),
  KEY `FK_appartenenza_utenti` (`id_utente`),
  KEY `FK_appartenenza_teams` (`id_team`),
  CONSTRAINT `FK_appartenenza_teams` FOREIGN KEY (`id_team`) REFERENCES `teams` (`id_team`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_appartenenza_utenti` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.appartenenza: ~0 rows (circa)
/*!40000 ALTER TABLE `appartenenza` DISABLE KEYS */;
/*!40000 ALTER TABLE `appartenenza` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.assegnamenti
CREATE TABLE IF NOT EXISTS `assegnamenti` (
  `id_assegnamento` int(11) NOT NULL AUTO_INCREMENT,
  `id_utente` int(11) NOT NULL,
  `id_progetto` int(11) NOT NULL,
  PRIMARY KEY (`id_assegnamento`),
  KEY `FK_assegnamenti_progetti` (`id_progetto`),
  KEY `FK_assegnamenti_utenti` (`id_utente`),
  CONSTRAINT `FK_assegnamenti_progetti` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id_progetto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_assegnamenti_utenti` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.assegnamenti: ~0 rows (circa)
/*!40000 ALTER TABLE `assegnamenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `assegnamenti` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.progetti
CREATE TABLE IF NOT EXISTS `progetti` (
  `id_progetto` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `datainizio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_team` int(11) NOT NULL,
  PRIMARY KEY (`id_progetto`),
  KEY `FK_progetti_teams` (`id_team`),
  CONSTRAINT `FK_progetti_teams` FOREIGN KEY (`id_team`) REFERENCES `teams` (`id_team`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.progetti: ~0 rows (circa)
/*!40000 ALTER TABLE `progetti` DISABLE KEYS */;
/*!40000 ALTER TABLE `progetti` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.richieste
CREATE TABLE IF NOT EXISTS `richieste` (
  `id_richiesta` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `accettata` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_richiesta`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.richieste: ~0 rows (circa)
/*!40000 ALTER TABLE `richieste` DISABLE KEYS */;
INSERT INTO `richieste` (`id_richiesta`, `username`, `accettata`) VALUES
	(8, 'userprova', NULL);
/*!40000 ALTER TABLE `richieste` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.svolgimento
CREATE TABLE IF NOT EXISTS `svolgimento` (
  `id_svolgimento` int(11) NOT NULL AUTO_INCREMENT,
  `id_utente` int(11) NOT NULL,
  `id_task` int(11) NOT NULL,
  PRIMARY KEY (`id_svolgimento`),
  KEY `FK_svolgimento_utenti` (`id_utente`),
  KEY `FK_svolgimento_tasks` (`id_task`),
  CONSTRAINT `FK_svolgimento_tasks` FOREIGN KEY (`id_task`) REFERENCES `tasks` (`id_task`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_svolgimento_utenti` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.svolgimento: ~0 rows (circa)
/*!40000 ALTER TABLE `svolgimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `svolgimento` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `id_task` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `priorità` int(11) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `%completamento` tinyint(4) NOT NULL,
  `inizio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fine` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_progetto` int(11) NOT NULL,
  PRIMARY KEY (`id_task`),
  KEY `FK__progetti` (`id_progetto`),
  CONSTRAINT `FK__progetti` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id_progetto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.tasks: ~0 rows (circa)
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.teams
CREATE TABLE IF NOT EXISTS `teams` (
  `id_team` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id_team`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.teams: ~0 rows (circa)
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` (`id_team`, `nome`) VALUES
	(1, 'samt');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;


-- Dump della struttura di tabella gestioneprogetti.utenti
CREATE TABLE IF NOT EXISTS `utenti` (
  `id_utente` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `amministratore` tinyint(1) NOT NULL DEFAULT '0',
  `amministratore_team` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_utente`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella gestioneprogetti.utenti: ~3 rows (circa)
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` (`id_utente`, `username`, `password`, `email`, `amministratore`, `amministratore_team`) VALUES
	(1, 'admin', '63a9f0ea7bb98050796b649e85481845', 'pietro.belfanti@gmail.com', 1, 1),
	(4, 'prova', '63a9f0ea7bb98050796b649e85481845', 'pietro.belfanti@samtrevano.ch', 0, 0),
	(5, 'userprova', '8a1e9a858bc15ae498c7aacc0114bc36', 'prova@1234.com', 0, 0);
/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
