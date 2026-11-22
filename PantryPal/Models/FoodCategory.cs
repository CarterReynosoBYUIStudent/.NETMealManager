using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class FoodCategory
{
    public int FoodCategoryId { get; set; }

    public string Category { get; set; } = null!;

    public virtual ICollection<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
}
