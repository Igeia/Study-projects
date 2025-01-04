int   cityConsolasHealth = 15,
      enemyMantricoreHealth = 10,
      roundNumber = 1;

Console.Write("Player 1, how far away from the city do you want to station the Manticore? Pick a number from 0 to 100. ");
int enemyDislocation = int.Parse(Console.ReadLine());

Console.Clear();
Console.WriteLine("Your turn, Player 2.");

GameLoop();

int BasicInfo()
{
    Console.ForegroundColor = ConsoleColor.White;
  
    Console.Write($"STATUS: Round: {roundNumber},  City: {cityConsolasHealth}/15,  Manticore: {enemyMantricoreHealth}/10");
  
    Console.WriteLine($"\nThe canon is expected to deal {CanonDamage()} damage this round.");
    DesiredRangeAttack();

    return 1;
}

int CanonDamage()
{
    int   damageOutput, 
          damageOutputNormal = 1, 
          damageOutputFire = 3, 
          damageOutputCombined = 10;

    if (roundNumber % 15 == 0) return damageOutputCombined;

    if (roundNumber % 3 == 0 || roundNumber % 5 == 0)
      return damageOutputFire;

    else damageOutput = damageOutputNormal;

    return damageOutput;
}

int DesiredRangeAttack()
{
    Console.Write("Enter desired canon range: ");

    int guessToAttack = int.Parse(Console.ReadLine());

    if (guessToAttack < enemyDislocation)
    {
        Console.ForegroundColor = ConsoleColor.Cyan;
        Console.WriteLine("You FELL SHORT of the target!");
      
        cityConsolasHealth--;
    }

    else if (guessToAttack > enemyDislocation)
    {
        Console.ForegroundColor = ConsoleColor.Blue;
        Console.WriteLine("You OVERSHOT the target!");
      
        cityConsolasHealth--;
    }

    else
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine("DIRECT HIT!");
      
        enemyMantricoreHealth = enemyMantricoreHealth - CanonDamage();
        cityConsolasHealth--;
    }

    return 1;
}

int GameLoop()
{
    while (true)
    {
        Console.WriteLine("---------------------------------------------------");
        BasicInfo();

        roundNumber++;

        if (enemyMantricoreHealth <= 0)
        {
            Console.WriteLine("You've defeated the Manticore!");
            return 1;
        }

        if (cityConsolasHealth <= 0)
        {
            Console.WriteLine("The Uncoded One has destroyed Consolas. Game over.");
            return 1;
        }    
    }
}
