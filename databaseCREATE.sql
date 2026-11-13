-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PantryPal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PantryPal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PantryPal` DEFAULT CHARACTER SET utf8 ;
USE `PantryPal` ;

-- -----------------------------------------------------
-- Table `PantryPal`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(15) NULL,
  `created_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`recipes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`recipes` (
  `recipe_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `visibility` ENUM('public', 'private', 'shared') NOT NULL,
  `prep_time_minutes` INT NULL,
  `cook_time_minutes` INT NULL,
  `description` VARCHAR(255) NULL,
  `base_servings` INT NOT NULL,
  `owner_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`recipe_id`),
  INDEX `fk_users2_idx` (`owner_id` ASC) VISIBLE,
  CONSTRAINT `fk_users2`
    FOREIGN KEY (`owner_id`)
    REFERENCES `PantryPal`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`ingredients` (
  `ingredient_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `grams_in_teaspoon` DECIMAL(4,2) NULL,
  PRIMARY KEY (`ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`instructions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`instructions` (
  `instruction_id` INT NOT NULL AUTO_INCREMENT,
  `step_number` INT NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`instruction_id`),
  INDEX `fk_recipes2_idx` (`recipe_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipes2`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `PantryPal`.`recipes` (`recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`pantries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`pantries` (
  `pantry_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`pantry_id`),
  INDEX `fk_users4_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users4`
    FOREIGN KEY (`user_id`)
    REFERENCES `PantryPal`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`meal_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`meal_plans` (
  `meal_plan_id` INT NOT NULL AUTO_INCREMENT,
  `week_start_date` DATE NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`meal_plan_id`),
  INDEX `fk_users3_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users3`
    FOREIGN KEY (`user_id`)
    REFERENCES `PantryPal`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`shopping_lists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`shopping_lists` (
  `shopping_list_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `meal_plan_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`shopping_list_id`),
  INDEX `fk_users5_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_meal_plans2_idx` (`meal_plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_users5`
    FOREIGN KEY (`user_id`)
    REFERENCES `PantryPal`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_plans2`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `PantryPal`.`meal_plans` (`meal_plan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`recipe_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`recipe_permissions` (
  `recipe_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `type` ENUM('view', 'edit') NOT NULL,
  PRIMARY KEY (`recipe_id`, `user_id`),
  INDEX `fk_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_recipes_idx` (`recipe_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipes`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `PantryPal`.`recipes` (`recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `PantryPal`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`food_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`food_categories` (
  `food_category_id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`food_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`ingredient_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`ingredient_categories` (
  `ingredient_id` INT NOT NULL,
  `food_category_id` INT NOT NULL,
  PRIMARY KEY (`ingredient_id`, `food_category_id`),
  INDEX `fk_food_categories1_idx` (`food_category_id` ASC) VISIBLE,
  INDEX `fk_ingredients1_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_ingredients1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `PantryPal`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food_categories1`
    FOREIGN KEY (`food_category_id`)
    REFERENCES `PantryPal`.`food_categories` (`food_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`units` (
  `unit_id` INT NOT NULL AUTO_INCREMENT,
  `unit` VARCHAR(15) NOT NULL,
  `unit_symbol` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`unit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`recipe_ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`recipe_ingredients` (
  `recipe_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `quantity` DECIMAL(5,2) NOT NULL,
  `is_opitional` TINYINT NOT NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `ingredient_id`),
  INDEX `fk_ingredients2_idx` (`ingredient_id` ASC) VISIBLE,
  INDEX `fk_recipes1_idx` (`recipe_id` ASC) VISIBLE,
  INDEX `fk_units1_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipes1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `PantryPal`.`recipes` (`recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients2`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `PantryPal`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_units1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `PantryPal`.`units` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`recipe_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`recipe_images` (
  `images_id` INT NOT NULL AUTO_INCREMENT,
  `recipe_id` INT NOT NULL,
  `image_url` VARCHAR(2083) NOT NULL,
  `is_cover` TINYINT NOT NULL,
  `display_order` INT NOT NULL,
  PRIMARY KEY (`images_id`),
  INDEX `fk_recipes3_idx` (`recipe_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipes3`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `PantryPal`.`recipes` (`recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`tags` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`recipe_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`recipe_tags` (
  `tag_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`tag_id`, `recipe_id`),
  INDEX `fk_recipes4_idx` (`recipe_id` ASC) VISIBLE,
  INDEX `fk_tags1_idx` (`tag_id` ASC) VISIBLE,
  CONSTRAINT `fk_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `PantryPal`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipes4`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `PantryPal`.`recipes` (`recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`meals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`meals` (
  `meal_id` INT NOT NULL AUTO_INCREMENT,
  `meal` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`meal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`scheduled_meals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`scheduled_meals` (
  `scheduled_meal_id` INT NOT NULL AUTO_INCREMENT,
  `recipe_id` INT NOT NULL,
  `meal_plan_id` INT NOT NULL,
  `meal_date` DATE NOT NULL,
  `servings` INT NOT NULL,
  `meal_id` INT NOT NULL,
  PRIMARY KEY (`scheduled_meal_id`),
  INDEX `fk_recipes5_idx` (`recipe_id` ASC) VISIBLE,
  INDEX `fk_meal_plans1_idx` (`meal_plan_id` ASC) VISIBLE,
  INDEX `fk_meals1_idx` (`meal_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipes5`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `PantryPal`.`recipes` (`recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_plans1`
    FOREIGN KEY (`meal_plan_id`)
    REFERENCES `PantryPal`.`meal_plans` (`meal_plan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meals1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `PantryPal`.`meals` (`meal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`pantry_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`pantry_items` (
  `pantry_item_id` INT NOT NULL AUTO_INCREMENT,
  `pantry_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `quantity` DECIMAL(5,2) NOT NULL,
  `expiration_date` DATE NOT NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`pantry_item_id`),
  INDEX `fk_pantries1_idx` (`pantry_id` ASC) VISIBLE,
  INDEX `fk_ingredients3_idx` (`ingredient_id` ASC) VISIBLE,
  INDEX `fk_units2_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_pantries1`
    FOREIGN KEY (`pantry_id`)
    REFERENCES `PantryPal`.`pantries` (`pantry_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients3`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `PantryPal`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_units2`
    FOREIGN KEY (`unit_id`)
    REFERENCES `PantryPal`.`units` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PantryPal`.`shopping_list_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PantryPal`.`shopping_list_items` (
  `shopping_list_item_id` INT NOT NULL AUTO_INCREMENT,
  `shopping_list_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `quantity_needed` INT NOT NULL,
  `quantity_in_pantry` INT NULL,
  `quantity_to_buy` INT NULL,
  `checked` TINYINT NOT NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`shopping_list_item_id`),
  INDEX `fk_shopping_lists1_idx` (`shopping_list_id` ASC) VISIBLE,
  INDEX `fk_ingredients4_idx` (`ingredient_id` ASC) VISIBLE,
  INDEX `fk_units3_idx` (`unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_shopping_lists1`
    FOREIGN KEY (`shopping_list_id`)
    REFERENCES `PantryPal`.`shopping_lists` (`shopping_list_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients4`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `PantryPal`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_units3`
    FOREIGN KEY (`unit_id`)
    REFERENCES `PantryPal`.`units` (`unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
