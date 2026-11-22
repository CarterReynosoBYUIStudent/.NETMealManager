using System;
using System.Collections.Generic;

namespace PantryPal.Models;

public partial class Instruction
{
    public int InstructionId { get; set; }

    public int StepNumber { get; set; }

    public string Description { get; set; } = null!;

    public int RecipeId { get; set; }

    public virtual Recipe Recipe { get; set; } = null!;
}
