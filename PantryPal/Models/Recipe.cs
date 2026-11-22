using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class Recipe
{
    public int RecipeId { get; set; }

    public string Name { get; set; } = null!;

    public string Visibility { get; set; } = null!;

    public int? PrepTimeMinutes { get; set; }

    public int? CookTimeMinutes { get; set; }

    public string? Description { get; set; }

    public int BaseServings { get; set; }

    public int OwnerId { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public virtual ICollection<Instruction> Instructions { get; set; } = new List<Instruction>();

    public virtual User Owner { get; set; } = null!;

    public virtual ICollection<RecipeImage> RecipeImages { get; set; } = new List<RecipeImage>();

    public virtual ICollection<RecipeIngredient> RecipeIngredients { get; set; } = new List<RecipeIngredient>();

    public virtual ICollection<RecipePermission> RecipePermissions { get; set; } = new List<RecipePermission>();

    public virtual ICollection<ScheduledMeal> ScheduledMeals { get; set; } = new List<ScheduledMeal>();

    public virtual ICollection<Tag> Tags { get; set; } = new List<Tag>();
}
