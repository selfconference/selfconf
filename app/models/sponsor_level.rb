class SponsorLevel < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :sponsors

  default_scope -> { order("#{table_name}.order ASC") }
end
