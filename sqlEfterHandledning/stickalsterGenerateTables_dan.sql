-- MySQL Script generated by MySQL Workbench
-- Mon Jan 29 14:46:38 2018
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
CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Mottagare` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `namn` VARCHAR(45) NOT NULL,
  `kontakt` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Item` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `modellTyp` VARCHAR(45) NOT NULL,
  `kategori` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Alster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`Alster` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Mottagare_ID` INT(11) NOT NULL,
  `teknik` VARCHAR(45) NULL DEFAULT NULL,
  `feature` VARCHAR(45) NULL DEFAULT NULL,
  `sticka` INT(11) NULL DEFAULT NULL,
  `pris` INT(11) NULL DEFAULT NULL,
  `Item_ID` INT(11) NOT NULL,
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
CREATE TABLE IF NOT EXISTS `individualProjectStickalster`.`colour` (
  `colour` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`colour`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `individualProjectStickalster`.`Garn_has_colour`
-- -----------------------------------------------------
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
