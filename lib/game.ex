defmodule ExMon.Game do
  alias ExMon.Player
  use Agent

  def start(computer, player) do
    initial_vale = %{
      computer: computer,
      player: player,
      turn: :player,
      status: :started
    }

    Agent.start_link(fn -> initial_vale end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  # vai receber um estado e vai subscrever com a função update 
  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end

  def player, do: Map.get(info(), :player)
  def turn, do: Map.get(info(), :turn)
  def fetch_player(player), do: Map.get(info(), player)

  # pattern matching a chave player que é uma struct do tipo player, e a struct tem uma chave life
  defp update_game_status(%{
         player: %Player{life: player_life},
         computer: %Player{life: computer_life} = state
       })
       when player_life == 0 or computer_life == 0,
       do: Map.put(state, :status, :game_over)

  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn()
  end

  # do estado atual, eu vou mudar de player pra comp ou comp pra player
  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)
end
