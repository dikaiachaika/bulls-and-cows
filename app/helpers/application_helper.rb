module ApplicationHelper
  def game_display_number(game, user = current_user)
    Game.where(user_id: user.id)
      .where("id <= ?", game.id)
      .count
  end


  def adaptive_placeholder
    if request.user_agent =~ /Mobile|webOS|iPhone|iPad|iPod|Android/i
      "Придумайте свой вопрос"
    else
      "Придумайте вопрос, ответ на который знаете только Вы"
    end
  end

end