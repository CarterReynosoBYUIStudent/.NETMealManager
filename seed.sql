-- PantryPal development seed data
-- Run after databaseCREATE.sql:
--   /usr/local/mysql/bin/mysql -u root -p < .NETMealManager/seed.sql
--
-- The explicit IDs make this file safe to run repeatedly with INSERT IGNORE.
-- These are development-only accounts; do not use the sample password in production.

USE `PantryPal`;

SET FOREIGN_KEY_CHECKS = 0;

INSERT IGNORE INTO `users`
    (`user_id`, `username`, `email`, `password_hash`, `phone_number`, `created_at`)
VALUES
    (1, 'alice', 'alice@example.com', '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2085550101', '2026-11-01 09:00:00'),
    (2, 'brandon', 'brandon@example.com', '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2085550102', '2026-11-02 10:30:00'),
    (3, 'carter', 'carter@example.com', '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NULL, '2026-11-03 14:15:00');

INSERT IGNORE INTO `food_categories` (`food_category_id`, `category`) VALUES
    (1, 'Produce'),
    (2, 'Dairy'),
    (3, 'Meat and Seafood'),
    (4, 'Grains and Pasta'),
    (5, 'Pantry Staples'),
    (6, 'Spices and Herbs');

INSERT IGNORE INTO `units` (`unit_id`, `unit`, `unit_symbol`) VALUES
    (1, 'teaspoon', 'tsp'),
    (2, 'tablespoon', 'tbsp'),
    (3, 'cup', 'cup'),
    (4, 'gram', 'g'),
    (5, 'milliliter', 'ml'),
    (6, 'piece', 'pc');

INSERT IGNORE INTO `meals` (`meal_id`, `meal`) VALUES
    (1, 'Breakfast'),
    (2, 'Lunch'),
    (3, 'Dinner'),
    (4, 'Snack');

INSERT IGNORE INTO `ingredients` (`ingredient_id`, `name`, `grams_in_teaspoon`) VALUES
    (1, 'rolled oats', 3.13),
    (2, 'milk', 5.00),
    (3, 'banana', NULL),
    (4, 'blueberries', NULL),
    (5, 'chicken breast', NULL),
    (6, 'brown rice', 3.33),
    (7, 'broccoli', NULL),
    (8, 'olive oil', 4.50),
    (9, 'garlic', NULL),
    (10, 'soy sauce', 5.50),
    (11, 'eggs', NULL),
    (12, 'whole wheat bread', NULL),
    (13, 'avocado', NULL),
    (14, 'tomato', NULL),
    (15, 'black pepper', 2.30),
    (16, 'salt', 6.00),
    (17, 'parmesan cheese', NULL),
    (18, 'spaghetti', NULL);

INSERT IGNORE INTO `ingredient_categories` (`ingredient_id`, `food_category_id`) VALUES
    (1, 4), (2, 2), (3, 1), (4, 1), (5, 3), (6, 4),
    (7, 1), (8, 5), (9, 1), (10, 5), (11, 2), (12, 4),
    (13, 1), (14, 1), (15, 6), (16, 6), (17, 2), (18, 4);

INSERT IGNORE INTO `recipes`
    (`recipe_id`, `name`, `visibility`, `prep_time_minutes`, `cook_time_minutes`, `description`, `base_servings`, `owner_id`, `created_at`, `updated_at`)
VALUES
    (1, 'Blueberry Banana Oatmeal', 'public', 5, 5, 'Warm oatmeal with fruit for a quick breakfast.', 2, 1, '2026-11-04 08:00:00', '2026-11-04 08:00:00'),
    (2, 'Chicken Rice Bowls', 'public', 15, 25, 'Chicken, brown rice, and broccoli with a simple soy glaze.', 4, 1, '2026-11-05 12:00:00', '2026-11-05 12:00:00'),
    (3, 'Avocado Toast', 'shared', 5, 5, 'Toasted whole wheat bread topped with avocado and tomato.', 2, 2, '2026-11-06 07:30:00', '2026-11-06 07:30:00'),
    (4, 'Garlic Parmesan Pasta', 'private', 10, 15, 'Simple spaghetti tossed with garlic, olive oil, and parmesan.', 3, 2, '2026-11-07 18:00:00', '2026-11-07 18:00:00');

INSERT IGNORE INTO `instructions` (`instruction_id`, `step_number`, `description`, `recipe_id`) VALUES
    (1, 1, 'Combine oats and milk in a saucepan.', 1),
    (2, 2, 'Cook over medium heat until creamy, then top with banana and blueberries.', 1),
    (3, 1, 'Cook brown rice according to the package directions.', 2),
    (4, 2, 'Season and cook the chicken until it reaches 165 F internally.', 2),
    (5, 3, 'Steam broccoli and serve everything in bowls with soy sauce.', 2),
    (6, 1, 'Toast the bread and mash the avocado with salt and pepper.', 3),
    (7, 2, 'Spread avocado on toast and top with sliced tomato.', 3),
    (8, 1, 'Cook spaghetti until al dente and reserve a little pasta water.', 4),
    (9, 2, 'Saute garlic in olive oil, then toss with pasta, parmesan, and pasta water.', 4);

INSERT IGNORE INTO `recipe_ingredients`
    (`recipe_id`, `ingredient_id`, `quantity`, `is_opitional`, `unit_id`)
VALUES
    (1, 1, 1.00, 0, 3), (1, 2, 2.00, 0, 3), (1, 3, 1.00, 0, 6), (1, 4, 0.50, 1, 3),
    (2, 5, 1.50, 0, 4), (2, 6, 2.00, 0, 3), (2, 7, 2.00, 0, 3), (2, 10, 2.00, 0, 2),
    (3, 12, 2.00, 0, 6), (3, 13, 1.00, 0, 6), (3, 14, 1.00, 1, 6), (3, 16, 0.25, 0, 1),
    (4, 18, 12.00, 0, 4), (4, 8, 2.00, 0, 2), (4, 9, 2.00, 0, 6), (4, 17, 0.50, 0, 3);

INSERT IGNORE INTO `recipe_images` (`images_id`, `recipe_id`, `image_url`, `is_cover`, `display_order`) VALUES
    (1, 1, 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf', 1, 1),
    (2, 2, 'https://images.unsplash.com/photo-1547592180-85f173990554', 1, 1),
    (3, 3, 'https://images.unsplash.com/photo-1603046891744-76e6300f6a4e', 1, 1),
    (4, 4, 'https://images.unsplash.com/photo-1551892374-ecf8754cf8b0', 1, 1);

INSERT IGNORE INTO `tags` (`tag_id`, `name`) VALUES
    (1, 'quick'),
    (2, 'vegetarian'),
    (3, 'high-protein'),
    (4, 'breakfast'),
    (5, 'weeknight');

INSERT IGNORE INTO `recipe_tags` (`tag_id`, `recipe_id`) VALUES
    (1, 1), (4, 1), (1, 3), (2, 3), (3, 2), (5, 2), (1, 4), (2, 4), (5, 4);

INSERT IGNORE INTO `recipe_permissions` (`recipe_id`, `user_id`, `type`) VALUES
    (3, 1, 'view'),
    (3, 3, 'edit'),
    (1, 2, 'view');

INSERT IGNORE INTO `pantries` (`pantry_id`, `name`, `user_id`) VALUES
    (1, 'Alice''s Kitchen', 1),
    (2, 'Brandon''s Kitchen', 2);

INSERT IGNORE INTO `pantry_items`
    (`pantry_item_id`, `pantry_id`, `ingredient_id`, `quantity`, `expiration_date`, `unit_id`)
VALUES
    (1, 1, 1, 3.00, '2027-01-15', 3),
    (2, 1, 2, 2.00, '2026-12-01', 3),
    (3, 1, 6, 4.00, '2027-04-01', 3),
    (4, 1, 7, 2.00, '2026-11-27', 3),
    (5, 2, 8, 1.00, '2027-06-01', 6),
    (6, 2, 11, 12.00, '2026-12-05', 6),
    (7, 2, 18, 500.00, '2027-02-01', 4);

INSERT IGNORE INTO `meal_plans` (`meal_plan_id`, `week_start_date`, `user_id`) VALUES
    (1, '2026-11-23', 1),
    (2, '2026-11-23', 2);

INSERT IGNORE INTO `scheduled_meals`
    (`scheduled_meal_id`, `recipe_id`, `meal_plan_id`, `meal_date`, `servings`, `meal_id`)
VALUES
    (1, 1, 1, '2026-11-23', 2, 1),
    (2, 2, 1, '2026-11-24', 4, 3),
    (3, 3, 1, '2026-11-25', 2, 1),
    (4, 4, 2, '2026-11-24', 3, 3),
    (5, 2, 2, '2026-11-26', 4, 3);

INSERT IGNORE INTO `shopping_lists`
    (`shopping_list_id`, `user_id`, `meal_plan_id`, `created_at`, `updated_at`)
VALUES
    (1, 1, 1, '2026-11-21 09:00:00', '2026-11-21 09:00:00'),
    (2, 2, 2, '2026-11-21 09:15:00', '2026-11-21 09:15:00');

INSERT IGNORE INTO `shopping_list_items`
    (`shopping_list_item_id`, `shopping_list_id`, `ingredient_id`, `quantity_needed`, `quantity_in_pantry`, `quantity_to_buy`, `checked`, `unit_id`)
VALUES
    (1, 1, 5, 2, 0, 2, 0, 4),
    (2, 1, 3, 4, 0, 4, 0, 6),
    (3, 1, 4, 1, 0, 1, 0, 3),
    (4, 1, 10, 2, 0, 2, 1, 2),
    (5, 2, 7, 2, 0, 2, 0, 3),
    (6, 2, 17, 1, 0, 1, 0, 3);

SET FOREIGN_KEY_CHECKS = 1;
