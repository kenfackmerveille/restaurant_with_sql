-- MySQL Script generated by MySQL Workbench
-- Fri Sep  8 16:35:46 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `restaurant` ;

-- -----------------------------------------------------
-- Table `restaurant`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_address`),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`dishes` (
  `id_dishes` INT NOT NULL AUTO_INCREMENT,
  `dishes_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id_dishes`),
  UNIQUE INDEX `id_dishes_UNIQUE` (`id_dishes` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `dishes_id_dishes` INT NOT NULL,
  PRIMARY KEY (`id_category`, `dishes_id_dishes`),
  UNIQUE INDEX `id_category_UNIQUE` (`id_category` ASC) VISIBLE,
  INDEX `fk_category_dishes1_idx` (`dishes_id_dishes` ASC) VISIBLE,
  CONSTRAINT `fk_category_dishes1`
    FOREIGN KEY (`dishes_id_dishes`)
    REFERENCES `restaurant`.`dishes` (`id_dishes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`cities` (
  `id_city` INT NOT NULL AUTO_INCREMENT,
  `cityc_name` VARCHAR(45) NOT NULL,
  `address_id_address` INT NOT NULL,
  PRIMARY KEY (`id_city`, `address_id_address`),
  UNIQUE INDEX `id_city_UNIQUE` (`id_city` ASC) VISIBLE,
  INDEX `fk_cities_address_idx` (`address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_cities_address`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `restaurant`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`countries` (
  `id_country` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  `address_id_address` INT NOT NULL,
  PRIMARY KEY (`id_country`, `address_id_address`),
  UNIQUE INDEX `id_country_UNIQUE` (`id_country` ASC) VISIBLE,
  INDEX `fk_countries_address1_idx` (`address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_countries_address1`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `restaurant`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`orders` (
  `id_orders` INT NOT NULL AUTO_INCREMENT,
  `customers_customer_id` INT NOT NULL,
  `customers_address_id_address` INT NOT NULL,
  `waiters_id_waiters` INT NOT NULL,
  `waiters_address_id_address` INT NOT NULL,
  `dishes_id_dishes` INT NOT NULL,
  PRIMARY KEY (`id_orders`, `customers_customer_id`, `customers_address_id_address`, `waiters_id_waiters`, `waiters_address_id_address`, `dishes_id_dishes`),
  UNIQUE INDEX `id_orders_UNIQUE` (`id_orders` ASC) VISIBLE,
  INDEX `fk_orders_dishes1_idx` (`dishes_id_dishes` ASC) VISIBLE,
  CONSTRAINT `fk_orders_dishes1`
    FOREIGN KEY (`dishes_id_dishes`)
    REFERENCES `restaurant`.`dishes` (`id_dishes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address_id_address` INT NOT NULL,
  `orders_id_orders` INT NOT NULL,
  `orders_customers_customer_id` INT NOT NULL,
  `orders_customers_address_id_address` INT NOT NULL,
  `orders_waiters_id_waiters` INT NOT NULL,
  `orders_waiters_address_id_address` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `address_id_address`, `orders_id_orders`, `orders_customers_customer_id`, `orders_customers_address_id_address`, `orders_waiters_id_waiters`, `orders_waiters_address_id_address`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  INDEX `fk_customers_address1_idx` (`address_id_address` ASC) VISIBLE,
  INDEX `fk_customers_orders1_idx` (`orders_id_orders` ASC, `orders_customers_customer_id` ASC, `orders_customers_address_id_address` ASC, `orders_waiters_id_waiters` ASC, `orders_waiters_address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `restaurant`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_orders1`
    FOREIGN KEY (`orders_id_orders` , `orders_customers_customer_id` , `orders_customers_address_id_address` , `orders_waiters_id_waiters` , `orders_waiters_address_id_address`)
    REFERENCES `restaurant`.`orders` (`id_orders` , `customers_customer_id` , `customers_address_id_address` , `waiters_id_waiters` , `waiters_address_id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`preparation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`preparation` (
  `id preparation` INT NOT NULL AUTO_INCREMENT,
  `date_de_preparation` VARCHAR(45) NOT NULL,
  `dishes_id_dishes` INT NOT NULL,
  PRIMARY KEY (`id preparation`, `dishes_id_dishes`),
  INDEX `fk_preparation_dishes1_idx` (`dishes_id_dishes` ASC) VISIBLE,
  CONSTRAINT `fk_preparation_dishes1`
    FOREIGN KEY (`dishes_id_dishes`)
    REFERENCES `restaurant`.`dishes` (`id_dishes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`quaters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`quaters` (
  `id_quater` INT NOT NULL AUTO_INCREMENT,
  `quater_name` VARCHAR(45) NOT NULL,
  `address_id_address` INT NOT NULL,
  PRIMARY KEY (`id_quater`, `address_id_address`),
  UNIQUE INDEX `id_quaters_UNIQUE` (`id_quater` ASC) VISIBLE,
  INDEX `fk_quaters_address1_idx` (`address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_quaters_address1`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `restaurant`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_name` VARCHAR(45) NOT NULL,
  `preparation_id preparation` INT NOT NULL,
  `preparation_dishes_id_dishes` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `preparation_id preparation`, `preparation_dishes_id_dishes`),
  UNIQUE INDEX `id_restaurant_UNIQUE` (`restaurant_id` ASC) VISIBLE,
  INDEX `fk_restaurant_preparation1_idx` (`preparation_id preparation` ASC, `preparation_dishes_id_dishes` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_preparation1`
    FOREIGN KEY (`preparation_id preparation` , `preparation_dishes_id_dishes`)
    REFERENCES `restaurant`.`preparation` (`id preparation` , `dishes_id_dishes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`transfer` (
  `id_transfer` INT NOT NULL AUTO_INCREMENT,
  `date_of_transfer` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `preparation_id preparation` INT NOT NULL,
  PRIMARY KEY (`id_transfer`),
  UNIQUE INDEX `id_transfer_UNIQUE` (`id_transfer` ASC) VISIBLE,
  INDEX `fk_transfer_preparation1_idx` (`preparation_id preparation` ASC) VISIBLE,
  CONSTRAINT `fk_transfer_preparation1`
    FOREIGN KEY (`preparation_id preparation`)
    REFERENCES `restaurant`.`preparation` (`id preparation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`waiters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`waiters` (
  `id_waiters` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `salary` INT NOT NULL,
  `address_id_address` INT NOT NULL,
  `orders_id_orders` INT NOT NULL,
  `orders_customers_customer_id` INT NOT NULL,
  `orders_customers_address_id_address` INT NOT NULL,
  `orders_waiters_id_waiters` INT NOT NULL,
  `orders_waiters_address_id_address` INT NOT NULL,
  PRIMARY KEY (`id_waiters`, `address_id_address`, `orders_id_orders`, `orders_customers_customer_id`, `orders_customers_address_id_address`, `orders_waiters_id_waiters`, `orders_waiters_address_id_address`),
  UNIQUE INDEX `id_waiters_UNIQUE` (`id_waiters` ASC) VISIBLE,
  INDEX `fk_waiters_address1_idx` (`address_id_address` ASC) VISIBLE,
  INDEX `fk_waiters_orders1_idx` (`orders_id_orders` ASC, `orders_customers_customer_id` ASC, `orders_customers_address_id_address` ASC, `orders_waiters_id_waiters` ASC, `orders_waiters_address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_waiters_address1`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `restaurant`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waiters_orders1`
    FOREIGN KEY (`orders_id_orders` , `orders_customers_customer_id` , `orders_customers_address_id_address` , `orders_waiters_id_waiters` , `orders_waiters_address_id_address`)
    REFERENCES `restaurant`.`orders` (`id_orders` , `customers_customer_id` , `customers_address_id_address` , `waiters_id_waiters` , `waiters_address_id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
