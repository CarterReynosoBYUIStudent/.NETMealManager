using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class PantryItem
{
    public int PantryItemId { get; set; }

    public int PantryId { get; set; }

    public int IngredientId { get; set; }

    public decimal Quantity { get; set; }

    public DateOnly ExpirationDate { get; set; }

    public int UnitId { get; set; }

    public virtual Ingredient Ingredient { get; set; } = null!;

    public virtual Pantry Pantry { get; set; } = null!;

    public virtual Unit Unit { get; set; } = null!;
}
