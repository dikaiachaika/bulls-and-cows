module ApplicationHelper
  def game_display_number(game)
    Game.where("created_at <= ?", game.created_at).count
  end
end