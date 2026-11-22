using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class Meal
{
    public int MealId { get; set; }

    public string Meal1 { get; set; } = null!;

    public virtual ICollection<ScheduledMeal> ScheduledMeals { get; set; } = new List<ScheduledMeal>();
}
