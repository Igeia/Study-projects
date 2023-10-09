Arrow arrow = GetArrow(); //Step 8
Console.WriteLine($"Let's see... That'll be {arrow.GetCost()} gold."); //Step 9

Arrow GetArrow() //Step 6
{
    Arrowhead arrowhead = GetArrowhead();
    Fletching fletching = GetFletching();
    float length = GetLength();

    return new Arrow(arrowhead, fletching, length); // Step 7
}

float GetLength()
{
    Console.WriteLine("How long should I make an arrow? 60 cm is a starting point, mind you, 5 pieces/cm.");
    int length = int.Parse(Console.ReadLine());
    while (true)
    {
        if (length >= 60 && length <= 100) return length;
        else
        {
            Console.WriteLine("Can't make an arrow like that. Pick another length.");
            continue;
        }
    }
} //GetLength, GetFletching, and GetArrowhead are all step 4
Fletching GetFletching()
{
    Console.WriteLine("Enter the fletching type. Plastic, turkey feathers, goose?");
    string input = Console.ReadLine();
    return input switch
    {
        "plastic" => Fletching.Plastic,
        "turkey feathers" => Fletching.Turkey,
        "goose" => Fletching.Goose
    };
}
Arrowhead GetArrowhead()
{
    Console.WriteLine("Enter the arrowhead type. Steel, wood, obsidian?");
    string input = Console.ReadLine();
    return input switch
    {
        "steel" => Arrowhead.Steel,
        "wood" => Arrowhead.Wood,
        "obsidian" => Arrowhead.Obsidian
    };
}

public class Arrow //Step 2
{
    private Arrowhead arrowhead;
    private Fletching fletching;
    private float length;

    public Arrowhead GetArrowhead() => arrowhead;
    public Fletching GetFletching() => fletching;
    public float GetLength() => length;

    public Arrow(Arrowhead arrowhead, Fletching fletching, float length) //Step 3
    {
        this.arrowhead = arrowhead;
        this.fletching = fletching;
        this.length = length;
    }

    public float GetCost() //Step 5
    {
        float arrowheadCost = arrowhead switch
        {
            Arrowhead.Steel => 10,
            Arrowhead.Wood => 3,
            Arrowhead.Obsidian => 5
        };

        float fletchingCost = fletching switch
        {
            Fletching.Plastic => 10,
            Fletching.Turkey => 5,
            Fletching.Goose => 3
        };

        float shaftCost = 0.05f * length;
        return arrowheadCost + fletchingCost + shaftCost;
    }
}

public enum Arrowhead { Steel, Wood, Obsidian } //Step 1
public enum Fletching { Plastic, Turkey, Goose}

/*Steps to create a new Arrow object:
 * 1) Create enums holding appropriate values;
 * 2) Create a class that'll hold all the necessary data, like private fields for stuff not allowed to be messed with (no extraneous data and methods, though, like getting arrowheads, etc.);
 * 3) Create a parameterized constructor that'll help parse (and receive) relevant data to and from our future methods;
 * 4) Make new methods that use our enums to assign values to the relevant fields;
 * 5) Make a new method inside the class that handles all the gathered data from user input and assigns it relevant values (here, it's prices for various parts of an arrow, the GetCost() method);
 * 6) Using the class and a custom method, we get a new Arrow object. Inside this method, use public fields to assign them the values we got from user input;
 * 7) Return a new object using class(fields-acting-as-parameters);
 * 8) Instantiate a brand new Arrow;
 * 9) Get the price of our new arrow using the method for getting the prices for each individual piece.