-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2018 at 09:06 AM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.1.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--
CREATE DATABASE test2;
USE test2;
DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertIntoCPU` (IN `p_IPAddress` VARCHAR(255), IN `p_CpuUtil` FLOAT)  BEGIN
    DECLARE p_id int(11);
 
    SELECT DeviceID INTO p_id
    FROM devices
    WHERE IPAddress = p_IPAddress;
 
    insert into cpu_utilization(DeviceId,CpuUtil) values(p_id,p_CpuUtil);
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertIntoDevices` (IN `p_hostname` VARCHAR(255), IN `p_IPAddress` VARCHAR(255))  BEGIN
	INSERT INTO `devices`(`HostName`, `IPAddress`) SELECT * FROM (SELECT p_hostname,p_IPAddress) AS tmp WHERE  NOT EXISTS ( SELECT IPAddress FROM devices WHERE IPAddress = p_IPAddress) LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertIntoDisk` (IN `p_IPAddress` VARCHAR(255), IN `p_diskId` VARCHAR(255), IN `p_DiskUtil` FLOAT)  BEGIN
    DECLARE p_id int(11);
 
    SELECT DeviceID INTO p_id
    FROM devices
    WHERE IPAddress = p_IPAddress;
 
    insert into disk_utilization(DeviceId,DiskId,DiskUtil) values(p_id,p_diskId,p_DiskUtil);
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertIntoMemory` (IN `p_IPAddress` VARCHAR(255), IN `p_MemoryUtil` FLOAT)  BEGIN
    DECLARE p_id int(11);
 
    SELECT DeviceID INTO p_id
    FROM devices
    WHERE IPAddress = p_IPAddress;
 
    insert into memory_utilization(DeviceId,MemoryUtil) values(p_id,100-p_MemoryUtil);
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Querying` (IN `ip_IPAddress` VARCHAR(255))  BEGIN
	SELECT cpu_utilization.DeviceID,cpu_utilization.Time, cpu_utilization.CpuUtil,disk_utilization.DiskId,disk_utilization.DiskUtil,memory_utilization.MemoryUtil FROM cpu_utilization,disk_utilization,memory_utilization WHERE disk_utilization.DeviceID = cpu_utilization.DeviceID AND cpu_utilization.DeviceID = memory_utilization.DeviceID AND memory_utilization.DeviceID = (SELECT DeviceID FROM devices WHERE IPAddress = ip_IPAddress) AND cpu_utilization.Time = disk_utilization.Time AND disk_utilization.Time = memory_utilization.Time;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDevices` (IN `p_hostname` VARCHAR(255), IN `p_IPAddress` VARCHAR(255), IN `p_MACAddress` VARCHAR(255), IN `p_OS` VARCHAR(255))  BEGIN
              IF EXISTS(SELECT IPAddress FROM devices WHERE devices.IPAddress = p_IPAddress) THEN
              UPDATE `devices` SET `MACAddress` = p_MACAddress, `OS` = p_OS WHERE (MacAddress IS NULL AND OS IS NULL AND `IPAddress` = p_IPAddress);
              ELSE
              INSERT INTO `devices`(`HostName`, `IPAddress`, `MacAddress`, `OS`) SELECT * FROM (SELECT p_hostname,p_IPAddress,p_MACAddress,p_OS) AS tmp WHERE NOT EXISTS ( SELECT IPAddress FROM devices WHERE IPAddress = p_IPAddress) LIMIT 1;
              END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `alarms`
--

