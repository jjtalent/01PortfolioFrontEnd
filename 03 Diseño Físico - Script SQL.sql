-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `titulo` VARCHAR(70) NOT NULL,
  `acerca_de` VARCHAR(255) NOT NULL,
  `url_img` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `url_img` VARCHAR(255) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_experiencia_laboral_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estudio` VARCHAR(60) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `url_img` VARCHAR(255) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_educacion_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `nivel` INT NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_skill_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_skill_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`idioma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`idioma` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `nivel` INT NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_idioma_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_idioma_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `url_proyecto` VARCHAR(255) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_proyecto_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `nombre_usuario` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_usuario_UNIQUE` (`nombre_usuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`usuario_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`usuario_rol` (
  `rol_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`rol_id`, `usuario_id`),
  INDEX `fk_rol_has_usuario_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_rol_has_usuario_rol1_idx` (`rol_id` ASC),
  CONSTRAINT `fk_rol_has_usuario_rol1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `portfolio`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `portfolio`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto_img`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto_img` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url_img` VARCHAR(255) NOT NULL,
  `proyecto_id` INT NOT NULL,
  `proyecto_persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `proyecto_id`, `proyecto_persona_id`),
  INDEX `fk_proyecto_img_proyecto1_idx` (`proyecto_id` ASC, `proyecto_persona_id` ASC),
  CONSTRAINT `fk_proyecto_img_proyecto1`
    FOREIGN KEY (`proyecto_id` , `proyecto_persona_id`)
    REFERENCES `portfolio`.`proyecto` (`id` , `persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
