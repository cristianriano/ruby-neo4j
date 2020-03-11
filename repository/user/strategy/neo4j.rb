# frozen_string_literal: true

require_relative "../../../connection/neo4j_http"
require_relative "../../../connection/neo4j_bolt"
require_relative "../../../model/user"

module Repository
  module User
    module Strategy
      class Neo4j
        def create(user)
          query.create(User: user.to_h).exec
          user
        rescue Neo4j::Core::CypherSession::SchemaErrors::ConstraintValidationFailedError
          raise Errors::EntityAlreadyExists.new(user)
        end

        def find(id)
          users = query.match(u: :User).where(u: { id: id }).return(:u).limit(1).pluck(:u)
          raise Errors::NotFound(id) if users.empty?
          Model::User.new(users.first.props)
        end

        private

        def query
          Connection::Neo4jHttp.query
        end
      end
    end
  end
end
