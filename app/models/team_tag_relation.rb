class TeamTagRelation < ApplicationRecord
  belongs_to :team
  belongs_to :tag
end
