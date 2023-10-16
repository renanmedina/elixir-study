defmodule GuessTheNumberGame do
  @guesses_for_difficulty [easy: 10, medium: 7, hard: 4]
  @available_guesses 0

  defp request_guess() do
    user_guess = IO.gets("Your guess: ")
  end

  defp request_difficulty() do
    "Select a difficulty: " |> IO.puts
    "1 - Easy (#{@guesses_for_difficulty[:easy]} guesses)" |> IO.puts
    "2 - Medium (#{@guesses_for_difficulty[:medium]} guesses)" |> IO.puts
    "3 - Hard (#{@guesses_for_difficulty[:hard]} guesses)" |> IO.puts
    ## IO.gets usually return with an trailing \n, so we can use pattern matching to ignore it
    {difficulty_option, _} = IO.gets("(Choose difficulty): ") |> Integer.parse
    difficulty_option |> IO.puts
    case difficulty_option do
      difficulty when difficulty in [1, 2, 3] ->
        set_difficulty(difficulty)
        request_guess()
      _ ->
        difficulty_option = 0
        String.duplicate("-", 100) |> IO.puts
        "ERROR: difficulty not available, choose between the available ones (1 - Easy, 2 - Medium, 3 - Hard)" |> IO.puts
        request_difficulty()
    end
  end

  defp set_difficulty(difficulty) do
    case difficulty do
      1 -> @available_guesses = @guesses_for_difficulty[:easy]
      2 -> @available_guesses = @guesses_for_difficulty[:medium]
      3 -> @available_guesses = @guesses_for_difficulty[:hard]
    end
  end

  def run() do
    range_max = 1_000_000
    answer = :rand.uniform(range_max)
    IO.puts(String.duplicate("#", 100))
    IO.puts("#  Guess The Number Game")
    IO.puts(String.duplicate("#", 100))
    request_difficulty()
  end
end

GuessTheNumberGame.run()