CREATE TABLE `alarms` (
  `DeviceID` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ErrorId` int(11) NOT NULL,
  `AlarmCause` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `alarms`
--

-- --------------------------------------------------------

--
-- Table structure for table `cpu_utilization`
--

CREATE TABLE `cpu_utilization` (
  `DeviceID` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CpuUtil` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cpu_utilization`
--


--
-- Triggers `cpu_utilization`
--
DELIMITER $$
CREATE TRIGGER `insert_cpu_alarm` AFTER INSERT ON `cpu_utilization` FOR EACH ROW BEGIN
    DECLARE threshold_ INT(11);
    DECLARE pre varchar(255);
    DECLARE mid varchar(255);
    SELECT
        CPUThreshold
    INTO
        threshold_
    FROM
        devices
    WHERE
         devices.DeviceID=NEW.DeviceID;     
       IF (NEW.CpuUtil>threshold_) THEN
            SET pre = 'WARNING! CPU Utilization is High (in %) =';
            SET mid = ' >';
            INSERT INTO alarms(DeviceID,ErrorId,AlarmCause) values(NEW.DeviceID,1,CONCAT(pre,NEW.CpuUtil,mid,threshold_)); 
       END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `DeviceID` int(11) NOT NULL,
  `HostName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IPAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `MacAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `OS` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CPUThreshold` int(11) DEFAULT '50',
  `DiskThreshold` int(11) DEFAULT '80',
  `MemoryThreshold` int(11) DEFAULT '50'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devices`
--


-- --------------------------------------------------------

--
-- Table structure for table `disk_utilization`
--

CREATE TABLE `disk_utilization` (
  `DeviceID` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DiskId` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `DiskUtil` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `disk_utilization`
--


--
-- Triggers `disk_utilization`
--
DELIMITER $$
CREATE TRIGGER `insert_Disk_alarm` AFTER INSERT ON `disk_utilization` FOR EACH ROW BEGIN
    DECLARE disk_threshold_ INT(11);
    DECLARE pre varchar(255);
    DECLARE mid varchar(255);
    DECLARE pst varchar(255);
    SELECT
        DiskThreshold
    INTO
        disk_threshold_
    FROM
        devices
    WHERE
         devices.DeviceID=NEW.DeviceID;     
       IF (NEW.DiskUtil<disk_threshold_) THEN
            SET pre = 'WARNING! Low Disk Memory (in GB) = ';
            SET mid = ' < ';
            INSERT INTO alarms(DeviceID,ErrorId,AlarmCause) values(NEW.DeviceID,2,CONCAT(pre,NEW.DiskUtil,mid,disk_threshold_)); 
       END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `memory_utilization`
--

CREATE TABLE `memory_utilization` (
  `DeviceID` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MemoryUtil` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `memory_utilization`
--



--
-- Triggers `memory_utilization`
--
DELIMITER $$
CREATE TRIGGER `insert_memory_alarm` AFTER INSERT ON `memory_utilization` FOR EACH ROW BEGIN
    DECLARE mem_threshold_ INT(11);
    DECLARE pre varchar(255);
    DECLARE mid varchar(255);
    SELECT
        MemoryThreshold
    INTO
        mem_threshold_
    FROM
        devices
    WHERE
         devices.DeviceID=NEW.DeviceID;     
       IF (NEW.MemoryUtil>mem_threshold_) THEN
           SET pre = 'WARNING! Memory Utilization is High (in %)  = ';
            SET mid = ' >';
            INSERT INTO alarms(DeviceID,ErrorId,AlarmCause) values(NEW.DeviceID,3,CONCAT(pre,NEW.MemoryUtil,mid,mem_threshold_)); 
       END IF;
    END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alarms`
--
ALTER TABLE `alarms`
  ADD PRIMARY KEY (`DeviceID`,`Time`),
  ADD KEY `ErrorId` (`ErrorId`);

--
-- Indexes for table `cpu_utilization`
--
ALTER TABLE `cpu_utilization`
  ADD PRIMARY KEY (`DeviceID`,`Time`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`DeviceID`,`HostName`);

--
-- Indexes for table `disk_utilization`
--
ALTER TABLE `disk_utilization`
  ADD PRIMARY KEY (`DeviceID`,`Time`);

--
-- Indexes for table `memory_utilization`
--
ALTER TABLE `memory_utilization`
  ADD PRIMARY KEY (`DeviceID`,`Time`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alarms`
--
ALTER TABLE `alarms`
  MODIFY `ErrorId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `DeviceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
