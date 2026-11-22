using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class ShoppingList
{
    public int ShoppingListId { get; set; }

    public int UserId { get; set; }

    public int MealPlanId { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public virtual MealPlan MealPlan { get; set; } = null!;

    public virtual ICollection<ShoppingListItem> ShoppingListItems { get; set; } = new List<ShoppingListItem>();

    public virtual User User { get; set; } = null!;
}
