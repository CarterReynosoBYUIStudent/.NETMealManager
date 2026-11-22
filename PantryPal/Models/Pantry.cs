using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class Pantry
{
    public int PantryId { get; set; }

    public string Name { get; set; } = null!;

    public int UserId { get; set; }

    public virtual ICollection<PantryItem> PantryItems { get; set; } = new List<PantryItem>();

    public virtual User User { get; set; } = null!;
}
