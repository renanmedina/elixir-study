defmodule GuessTheNumberGame do
  import IO

  @guesses_for_difficulty [easy: 10, medium: 7, hard: 4]
  @available_guesses 0

  defp request_guess() do
    user_guess = IO.gets("Your guess: ")
  end

  defp request_difficulty() do
    "Select a difficulty: " |> puts
    "1 - Easy (#{@guesses_for_difficulty[:easy]} guesses)" |> puts
    "2 - Medium (#{@guesses_for_difficulty[:medium]} guesses)" |> puts
    "3 - Hard (#{@guesses_for_difficulty[:hard]} guesses)" |> puts
    ## IO.gets usually return with an trailing \n, so we can use pattern matching to ignore it
    {difficulty_option, _} = IO.gets("(Choose difficulty): ") |> Integer.parse
    difficulty_option |> puts
    case difficulty_option do
      difficulty when difficulty in [1, 2, 3] ->
        set_difficulty(difficulty)
        request_guess()
      _ ->
        difficulty_option = 0
        String.duplicate("-", 100) |> puts
        "ERROR: difficulty not available, choose between the available ones (1 - Easy, 2 - Medium, 3 - Hard)" |> puts
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
    String.duplicate("#", 100) |> puts
    "#  Guess The Number Game" |> puts
    String.duplicate("#", 100) |> puts
    request_difficulty()
  end
end

GuessTheNumberGame.run()
