# frozen_string_literal: true

require "receptacle"
require_relative "./user/strategy/neo4j"

module Repository
  module User
    include Receptacle::Repo

    mediate :create

    strategy Strategy::Neo4j
  end
end
