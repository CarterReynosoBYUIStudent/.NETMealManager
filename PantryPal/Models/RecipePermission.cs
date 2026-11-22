using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class RecipePermission
{
    public int RecipeId { get; set; }

    public int UserId { get; set; }

    public string Type { get; set; } = null!;

    public virtual Recipe Recipe { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
