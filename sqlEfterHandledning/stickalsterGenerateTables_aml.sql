-- MySQL Script generated by MySQL Workbench
-- Tue Jan 30 19:52:03 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema individualProjectStickalster
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema individualProjectStickalster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `individualProjectStickalster` DEFAULT CHARACTER SET utf8 ;
USE `individualProjectStickalster` ;

-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Mottagare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Mottagare` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Mottagare` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `namn` VARCHAR(45) NOT NULL,
  `kontakt` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Kategori`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Kategori` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Kategori` (
  `namn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`namn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Item` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Item` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `modellTyp` VARCHAR(60) NOT NULL COMMENT 'Type of object, name of model, technique used, \"Trekantssjal uppifrån och ner\"',
  `Kategori_namn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`, `Kategori_namn`),
  INDEX `fk_Item_Kategori1_idx` (`Kategori_namn` ASC),
  CONSTRAINT `fk_Item_Kategori1`
    FOREIGN KEY (`Kategori_namn`)
    REFERENCES `individualProjectStickalster`.`Kategori` (`namn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Alster`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Alster` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Alster` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Mottagare_ID` INT(11) NOT NULL,
  `Item_ID` INT(11) NOT NULL,
  `teknik` VARCHAR(45) NULL,
  `feature` VARCHAR(45) NULL DEFAULT NULL,
  `sticka` INT(4) NULL DEFAULT NULL,
  `pris` INT(11) NULL DEFAULT NULL,
  `start01` INT NOT NULL DEFAULT 0 COMMENT '0 - ej påbörjad, 1 - påbörjad. Trigger sätter timestamp när värdet ändras. ',
  `datumStart` DATETIME NULL,
  `finish01` INT NOT NULL DEFAULT 0 COMMENT '0 - inte avslutad, 1 - avslutad. Trigger - timestamp i datumAvslutad när värdet ändras.',
  `datumFinish` DATETIME NULL COMMENT '\"\nCREATE TRIGGER `my_table_bi` \nBEFORE INSERT ON `my_table` FOR EACH ROW\nBEGIN\n    SET NEW.created_date = NOW();\nEND;;\nDELIMITER ;',
  PRIMARY KEY (`ID`, `Mottagare_ID`, `Item_ID`),
  INDEX `fk_Alster_Mottagare1_idx` (`Mottagare_ID` ASC),
  INDEX `fk_Alster_Item1_idx` (`Item_ID` ASC),
  CONSTRAINT `fk_Alster_Mottagare1`
    FOREIGN KEY (`Mottagare_ID`)
    REFERENCES `individualProjectStickalster`.`Mottagare` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Alster_Item1`
    FOREIGN KEY (`Item_ID`)
    REFERENCES `individualProjectStickalster`.`Item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Garn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Garn` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Garn` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `nameManuf` VARCHAR(45) NULL DEFAULT NULL,
  `material` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Alster_has_Garn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Alster_has_Garn` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Alster_has_Garn` (
  `Alster_ID` INT(11) NOT NULL,
  `Garn_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Alster_ID`, `Garn_ID`),
  INDEX `fk_Alster_has_Garn_Garn1_idx` (`Garn_ID` ASC),
  INDEX `fk_Alster_has_Garn_Alster1_idx` (`Alster_ID` ASC),
  CONSTRAINT `fk_Alster_has_Garn_Alster1`
    FOREIGN KEY (`Alster_ID`)
    REFERENCES `individualProjectStickalster`.`Alster` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alster_has_Garn_Garn1`
    FOREIGN KEY (`Garn_ID`)
    REFERENCES `individualProjectStickalster`.`Garn` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`colour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`colour` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`colour` (
  `colour` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`colour`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Garn_has_colour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualProjectStickalster`.`Garn_has_colour` ;

CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Garn_has_colour` (
  `Garn_ID` INT(11) NOT NULL,
  `colour` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Garn_ID`, `colour`),
  INDEX `fk_Garn_has_colour_colour1_idx` (`colour` ASC),
  CONSTRAINT `fk_Garn_has_colour_Garn1`
    FOREIGN KEY (`Garn_ID`)
    REFERENCES `individualProjectStickalster`.`Garn` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Garn_has_colour_colour1`
    FOREIGN KEY (`colour`)
    REFERENCES `individualProjectStickalster`.`colour` (`colour`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `individualProjectStickalster`;

DELIMITER $$

USE `individualProjectStickalster`$$
DROP TRIGGER IF EXISTS `individualProjectStickalster`.`Alster_start01_BEFORE_UPDATE` $$
USE `individualProjectStickalster`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Alster_start01_BEFORE_UPDATE` BEFORE UPDATE ON `Alster` FOR EACH ROW
BEGIN
    IF (NEW.start01) > (OLD.start01)
	THEN SET NEW.datumStart=NOW();
        END IF;
	if (NEW.finish01) > (OLD.finish01)
    THEN SET NEW.datumFinish=NOW();
    end if;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
