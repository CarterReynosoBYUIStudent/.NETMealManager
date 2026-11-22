using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class Ingredient
{
    public int IngredientId { get; set; }

    public string Name { get; set; } = null!;

    public decimal? GramsInTeaspoon { get; set; }

    public virtual ICollection<PantryItem> PantryItems { get; set; } = new List<PantryItem>();

    public virtual ICollection<RecipeIngredient> RecipeIngredients { get; set; } = new List<RecipeIngredient>();

    public virtual ICollection<ShoppingListItem> ShoppingListItems { get; set; } = new List<ShoppingListItem>();

    public virtual ICollection<FoodCategory> FoodCategories { get; set; } = new List<FoodCategory>();
}
