using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class ShoppingListItem
{
    public int ShoppingListItemId { get; set; }

    public int ShoppingListId { get; set; }

    public int IngredientId { get; set; }

    public int QuantityNeeded { get; set; }

    public int? QuantityInPantry { get; set; }

    public int? QuantityToBuy { get; set; }

    public sbyte Checked { get; set; }

    public int UnitId { get; set; }

    public virtual Ingredient Ingredient { get; set; } = null!;

    public virtual ShoppingList ShoppingList { get; set; } = null!;

    public virtual Unit Unit { get; set; } = null!;
}
