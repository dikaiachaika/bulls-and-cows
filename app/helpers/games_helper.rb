module GamesHelper
  def digit_phrase(count)
    word = case count
    when 3, 4 then "цифры"
    else "цифр"
    end
    
    different = case count
    when 3, 4 then "разные"
    else "разных"
    end
    
    { word: word, different: different }
  end
end