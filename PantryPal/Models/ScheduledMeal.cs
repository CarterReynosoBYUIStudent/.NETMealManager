using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class ScheduledMeal
{
    public int ScheduledMealId { get; set; }

    public int RecipeId { get; set; }

    public int MealPlanId { get; set; }

    public DateOnly MealDate { get; set; }

    public int Servings { get; set; }

    public int MealId { get; set; }

    public virtual Meal Meal { get; set; } = null!;

    public virtual MealPlan MealPlan { get; set; } = null!;

    public virtual Recipe Recipe { get; set; } = null!;
}
