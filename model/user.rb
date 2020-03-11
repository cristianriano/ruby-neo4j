# frozen_string_literal: true

module Model
  class User < Dry::Struct
    attribute :id, Types::Strict::String
    attribute :guid, Types::Strict::String
    attribute :private, Types::Strict::Bool
  end
end
