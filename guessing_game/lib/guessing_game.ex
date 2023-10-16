defmodule GuessingGame do
  import IO

  @guesses_for_difficulty %{
    # [guesses, max_target_value]
    :easy => [25, 100],
    :medium => [15, 1000],
    :hard => [8, 10_000]
  }

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
        String.duplicate("-", 100) |> puts
        "ERROR: difficulty not available, choose between the available ones (1 - Easy, 2 - Medium, 3 - Hard)" |> puts
        request_and_apply_difficulty()
    end
  end

  defp set_difficulty(difficulty) do
    case difficulty do
      op when op in[1, :easy] -> @guesses_for_difficulty.easy
      op when op in[2, :medium] -> @guesses_for_difficulty.medium
      op when op in[3, :hard] -> @guesses_for_difficulty.hard
    end
  end

  def print_header() do
    String.duplicate("#", 100) |> puts
    "#  Guess The Number Game" |> puts
    String.duplicate("#", 100) |> puts
  end

  def check_guess(user_guess, answer) do
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

  def take_guess(user_guess, answer, guesses_available) do
    case check_guess(user_guess, answer) do
      :ok ->
        msg = String.duplicate("-", 100) <> "\r\n🎉🎉🎉 Congratulations!!!! You found the target number: #{answer} 🎉🎉🎉\r\n" <> String.duplicate("-", 100)
        [:ok, msg]
      [:error, message] ->
        case guesses_available - 1 do
          guesses when guesses > 0 -> [:continue, guesses]
          _ ->
            msg = String.duplicate("-", 100) <> "⚠ Ops!!!! You don't have any more guesses available ⚠"
            [:guesses_unavailable, msg]
        end
    end
  end

  defp play_game(guesses_available, answer) do
    print_remaining_guesses(guesses_available)
    user_guess = request_guess()
    case take_guess(user_guess, answer, guesses_available) do
      [:continue, guesses_left] -> play_game(guesses_left, answer)
      [_, message] -> message |> puts
    end
  end

  def run() do
    print_header()
    [guesses_available, target_number] = request_and_apply_difficulty()
    play_game(guesses_available, target_number)
  end
end
