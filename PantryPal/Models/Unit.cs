using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class Unit
{
    public int UnitId { get; set; }

    public string Unit1 { get; set; } = null!;

    public string UnitSymbol { get; set; } = null!;

    public virtual ICollection<PantryItem> PantryItems { get; set; } = new List<PantryItem>();

    public virtual ICollection<RecipeIngredient> RecipeIngredients { get; set; } = new List<RecipeIngredient>();

    public virtual ICollection<ShoppingListItem> ShoppingListItems { get; set; } = new List<ShoppingListItem>();
}
