module LeaderboardsHelper
  def rankings_color(index)
    case index
    when 1
      "bg-gold"
    when 2
      "bg-darkStone"
    when 3
      "bg-ivory"
    else
      "bg-indigo-800"
    end
  end
end
