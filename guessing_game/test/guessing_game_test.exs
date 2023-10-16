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
end
