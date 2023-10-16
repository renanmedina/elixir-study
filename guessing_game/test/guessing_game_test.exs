defmodule GuessingGameTest do
  use ExUnit.Case

  doctest GuessingGame

  test "Target number is smaller than user guess" do
    assert GuessingGame.check_guess(500, 250) == [:error, "The target number is smaller than 500"]
  end

  test "Target number is bigger than user guess" do
    assert GuessingGame.check_guess(250, 546) == [:error, "The target number is bigger than 250"]
  end

  test "Target number is equal to user guess" do
    assert GuessingGame.check_guess(120, 120) == :ok
  end

  test "User still has available guesses: returns :continue atom" do
    result = GuessingGame.take_guess(232, 500, 5)
    assert result |> List.first == :continue
  end

  test "User still has available guesses: should decrease available guesses" do
    result = GuessingGame.take_guess(232, 500, 5)
    assert result |> List.last == 4
  end

  test "User used all available guesses" do
    result = GuessingGame.take_guess(232, 500, 1)
    assert result |> List.first == :guesses_unavailable
  end
end
