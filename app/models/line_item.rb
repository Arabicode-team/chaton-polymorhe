class LineItem < ApplicationRecord
  belongs_to :itemable, polymorphic: true
  belongs_to :photo
end
