using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class MealPlan
{
    public int MealPlanId { get; set; }

    public DateOnly WeekStartDate { get; set; }

    public int UserId { get; set; }

    public virtual ICollection<ScheduledMeal> ScheduledMeals { get; set; } = new List<ScheduledMeal>();

    public virtual ICollection<ShoppingList> ShoppingLists { get; set; } = new List<ShoppingList>();

    public virtual User User { get; set; } = null!;
}
