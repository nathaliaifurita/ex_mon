defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_rount_message() do
    IO.puts("\n======The game is started!======\n")
    IO.inspect(Game.info())
    IO.puts("-------------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n======Invalid move: #{move}!======\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n======The player attacked the computer dealing #{damage} damage. ======\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n======The computer attacked the player dealing #{damage} damage. ======\n")
  end
end
