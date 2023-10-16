defmodule GuessingGameTest do
  use ExUnit.Case

  doctest GuessingGame

  describe "When target number is smaller than user guess" do
    test "returns :error atom with smaller text" do
      assert GuessingGame.check_guess(500, 250) == [:error, "The target number is smaller than 500"]
    end
  end

  describe "When target number is bigger than user guess" do
    test "returns :error atom with bigger text" do
      assert GuessingGame.check_guess(250, 546) == [:error, "The target number is bigger than 250"]
    end
  end

  describe "When target number is equal to user guess" do
    test "returns :ok atom" do
      assert GuessingGame.check_guess(120, 120) == :ok
    end
  end

  describe "When user still has available guesses" do
    test "returns :continue atom" do
      result = GuessingGame.take_guess(232, 500, 5)
      assert result |> List.first == :continue
    end

    test "Decreases available guesses" do
      result = GuessingGame.take_guess(232, 500, 5)
      assert result |> List.last == 4
    end
  end

  describe "When user used all available guesses" do
    test "returns :guesses_unavailable atom" do
      result = GuessingGame.take_guess(232, 500, 1)
      assert result |> List.first == :guesses_unavailable
    end
  end
end
