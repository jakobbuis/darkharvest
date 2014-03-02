require 'active_record'

class Repository < ActiveRecord::Base

    scope :unclassified, -> { where(classification: nil) }
end
