using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class RecipeImage
{
    public int ImagesId { get; set; }

    public int RecipeId { get; set; }

    public string ImageUrl { get; set; } = null!;

    public sbyte IsCover { get; set; }

    public int DisplayOrder { get; set; }

    public virtual Recipe Recipe { get; set; } = null!;
}
