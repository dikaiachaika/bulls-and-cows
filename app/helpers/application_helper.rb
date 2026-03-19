module ApplicationHelper
  def game_display_number(game, user = current_user)
    Game.where(user_id: user.id)
      .where("id <= ?", game.id)
      .count
  end
end