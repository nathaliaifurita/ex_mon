defmodule ExMon.Game.Status do
    alias ExMon.Game

    def print_rount_message() do
        IO.puts("======The game is started!======\n")
        IO.inspect(Game.info())
        IO.puts("-------------------------\n")
    end
end