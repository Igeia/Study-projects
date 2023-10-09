LevelAndRandomNumber LevelAndNumber = new();

Console.WriteLine("You are standing at the bottom of the tower, at level 1. Press enter to continue.");
Console.ReadKey();
while (true)
{
    if (LevelAndNumber.GeneratedRandomNumber() >= LevelAndNumber.CurrentLevel)
    {
        LevelAndNumber.IncreaseLevel();
        Console.WriteLine($"Next floor: {LevelAndNumber.CurrentLevel}. Rolled: {LevelAndNumber.CurrentRandomNumber}");
        Console.ReadKey();
    }

    if (LevelAndNumber.GeneratedRandomNumber() < LevelAndNumber.CurrentLevel)
    {
        LevelAndNumber.DecreaseLevel();
        Console.WriteLine($"Back up to level {LevelAndNumber.CurrentLevel}. Rolled: {LevelAndNumber.CurrentRandomNumber}");
        Console.ReadKey();
    }

    if (LevelAndNumber.CurrentLevel == 100)
    {
        Console.WriteLine("You're at the top of the tower. Press enter to leave the tower.");
        Console.ReadKey();
        break;
    }
}

//A class to act as an object that handles the necessary in-game logic for randomizing die throws
class LevelAndRandomNumber
{
    private int level = 1;
    private int randomNumber;
    private static readonly object syncLock = new object(); //Create the syncLock object to ensure thread safety
    private static readonly Random random = new Random();

    //Public methods and getters
    public int CurrentLevel
    {
        get { return level; }
    }
    public int CurrentRandomNumber
    {
        get { return randomNumber; }
    }
    public int IncreaseLevel() => LevelUp();
    public int DecreaseLevel() => LevelDown();
    public int GeneratedRandomNumber()
    {
        lock (syncLock) //Synchronize
        {
            return Randomized();
        }
    }

    //Private methods
    private int LevelUp()
    {
        this.level += 1;
        return level;
    }
    private int LevelDown()
    {
        if (this.level != 1) this.level -= 1;
        return level;
    }
    private int Randomized()
    {
        this.randomNumber = random.Next(1, 100);
        return this.randomNumber;
    }
}
