defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game

  @move_avg_power 18..25
  @move_rn_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent)
  end

  defp calculate_power(:move_avg), do: Enum.random(@move_avg_power)
  defp calculate_power(:move_rnd), do: Enum.random(@move_rn_power)

  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent) do
    opponent
    |> Game.fetch_player() #vai pegar o struct de um player: computer ou player
    |> Map.put(:life, life) #Map.put vai atualizar e retorna um novo com o valor atualizado
    |> update_game(opponent) #atualiza ou computador ou no player a nova struct com o novo valor de vida
  end

  defp update_game(player, opponent) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()
  end
end
