using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using PantryPal.Models;

namespace PantryPal.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<FoodCategory> FoodCategories { get; set; }

    public virtual DbSet<Ingredient> Ingredients { get; set; }

    public virtual DbSet<Instruction> Instructions { get; set; }

    public virtual DbSet<Meal> Meals { get; set; }

    public virtual DbSet<MealPlan> MealPlans { get; set; }

    public virtual DbSet<Pantry> Pantries { get; set; }

    public virtual DbSet<PantryItem> PantryItems { get; set; }

    public virtual DbSet<Recipe> Recipes { get; set; }

    public virtual DbSet<RecipeImage> RecipeImages { get; set; }

    public virtual DbSet<RecipeIngredient> RecipeIngredients { get; set; }

    public virtual DbSet<RecipePermission> RecipePermissions { get; set; }

    public virtual DbSet<ScheduledMeal> ScheduledMeals { get; set; }

    public virtual DbSet<ShoppingList> ShoppingLists { get; set; }

    public virtual DbSet<ShoppingListItem> ShoppingListItems { get; set; }

    public virtual DbSet<Tag> Tags { get; set; }

    public virtual DbSet<Unit> Units { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb3_general_ci")
            .HasCharSet("utf8mb3");

        modelBuilder.Entity<FoodCategory>(entity =>
        {
            entity.HasKey(e => e.FoodCategoryId).HasName("PRIMARY");

            entity.ToTable("food_categories");

            entity.Property(e => e.FoodCategoryId).HasColumnName("food_category_id");
            entity.Property(e => e.Category)
                .HasMaxLength(45)
                .HasColumnName("category");
        });

        modelBuilder.Entity<Ingredient>(entity =>
        {
            entity.HasKey(e => e.IngredientId).HasName("PRIMARY");

            entity.ToTable("ingredients");

            entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");
            entity.Property(e => e.GramsInTeaspoon)
                .HasPrecision(4, 2)
                .HasColumnName("grams_in_teaspoon");
            entity.Property(e => e.Name)
                .HasMaxLength(45)
                .HasColumnName("name");

            entity.HasMany(d => d.FoodCategories).WithMany(p => p.Ingredients)
                .UsingEntity<Dictionary<string, object>>(
                    "IngredientCategory",
                    r => r.HasOne<FoodCategory>().WithMany()
                        .HasForeignKey("FoodCategoryId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("fk_food_categories1"),
                    l => l.HasOne<Ingredient>().WithMany()
                        .HasForeignKey("IngredientId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("fk_ingredients1"),
                    j =>
                    {
                        j.HasKey("IngredientId", "FoodCategoryId")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.ToTable("ingredient_categories");
                        j.HasIndex(new[] { "FoodCategoryId" }, "fk_food_categories1_idx");
                        j.HasIndex(new[] { "IngredientId" }, "fk_ingredients1_idx");
                        j.IndexerProperty<int>("IngredientId").HasColumnName("ingredient_id");
                        j.IndexerProperty<int>("FoodCategoryId").HasColumnName("food_category_id");
                    });
        });

        modelBuilder.Entity<Instruction>(entity =>
        {
            entity.HasKey(e => e.InstructionId).HasName("PRIMARY");

            entity.ToTable("instructions");

            entity.HasIndex(e => e.RecipeId, "fk_recipes2_idx");

            entity.Property(e => e.InstructionId).HasColumnName("instruction_id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.RecipeId).HasColumnName("recipe_id");
            entity.Property(e => e.StepNumber).HasColumnName("step_number");

            entity.HasOne(d => d.Recipe).WithMany(p => p.Instructions)
                .HasForeignKey(d => d.RecipeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_recipes2");
        });

        modelBuilder.Entity<Meal>(entity =>
        {
            entity.HasKey(e => e.MealId).HasName("PRIMARY");

            entity.ToTable("meals");

            entity.Property(e => e.MealId).HasColumnName("meal_id");
            entity.Property(e => e.Meal1)
                .HasMaxLength(20)
                .HasColumnName("meal");
        });

        modelBuilder.Entity<MealPlan>(entity =>
        {
            entity.HasKey(e => e.MealPlanId).HasName("PRIMARY");

            entity.ToTable("meal_plans");

            entity.HasIndex(e => e.UserId, "fk_users3_idx");

            entity.Property(e => e.MealPlanId).HasColumnName("meal_plan_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.WeekStartDate).HasColumnName("week_start_date");

            entity.HasOne(d => d.User).WithMany(p => p.MealPlans)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_users3");
        });

        modelBuilder.Entity<Pantry>(entity =>
        {
            entity.HasKey(e => e.PantryId).HasName("PRIMARY");

            entity.ToTable("pantries");

            entity.HasIndex(e => e.UserId, "fk_users4_idx");

            entity.Property(e => e.PantryId).HasColumnName("pantry_id");
            entity.Property(e => e.Name)
                .HasMaxLength(45)
                .HasColumnName("name");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Pantries)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_users4");
        });

        modelBuilder.Entity<PantryItem>(entity =>
        {
            entity.HasKey(e => e.PantryItemId).HasName("PRIMARY");

            entity.ToTable("pantry_items");

            entity.HasIndex(e => e.IngredientId, "fk_ingredients3_idx");

            entity.HasIndex(e => e.PantryId, "fk_pantries1_idx");

            entity.HasIndex(e => e.UnitId, "fk_units2_idx");

            entity.Property(e => e.PantryItemId).HasColumnName("pantry_item_id");
            entity.Property(e => e.ExpirationDate).HasColumnName("expiration_date");
            entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");
            entity.Property(e => e.PantryId).HasColumnName("pantry_id");
            entity.Property(e => e.Quantity)
                .HasPrecision(5, 2)
                .HasColumnName("quantity");
            entity.Property(e => e.UnitId).HasColumnName("unit_id");

            entity.HasOne(d => d.Ingredient).WithMany(p => p.PantryItems)
                .HasForeignKey(d => d.IngredientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_ingredients3");

            entity.HasOne(d => d.Pantry).WithMany(p => p.PantryItems)
                .HasForeignKey(d => d.PantryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_pantries1");

            entity.HasOne(d => d.Unit).WithMany(p => p.PantryItems)
                .HasForeignKey(d => d.UnitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_units2");
        });

        modelBuilder.Entity<Recipe>(entity =>
        {
            entity.HasKey(e => e.RecipeId).HasName("PRIMARY");

            entity.ToTable("recipes");

            entity.HasIndex(e => e.OwnerId, "fk_users2_idx");

            entity.Property(e => e.RecipeId).HasColumnName("recipe_id");
            entity.Property(e => e.BaseServings).HasColumnName("base_servings");
            entity.Property(e => e.CookTimeMinutes).HasColumnName("cook_time_minutes");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp")
                .HasColumnName("created_at");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.OwnerId).HasColumnName("owner_id");
            entity.Property(e => e.PrepTimeMinutes).HasColumnName("prep_time_minutes");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp")
                .HasColumnName("updated_at");
            entity.Property(e => e.Visibility)
                .HasColumnType("enum('public','private','shared')")
                .HasColumnName("visibility");

            entity.HasOne(d => d.Owner).WithMany(p => p.Recipes)
                .HasForeignKey(d => d.OwnerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_users2");
        });

        modelBuilder.Entity<RecipeImage>(entity =>
        {
            entity.HasKey(e => e.ImagesId).HasName("PRIMARY");

            entity.ToTable("recipe_images");

            entity.HasIndex(e => e.RecipeId, "fk_recipes3_idx");

            entity.Property(e => e.ImagesId).HasColumnName("images_id");
            entity.Property(e => e.DisplayOrder).HasColumnName("display_order");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(2083)
                .HasColumnName("image_url");
            entity.Property(e => e.IsCover).HasColumnName("is_cover");
            entity.Property(e => e.RecipeId).HasColumnName("recipe_id");

            entity.HasOne(d => d.Recipe).WithMany(p => p.RecipeImages)
                .HasForeignKey(d => d.RecipeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_recipes3");
        });

        modelBuilder.Entity<RecipeIngredient>(entity =>
        {
            entity.HasKey(e => new { e.RecipeId, e.IngredientId })
                .HasName("PRIMARY")
                .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

            entity.ToTable("recipe_ingredients");

            entity.HasIndex(e => e.IngredientId, "fk_ingredients2_idx");

            entity.HasIndex(e => e.RecipeId, "fk_recipes1_idx");

            entity.HasIndex(e => e.UnitId, "fk_units1_idx");

            entity.Property(e => e.RecipeId).HasColumnName("recipe_id");
            entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");
            entity.Property(e => e.IsOpitional).HasColumnName("is_opitional");
            entity.Property(e => e.Quantity)
                .HasPrecision(5, 2)
                .HasColumnName("quantity");
            entity.Property(e => e.UnitId).HasColumnName("unit_id");

            entity.HasOne(d => d.Ingredient).WithMany(p => p.RecipeIngredients)
                .HasForeignKey(d => d.IngredientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_ingredients2");

            entity.HasOne(d => d.Recipe).WithMany(p => p.RecipeIngredients)
                .HasForeignKey(d => d.RecipeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_recipes1");

            entity.HasOne(d => d.Unit).WithMany(p => p.RecipeIngredients)
                .HasForeignKey(d => d.UnitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_units1");
        });

        modelBuilder.Entity<RecipePermission>(entity =>
        {
            entity.HasKey(e => new { e.RecipeId, e.UserId })
                .HasName("PRIMARY")
                .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

            entity.ToTable("recipe_permissions");

            entity.HasIndex(e => e.RecipeId, "fk_recipes_idx");

            entity.HasIndex(e => e.UserId, "fk_users1_idx");

            entity.Property(e => e.RecipeId).HasColumnName("recipe_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.Type)
                .HasColumnType("enum('view','edit')")
                .HasColumnName("type");

            entity.HasOne(d => d.Recipe).WithMany(p => p.RecipePermissions)
                .HasForeignKey(d => d.RecipeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_recipes");

            entity.HasOne(d => d.User).WithMany(p => p.RecipePermissions)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_users1");
        });

        modelBuilder.Entity<ScheduledMeal>(entity =>
        {
            entity.HasKey(e => e.ScheduledMealId).HasName("PRIMARY");

            entity.ToTable("scheduled_meals");

            entity.HasIndex(e => e.MealPlanId, "fk_meal_plans1_idx");

            entity.HasIndex(e => e.MealId, "fk_meals1_idx");

            entity.HasIndex(e => e.RecipeId, "fk_recipes5_idx");

            entity.Property(e => e.ScheduledMealId).HasColumnName("scheduled_meal_id");
            entity.Property(e => e.MealDate).HasColumnName("meal_date");
            entity.Property(e => e.MealId).HasColumnName("meal_id");
            entity.Property(e => e.MealPlanId).HasColumnName("meal_plan_id");
            entity.Property(e => e.RecipeId).HasColumnName("recipe_id");
            entity.Property(e => e.Servings).HasColumnName("servings");

            entity.HasOne(d => d.Meal).WithMany(p => p.ScheduledMeals)
                .HasForeignKey(d => d.MealId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_meals1");

            entity.HasOne(d => d.MealPlan).WithMany(p => p.ScheduledMeals)
                .HasForeignKey(d => d.MealPlanId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_meal_plans1");

            entity.HasOne(d => d.Recipe).WithMany(p => p.ScheduledMeals)
                .HasForeignKey(d => d.RecipeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_recipes5");
        });

        modelBuilder.Entity<ShoppingList>(entity =>
        {
            entity.HasKey(e => e.ShoppingListId).HasName("PRIMARY");

            entity.ToTable("shopping_lists");

            entity.HasIndex(e => e.MealPlanId, "fk_meal_plans2_idx");

            entity.HasIndex(e => e.UserId, "fk_users5_idx");

            entity.Property(e => e.ShoppingListId).HasColumnName("shopping_list_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp")
                .HasColumnName("created_at");
            entity.Property(e => e.MealPlanId).HasColumnName("meal_plan_id");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.MealPlan).WithMany(p => p.ShoppingLists)
                .HasForeignKey(d => d.MealPlanId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_meal_plans2");

            entity.HasOne(d => d.User).WithMany(p => p.ShoppingLists)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_users5");
        });

        modelBuilder.Entity<ShoppingListItem>(entity =>
        {
            entity.HasKey(e => e.ShoppingListItemId).HasName("PRIMARY");

            entity.ToTable("shopping_list_items");

            entity.HasIndex(e => e.IngredientId, "fk_ingredients4_idx");

            entity.HasIndex(e => e.ShoppingListId, "fk_shopping_lists1_idx");

            entity.HasIndex(e => e.UnitId, "fk_units3_idx");

            entity.Property(e => e.ShoppingListItemId).HasColumnName("shopping_list_item_id");
            entity.Property(e => e.Checked).HasColumnName("checked");
            entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");
            entity.Property(e => e.QuantityInPantry).HasColumnName("quantity_in_pantry");
            entity.Property(e => e.QuantityNeeded).HasColumnName("quantity_needed");
            entity.Property(e => e.QuantityToBuy).HasColumnName("quantity_to_buy");
            entity.Property(e => e.ShoppingListId).HasColumnName("shopping_list_id");
            entity.Property(e => e.UnitId).HasColumnName("unit_id");

            entity.HasOne(d => d.Ingredient).WithMany(p => p.ShoppingListItems)
                .HasForeignKey(d => d.IngredientId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_ingredients4");

            entity.HasOne(d => d.ShoppingList).WithMany(p => p.ShoppingListItems)
                .HasForeignKey(d => d.ShoppingListId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_shopping_lists1");

            entity.HasOne(d => d.Unit).WithMany(p => p.ShoppingListItems)
                .HasForeignKey(d => d.UnitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_units3");
        });

        modelBuilder.Entity<Tag>(entity =>
        {
            entity.HasKey(e => e.TagId).HasName("PRIMARY");

            entity.ToTable("tags");

            entity.Property(e => e.TagId).HasColumnName("tag_id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");

            entity.HasMany(d => d.Recipes).WithMany(p => p.Tags)
                .UsingEntity<Dictionary<string, object>>(
                    "RecipeTag",
                    r => r.HasOne<Recipe>().WithMany()
                        .HasForeignKey("RecipeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("fk_recipes4"),
                    l => l.HasOne<Tag>().WithMany()
                        .HasForeignKey("TagId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("fk_tags1"),
                    j =>
                    {
                        j.HasKey("TagId", "RecipeId")
                            .HasName("PRIMARY")
                            .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });
                        j.ToTable("recipe_tags");
                        j.HasIndex(new[] { "RecipeId" }, "fk_recipes4_idx");
                        j.HasIndex(new[] { "TagId" }, "fk_tags1_idx");
                        j.IndexerProperty<int>("TagId").HasColumnName("tag_id");
                        j.IndexerProperty<int>("RecipeId").HasColumnName("recipe_id");
                    });
        });

        modelBuilder.Entity<Unit>(entity =>
        {
            entity.HasKey(e => e.UnitId).HasName("PRIMARY");

            entity.ToTable("units");

            entity.Property(e => e.UnitId).HasColumnName("unit_id");
            entity.Property(e => e.Unit1)
                .HasMaxLength(15)
                .HasColumnName("unit");
            entity.Property(e => e.UnitSymbol)
                .HasMaxLength(4)
                .HasColumnName("unit_symbol");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PRIMARY");

            entity.ToTable("users");

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp")
                .HasColumnName("created_at");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .HasColumnName("password_hash");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(15)
                .HasColumnName("phone_number");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
