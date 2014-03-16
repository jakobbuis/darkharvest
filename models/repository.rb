require 'active_record'

class Repository < ActiveRecord::Base

    def self.random n = 100
        order('RAND()').limit(n)
    end

    def self.known
        where.not(classification: :unknown)
    end

    def self.unknown
        where(classification: :unknown)
    end
end
