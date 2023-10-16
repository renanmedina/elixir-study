defmodule GuessTheNumberGame do
  import IO

  @guesses_for_difficulty [
    easy: 25,
    medium: 15,
    hard: 8
  ]

  defp request_guess() do
    {user_input, _} = IO.gets("Your guess: ") |> Integer.parse
    user_input
    # case user_input do
    #   guess when guess > 0 ->
    #     {guess, _} = user_input |> Integer.parse
    #     guess
    #   :error ->
    #     String.duplicate("-", 100) |> puts
    #     "ERROR: Invalid input provided, please provide a number as a guess" |> puts
    #     request_guess()
    # end
  end

  defp request_and_apply_difficulty() do
    "Select a difficulty: " |> puts
    "1 - Easy (#{@guesses_for_difficulty[:easy]} guesses)" |> puts
    "2 - Medium (#{@guesses_for_difficulty[:medium]} guesses)" |> puts
    "3 - Hard (#{@guesses_for_difficulty[:hard]} guesses)" |> puts
    ## IO.gets usually return with an trailing \n, so we can use pattern matching to ignore it
    {difficulty_option, _} = IO.gets("(Choose difficulty): ") |> Integer.parse
    case difficulty_option do
      difficulty when difficulty in [1, 2, 3] ->
        set_difficulty(difficulty)
      _ ->
        difficulty_option = 0
        String.duplicate("-", 100) |> puts
        "ERROR: difficulty not available, choose between the available ones (1 - Easy, 2 - Medium, 3 - Hard)" |> puts
        request_and_apply_difficulty()
    end
  end

  defp set_difficulty(difficulty) do
    case difficulty do
      1 -> @guesses_for_difficulty[:easy]
      2 -> @guesses_for_difficulty[:medium]
      3 -> @guesses_for_difficulty[:hard]
    end
  end

  def print_header() do
    String.duplicate("#", 100) |> puts
    "#  Guess The Number Game" |> puts
    String.duplicate("#", 100) |> puts
  end

  defp check_guess(user_guess, answer) do
    case user_guess do
      guess when answer > guess  ->
        [:error, "The target number is bigger than #{guess}"]
      guess when answer < guess ->
        [:error, "The target number is smaller than #{guess}"]
      guess when guess == answer ->
        :ok
    end
  end

  defp print_remaining_guesses(guesses) do
    "You have #{guesses} guesses available" |> puts
  end

  defp game_loop(guesses_available, answer) do
    print_remaining_guesses(guesses_available)
    user_guess = request_guess()
    case check_guess(user_guess, answer) do
      :ok ->
        String.duplicate("-", 100) |> puts
        "🎉🎉🎉 Congratulations!!!! You found the target number: #{answer} 🎉🎉🎉" |> puts
        String.duplicate("-", 100) |> puts
      [:error, message] ->
        message |> puts
        guesses_available = guesses_available - 1
        if guesses_available > 0 do
          game_loop(guesses_available, answer)
        end
    end
  end

  def run() do
    range_max = 10_000
    answer = :rand.uniform(range_max)
    "Target number: #{answer}" |> puts
    print_header()
    guesses_available = request_and_apply_difficulty()
    game_loop(guesses_available, answer)
  end
end

GuessTheNumberGame.run()
