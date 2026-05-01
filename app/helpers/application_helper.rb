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

  def format_seconds(total_seconds)
    return "00:00" if total_seconds.nil? || total_seconds == 0
    
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
    
    if hours > 0
      format("%02d:%02d:%02d", hours, minutes, seconds)
    else
      format("%02d:%02d", minutes, seconds)
    end
  end

end