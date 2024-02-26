class Level < ApplicationRecord
  belongs_to :levelable, polymorphic: true

  def increment_points(points)
    updated_points = self.points + points
    update(points: updated_points)
    level_up if updated_points >= next_level_threshold
  end

  def next_level_threshold
    100 * lvl
  end

  def remaining_points
    return 0 if points.zero?

    next_level_threshold - points
  end

  private

  def level_up
    points_required = next_level_threshold

    # Keep leveling up until remaining points are less than points required for the next level
    while points >= points_required
      update(lvl: lvl + 1)
      remaining_points = points - points_required
      update(points: remaining_points)
      points_required = next_level_threshold
    end
  end
end
