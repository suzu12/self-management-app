class Tag < ApplicationRecord
  has_many :team_tag_relations
  has_many :teams, through: :team_tag_relations

  validates :name, uniqueness: true
end
