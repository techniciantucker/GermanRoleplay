-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 31. Dez 2017 um 09:46
-- Server-Version: 10.1.16-MariaDB
-- PHP-Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `groleplay`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ban`
--

CREATE TABLE `ban` (
  `Name` varchar(50) NOT NULL,
  `Admin` varchar(50) NOT NULL,
  `Grund` varchar(50) NOT NULL,
  `Datum` varchar(50) NOT NULL,
  `IP` varchar(50) NOT NULL DEFAULT '0',
  `Serial` varchar(50) NOT NULL,
  `Eintragsdatum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `STime` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklist`
--

CREATE TABLE `blacklist` (
  `Name` varchar(50) NOT NULL DEFAULT '',
  `Eintraeger` varchar(50) NOT NULL DEFAULT '',
  `Fraktion` int(2) NOT NULL,
  `Eintragungsdatum` int(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blocks`
--

CREATE TABLE `blocks` (
  `Name` varchar(50) NOT NULL,
  `Punkte` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `carhouses_icons`
--

CREATE TABLE `carhouses_icons` (
  `Name` varchar(50) NOT NULL,
  `ID` int(3) NOT NULL,
  `X` double NOT NULL,
  `Y` double NOT NULL,
  `Z` double NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnRX` float NOT NULL,
  `SpawnRY` float NOT NULL,
  `SpawnRZ` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `carhouses_icons`
--

INSERT INTO `carhouses_icons` (`Name`, `ID`, `X`, `Y`, `Z`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnRX`, `SpawnRY`, `SpawnRZ`) VALUES
('Schrottautohaus', 2, -46.88184, -1141.83301, -34.6945, -82.2, -1121.6, 1.1, 0, 0, 91.5),
('Bike Shop', 3, 1174.67761, -1640.93469, -4.6361, 1159.3, -1646.7, 13.5, 0, 0, 90),
('Flugzeugladen', 1, 1798.16858, -1385.94543, -3.95049, 1420.3, -2593.6, 14.5, 0, 0, 270),
('Sportautohaus', 4, 1980.24792, -2083.86572, -54.25138, 1990.1, -2054.8, 13.5, 0, 0, 90);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `carhouses_vehicles`
--

CREATE TABLE `carhouses_vehicles` (
  `AutohausID` int(50) NOT NULL,
  `X` double NOT NULL,
  `Y` double NOT NULL,
  `Z` double NOT NULL,
  `RX` double NOT NULL,
  `RY` double NOT NULL,
  `RZ` double NOT NULL,
  `Preis` int(11) NOT NULL,
  `Typ` int(50) NOT NULL,
  `Info` varchar(50) NOT NULL,
  `Comment` varchar(999) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `carhouses_vehicles`
--

INSERT INTO `carhouses_vehicles` (`AutohausID`, `X`, `Y`, `Z`, `RX`, `RY`, `RZ`, `Preis`, `Typ`, `Info`, `Comment`) VALUES
(2, -64.7998046875, -1145.7001953125, 0.89999997615814, 0, 0, 0, 1250, 549, 'Auto', 'Wang Cars'),
(2, -67.7998046875, -1144.2001953125, 1.1000000238419, 0, 0, 0, 7500, 439, 'Auto', 'Wang Cars'),
(2, -70.900390625, -1142.599609375, 0.89999997615814, 0, 0, 0, 1500, 542, 'Auto', 'Wang Cars'),
(2, -74.099609375, -1141.099609375, 0.89999997615814, 0, 0, 0, 25000, 534, 'Auto', 'Wang Cars'),
(2, -77.2998046875, -1139.7998046875, 0.89999997615814, 0, 0, 0, 5000, 518, 'Auto', 'Wang Cars'),
(2, -80.7001953125, -1137.900390625, 1.1000000238419, 0, 0, 0, 25000, 567, 'Auto', 'Wang Cars'),
(2, -84.099609375, -1136.2998046875, 0.80000001192093, 0, 0, 0, 12000, 576, 'Auto', 'Wang Cars'),
(2, -87.5, -1135.099609375, 1.1000000238419, 0, 0, 0, 4000, 405, 'Auto', 'Wang Cars'),
(3, 1163.9000244141, -1635.9000244141, 14, 0, 0, 270, 32000, 522, 'Bike', 'Ottos Cars'),
(3, 1166.8000488281, -1634.5999755859, 14.39999961853, 0, 0, 270, 10000, 461, 'Bike', 'Ottos CArs'),
(3, 1169.0999755859, -1635.8000488281, 13.89999961853, 0, 0, 270, 10000, 463, 'Bike', 'Ottos Cars'),
(3, 1171.8000488281, -1634.8000488281, 14.5, 0, 0, 270, 25000, 468, 'Bike', 'Ottos Cars'),
(3, 1174.5, -1635.9000244141, 14, 0, 0, 270, 10000, 521, 'Bike', 'Ottos Cars'),
(3, 1177.1999511719, -1634.5999755859, 14.300000190735, 0, 0, 270, 12500, 586, 'Bike', 'Ottos Cars'),
(3, 1179.9000244141, -1635.9000244141, 13.89999961853, 0, 0, 270, 350, 462, 'Bike', 'Ottos Cars'),
(1, 1809.099609375, -1385, 29.5, 0, 0, 69.993896484375, 65000, 487, 'Flugobjekt', 'Flugzeugladen'),
(1, 1809.7998046875, -1374, 29.299999237061, 0, 0, 69.993896484375, 40000, 469, 'Flugobjekt', 'Flugzeugladen'),
(1, 1794.7001953125, -1359.5, 30, 0, 0, 180, 110000, 513, 'Flugobjekt', 'Flugzeugladen'),
(1, 1800.5, -1416, 30.200000762939, 0, 0, 0, 250000, 519, 'Flugobjekt', 'Flugzeugladen'),
(4, 1989.3000488281, -2074.5, 14.199999809265, 341, 0, 68.25, 55000, 411, 'Auto', 'Auto'),
(4, 1989.0999755859, -2081.5, 14.300000190735, 340.99914550781, 0, 68.2470703125, 40000, 415, 'Auto', 'Auto'),
(4, 1989.4000244141, -2088.5, 14.115013122559, 340.99914550781, 0, 68.2470703125, 45000, 541, 'Auto', 'Auto'),
(4, 1975.9000244141, -2074.3000488281, 14.199999809265, 340.99914550781, 0, 292, 35000, 560, 'Auto', 'Auto'),
(4, 1976.0999755859, -2081.6000976563, 14.182191431522, 340.99914550781, 0, 291.99462890625, 35000, 429, 'Auto', 'Auto'),
(4, 1976.1999511719, -2088.8000488281, 14.402826845646, 340.99914550781, 0, 292.74462890625, 30000, 402, 'Auto', 'Auto'),
(4, 1976.5999755859, -2095.6000976563, 14.350333213806, 340.99914550781, 0, 292.74169921875, 40000, 506, 'Auto', 'Auto');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `email`
--

CREATE TABLE `email` (
  `Empfaenger` varchar(50) NOT NULL,
  `Text` varchar(500) NOT NULL,
  `Yearday` int(11) NOT NULL,
  `Year` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fraktionen`
--

CREATE TABLE `fraktionen` (
  `FKasse` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ID` int(50) NOT NULL,
  `Name` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `fraktionen`
--

INSERT INTO `fraktionen` (`FKasse`, `ID`, `Name`) VALUES
('0', 4, 0),
('16000', 3, 0),
('17812.5', 9, 0),
('35000', 7, 0),
('40100', 2, 0),
('439696', 1, 0),
('50000', 5, 0),
('50000', 6, 0),
('50000', 8, 0),
('50002', 10, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gangs`
--

CREATE TABLE `gangs` (
  `X1` varchar(50) NOT NULL,
  `Y1` varchar(50) NOT NULL,
  `X2` varchar(50) NOT NULL,
  `Y2` varchar(50) NOT NULL,
  `X3` varchar(50) NOT NULL,
  `Y3` varchar(50) NOT NULL,
  `Z3` varchar(50) NOT NULL,
  `BesitzerFraktion` int(2) NOT NULL,
  `Einnahmen` int(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Nummer` int(2) NOT NULL,
  `LastAttacked` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `gangs`
--

INSERT INTO `gangs` (`X1`, `Y1`, `X2`, `Y2`, `X3`, `Y3`, `Z3`, `BesitzerFraktion`, `Einnahmen`, `Name`, `Nummer`, `LastAttacked`) VALUES
('-2293.56', '2226.63', '-2237.42', '2473.87', '-2261.91', '2317.41', '4.46', 3, 4, 'Bayside', 1, '0000-00-00 00:00:00'),
('-593.20001220703', '-200.19999694824', '-422.29998779297', '-31.700000762939', '-511.39999389648', '-85.300003051758', '62.200000762939', 3, 10, 'Holzfaeller', 2, '0000-00-00 00:00:00'),
('1860.7937011719', '-1452.2199707031', '1979.2247314453', '-1350.2930908203', '1918.2982177734', '-1400.6328125', '13.5703125', 9, 5, 'Skaterpark', 3, '0000-00-00 00:00:00'),
('807.40002441406', '-1130.0999755859', '952.59997558594', '-1055.5999755859', '862.70001220703', '-1101.9000244141', '24.299999237061', 9, 0, 'Friedhof', 4, '0000-00-00 00:00:00'),
('2497.1999511719', '2617.1000976563', '2749.1999511719', '2857.6000976563', '2554.8999023438', '2753.3000488281', '10.800000190735', 9, 7, 'Pissgebiet', 5, '0000-00-00 00:00:00'),
('-2160.86377', '-281.07504', '-2037.86365', '-101.41865', '-2138.58057', '-193.44653', '35.32031', 9, 0, 'Drogenlabor', 6, '0000-00-00 00:00:00'),
('-2754.60376', '1304.33423', '-2595.07983', '1520.25989', '-2629.68506', '1361.07056', '7.10034', 9, 0, 'Jizzys', 7, '0000-00-00 00:00:00'),
('-2865.85254', '1003.29700', '-2722.59790', '1205.08813', '-2818.25659', '1125.72705', '25.78679', 3, 0, 'Park', 8, '0000-00-00 00:00:00'),
('-1757.50879', '-14.13296', '-1536.50146', '112.90293', '-1690.41309', '46.81097', '3.55469', 9, 0, 'Docks', 9, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `SymbolX` double NOT NULL,
  `SymbolY` double NOT NULL,
  `SymbolZ` double NOT NULL,
  `Besitzer` varchar(50) NOT NULL,
  `Preis` int(11) NOT NULL,
  `Mindestzeit` int(11) NOT NULL,
  `CurrentInterior` int(11) NOT NULL,
  `Kasse` int(11) NOT NULL,
  `Miete` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `idcounter`
--

CREATE TABLE `idcounter` (
  `id` int(50) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inventar`
--

CREATE TABLE `inventar` (
  `Name` varchar(50) NOT NULL,
  `Wuerfel` tinyint(1) NOT NULL DEFAULT '0',
  `Blumensamen` int(11) NOT NULL DEFAULT '0',
  `Waffenslot1` varchar(50) NOT NULL DEFAULT '0|0',
  `Waffenslot2` varchar(50) NOT NULL DEFAULT '0|0',
  `Waffenslot3` varchar(50) NOT NULL DEFAULT '0|0',
  `Zigaretten` int(5) NOT NULL DEFAULT '0',
  `Materials` int(10) NOT NULL DEFAULT '0',
  `Benzinkanister` int(10) NOT NULL DEFAULT '0',
  `Schwarzpulver` int(10) NOT NULL DEFAULT '0',
  `Bomben` int(10) NOT NULL DEFAULT '0',
  `Coins` int(10) NOT NULL DEFAULT '0',
  `FGutschein` int(10) NOT NULL DEFAULT '0',
  `Schutz` int(10) NOT NULL DEFAULT '0',
  `Hotdogs` int(10) NOT NULL DEFAULT '0',
  `Eis` int(10) NOT NULL DEFAULT '0',
  `Pokale` int(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `loggedin`
--

CREATE TABLE `loggedin` (
  `Name` varchar(50) NOT NULL,
  `Serial` varchar(32) NOT NULL DEFAULT 'ABCD1234ABCD1234',
  `IP` varchar(50) NOT NULL DEFAULT '0.0.0.0',
  `Loggedin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `logout`
--

CREATE TABLE `logout` (
  `Position` varchar(50) NOT NULL,
  `Waffen` varchar(50) NOT NULL,
  `Name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `packages`
--

CREATE TABLE `packages` (
  `Name` varchar(50) NOT NULL,
  `Paket1` int(11) NOT NULL,
  `Paket2` int(11) NOT NULL,
  `Paket3` int(11) NOT NULL,
  `Paket4` int(11) NOT NULL,
  `Paket5` int(11) NOT NULL,
  `Paket6` int(11) NOT NULL,
  `Paket7` int(11) NOT NULL,
  `Paket8` int(11) NOT NULL,
  `Paket9` int(11) NOT NULL,
  `Paket10` int(11) NOT NULL,
  `Paket11` int(11) NOT NULL,
  `Paket12` int(11) NOT NULL,
  `Paket13` int(11) NOT NULL,
  `Paket14` int(11) NOT NULL,
  `Paket15` int(11) NOT NULL,
  `Paket16` int(11) NOT NULL,
  `Paket17` int(11) NOT NULL,
  `Paket18` int(11) NOT NULL,
  `Paket19` int(11) NOT NULL,
  `Paket20` int(11) NOT NULL,
  `Paket21` int(11) NOT NULL,
  `Paket22` int(11) NOT NULL,
  `Paket23` int(11) NOT NULL,
  `Paket24` int(11) NOT NULL,
  `Paket25` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `players`
--

CREATE TABLE `players` (
  `id` int(10) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `IP` varchar(50) NOT NULL,
  `Last_login` varchar(50) NOT NULL,
  `Geburtsdatum_Tag` int(11) NOT NULL,
  `Geburtsdatum_Monat` int(11) NOT NULL,
  `Geburtsdatum_Jahr` int(4) NOT NULL,
  `Passwort` varchar(32) NOT NULL,
  `Geschlecht` int(50) NOT NULL,
  `RegisterDatum` varchar(50) NOT NULL,
  `Salt` varchar(20) NOT NULL DEFAULT '',
  `LastLogin` int(50) NOT NULL DEFAULT '1',
  `Mail` varchar(50) NOT NULL,
  `Werber` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `playingtime`
--

CREATE TABLE `playingtime` (
  `Name` varchar(50) NOT NULL,
  `Time` int(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pm`
--

CREATE TABLE `pm` (
  `Sender` varchar(50) NOT NULL,
  `Empfaenger` varchar(50) NOT NULL,
  `Text` varchar(500) NOT NULL,
  `Datum` varchar(50) NOT NULL,
  `ids` int(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `state_files`
--

CREATE TABLE `state_files` (
  `name` varchar(50) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `editor` varchar(50) NOT NULL,
  `faction` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `towing`
--

CREATE TABLE `towing` (
  `Name` varchar(32) NOT NULL,
  `Slot` int(11) NOT NULL,
  `VehId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userdata`
--

CREATE TABLE `userdata` (
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Geld` double NOT NULL DEFAULT '5000',
  `Spawnpos_X` varchar(50) NOT NULL DEFAULT '1567.81055',
  `Spawnpos_Y` varchar(50) NOT NULL DEFAULT '-1896.81274',
  `Spawnpos_Z` varchar(50) NOT NULL DEFAULT '13.56059',
  `Spawnrot_X` varchar(50) NOT NULL DEFAULT '53',
  `SpawnInterior` double NOT NULL DEFAULT '0',
  `SpawnDimension` double NOT NULL DEFAULT '0',
  `Fraktion` double NOT NULL DEFAULT '0',
  `FraktionsRang` double NOT NULL DEFAULT '0',
  `Adminlevel` int(10) NOT NULL DEFAULT '0',
  `Spielzeit` double NOT NULL DEFAULT '0',
  `CurrentCars` double NOT NULL DEFAULT '0',
  `MaximumCars` double NOT NULL DEFAULT '10',
  `Tode` double NOT NULL DEFAULT '0',
  `Kills` double NOT NULL DEFAULT '0',
  `Knastzeit` double NOT NULL DEFAULT '0',
  `Himmelszeit` double NOT NULL DEFAULT '0',
  `Hausschluessel` int(50) NOT NULL DEFAULT '0',
  `Bankgeld` double NOT NULL DEFAULT '55000',
  `Drogen` double NOT NULL DEFAULT '0',
  `Skinid` int(3) NOT NULL DEFAULT '0',
  `Autofuehrerschein` int(1) NOT NULL DEFAULT '0',
  `Motorradtfuehrerschein` int(1) NOT NULL DEFAULT '0',
  `LKWfuehrerschein` int(1) NOT NULL DEFAULT '0',
  `Helikopterfuehrerschein` int(1) NOT NULL DEFAULT '0',
  `FlugscheinKlasseA` int(1) NOT NULL DEFAULT '0',
  `FlugscheinKlasseB` int(1) NOT NULL DEFAULT '0',
  `Motorbootschein` int(1) NOT NULL DEFAULT '0',
  `Segelschein` int(1) NOT NULL DEFAULT '0',
  `Angelschein` int(1) NOT NULL DEFAULT '0',
  `Wanteds` int(1) NOT NULL DEFAULT '0',
  `StvoPunkte` int(2) NOT NULL DEFAULT '0',
  `Waffenschein` int(1) NOT NULL DEFAULT '0',
  `Perso` int(1) NOT NULL DEFAULT '0',
  `IncomePayday` float NOT NULL DEFAULT '2500',
  `Boni` double NOT NULL DEFAULT '0',
  `PdayIncome` double NOT NULL DEFAULT '0',
  `PdayKosten` double NOT NULL DEFAULT '0',
  `Telefonnr` varchar(50) NOT NULL DEFAULT '0',
  `Warns` int(50) NOT NULL DEFAULT '0',
  `Gunbox1` varchar(50) NOT NULL DEFAULT '0|0',
  `Gunbox2` varchar(50) NOT NULL DEFAULT '0|0',
  `Gunbox3` varchar(50) NOT NULL DEFAULT '0|0',
  `Job` varchar(50) NOT NULL DEFAULT 'none',
  `Jobtime` double NOT NULL DEFAULT '0',
  `Bonuspunkte` int(11) NOT NULL DEFAULT '0',
  `SocialState` varchar(50) NOT NULL DEFAULT 'Neu auf Ger-Roleplay',
  `LastFactionChange` varchar(50) NOT NULL DEFAULT '-',
  `Handy` varchar(50) NOT NULL DEFAULT '|1|0|',
  `Hunger` int(11) NOT NULL DEFAULT '100',
  `Fskin` int(11) NOT NULL DEFAULT '0',
  `Fraktiontime` int(32) DEFAULT '0',
  `Level` int(1) NOT NULL DEFAULT '0',
  `Erfahrungspunkte` double NOT NULL DEFAULT '0',
  `Vip` double NOT NULL DEFAULT '0',
  `Hartz7` int(1) NOT NULL DEFAULT '0',
  `Pizzadienst` int(1) NOT NULL DEFAULT '0',
  `Arbeitsgenehmigung` int(1) NOT NULL DEFAULT '0',
  `Bankpin` varchar(50) NOT NULL DEFAULT '0',
  `WaffenscheinB` int(1) NOT NULL DEFAULT '0',
  `WaffenscheinC` int(1) NOT NULL DEFAULT '0',
  `Harndrang` int(10) NOT NULL DEFAULT '0',
  `Unternehmen` int(10) NOT NULL DEFAULT '0',
  `Unternehmenrang` int(10) NOT NULL DEFAULT '0',
  `Alkoholpegel` int(10) NOT NULL DEFAULT '0',
  `Drogenpegel` int(10) NOT NULL DEFAULT '0',
  `Jobgehalt` int(10) NOT NULL DEFAULT '0',
  `Punkte_Rekordschwimmer` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Rekordschwimmer` int(10) NOT NULL DEFAULT '0',
  `Punkte_Langlaeufer` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Langlaeufer` int(10) NOT NULL DEFAULT '0',
  `Punkte_Busfahrer` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Busfahrer` int(10) NOT NULL DEFAULT '0',
  `Punkte_Eisfahrer` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Eisfahrer` int(10) NOT NULL DEFAULT '0',
  `Punkte_Hotdog` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Hotdog` int(10) NOT NULL DEFAULT '0',
  `Punkte_Meeresreiniger` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Meeresreiniger` int(10) NOT NULL DEFAULT '0',
  `Punkte_Pilot` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Pilot` int(10) NOT NULL DEFAULT '0',
  `Punkte_Pizzalieferant` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Pizzalieferant` int(10) NOT NULL DEFAULT '0',
  `Punkte_Strassenreiniger` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Strassenreiniger` int(10) NOT NULL DEFAULT '0',
  `Punkte_Trucker` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Trucker` int(10) NOT NULL DEFAULT '0',
  `Erfolg_250Spielstunden` int(10) NOT NULL DEFAULT '0',
  `Erfolg_EndlichLevel25` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Fahrzeugsammler` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Millionaer` int(10) NOT NULL DEFAULT '0',
  `Erfolg_MeinErstesGeld` int(10) NOT NULL DEFAULT '0',
  `Erfolg_MeinErstesFahrzeug` int(10) NOT NULL DEFAULT '0',
  `Erfolg_MeinZuhause` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Bergwerkarbeiter` int(10) NOT NULL DEFAULT '0',
  `Punkte_Bergwerkarbeiter` int(10) NOT NULL DEFAULT '0',
  `Carslotupgrade` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Gym` int(10) NOT NULL DEFAULT '0',
  `Punkte_Zugjob` int(10) NOT NULL DEFAULT '0',
  `Erfolg_Zugjob` int(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `Kofferraum` varchar(50) NOT NULL DEFAULT '0|0|0|0|',
  `Besitzer` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Typ` int(11) NOT NULL,
  `Tuning` varchar(255) NOT NULL,
  `Spawnpos_X` varchar(50) NOT NULL,
  `Spawnpos_Y` varchar(50) NOT NULL,
  `Spawnpos_Z` varchar(50) NOT NULL,
  `Spawnrot_X` varchar(50) NOT NULL,
  `Spawnrot_Y` varchar(50) NOT NULL,
  `Spawnrot_Z` varchar(50) NOT NULL,
  `Farbe` varchar(50) NOT NULL,
  `Paintjob` varchar(50) NOT NULL,
  `Benzin` varchar(50) NOT NULL,
  `Slot` float NOT NULL,
  `Special` int(11) NOT NULL DEFAULT '0',
  `Lights` varchar(50) NOT NULL DEFAULT '|255|255|255|',
  `Distance` double NOT NULL DEFAULT '0',
  `STuning` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0|',
  `AuktionsID` int(10) NOT NULL DEFAULT '0',
  `GangVehicle` tinyint(1) NOT NULL DEFAULT '0',
  `rc` int(1) NOT NULL DEFAULT '0',
  `Gang` int(1) NOT NULL DEFAULT '0',
  `NewTuningTL` int(1) NOT NULL DEFAULT '0',
  `NewTuningMU` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `weed`
--

CREATE TABLE `weed` (
  `id` int(11) NOT NULL,
  `x` int(20) NOT NULL,
  `y` int(20) NOT NULL,
  `z` int(20) NOT NULL,
  `time` int(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `recieved` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `ban`
--
ALTER TABLE `ban`
  ADD KEY `Name` (`Name`),
  ADD KEY `IP` (`IP`),
  ADD KEY `Serial` (`Serial`),
  ADD KEY `STime` (`STime`);

--
-- Indizes für die Tabelle `email`
--
ALTER TABLE `email`
  ADD KEY `Empfaenger` (`Empfaenger`);

--
-- Indizes für die Tabelle `fraktionen`
--
ALTER TABLE `fraktionen`
  ADD PRIMARY KEY (`FKasse`,`ID`,`Name`);

--
-- Indizes für die Tabelle `gangs`
--
ALTER TABLE `gangs`
  ADD PRIMARY KEY (`X1`);

--
-- Indizes für die Tabelle `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Besitzer` (`Besitzer`);

--
-- Indizes für die Tabelle `inventar`
--
ALTER TABLE `inventar`
  ADD PRIMARY KEY (`Name`),
  ADD KEY `Name` (`Name`);

--
-- Indizes für die Tabelle `logout`
--
ALTER TABLE `logout`
  ADD KEY `Name` (`Name`);

--
-- Indizes für die Tabelle `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`Name`),
  ADD KEY `Name` (`Name`);

--
-- Indizes für die Tabelle `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`Name`);

--
-- Indizes für die Tabelle `playingtime`
--
ALTER TABLE `playingtime`
  ADD KEY `Name` (`Name`);

--
-- Indizes für die Tabelle `pm`
--
ALTER TABLE `pm`
  ADD PRIMARY KEY (`ids`),
  ADD KEY `Empfaenger` (`Empfaenger`);

--
-- Indizes für die Tabelle `state_files`
--
ALTER TABLE `state_files`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`Name`),
  ADD KEY `Name` (`Name`);

--
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Besitzer` (`Besitzer`);

--
-- Indizes für die Tabelle `weed`
--
ALTER TABLE `weed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `pm`
--
ALTER TABLE `pm`
  MODIFY `ids` int(50) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `weed`
--
ALTER TABLE `weed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
