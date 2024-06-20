# frozen_string_literal: true

# == Schema Information
#
# Table name: badges
#
# id                          :bigint                         not null, primary key
# rank                        :integer                        default(0)
#
# Indexes
#
# index_badges_on_user_id                                     (user_id)
#
# Foreign key
#
# fk_rails ... (user_id => user.id)
#

class Badge < ApplicationRecord
  include BuildAssociation
  belongs_to :user
  has_one :level, as: :levelable

  enum rank: %i[ninja master sensei legend]

  after_create :create_level

  BADGES = {
    ninja: "badges/ninja.png",
    master: "badges/master.png",
    sensei: "badges/sensei.png",
    legend: "badges/legend.png"
  }.freeze

  AVATARS = {
    ninja: "avatars/ninja.png",
    master: "avatars/master.png",
    sensei: "avatars/sensei.png",
    legend: "avatars/legend.png"
  }.freeze

  def create_level
    build_association_if_missing(:level)
  end

  def badges
    rank = user.badge.rank
    BADGES[rank.to_sym]
  end

  def avatars
    rank = user.badge.rank
    AVATARS[rank.to_sym]
  end

  def set_rank
    update(rank: level_rank)
  end

  def level_rank
    case level.lvl
    when 0..12
      :ninja
    when 13..24
      :master
    when 25..40
      :sensei
    when 41..50
      :legend
    end
  end

  def ninja?
    rank == "ninja"
  end

  def master?
    rank == "master"
  end

  def sensei?
    rank == "sensei"
  end

  def legend?
    rank == "legend"
  end

  private

  def level_lvl_updated?
    level.lvl_changed?
  end
end
