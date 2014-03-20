require 'active_record'

class Contributor < ActiveRecord::Base

    has_and_belongs_to_many :repositories

    # Return all eclipse developers which work on another IDE too
    def self.multihomers
        includes(:repositories).where(repositories: {classification: [:sublime, :visualstudio, :vim, :aptana, :intellij, :textmate]})
    end
end
