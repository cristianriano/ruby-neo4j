# frozen_string_literal: true

require "neo4j/core/cypher_session/adaptors/bolt"
require_relative "./neo4j_base"

module Connection
  class Neo4jBolt < Neo4jBase
    class << self
      def session
        @@session ||= Neo4j::Core::CypherSession.new(adaptor)
      end

      private

      def adaptor
        Neo4j::Core::CypherSession::Adaptors::Bolt.new("bolt://neo4j:pass@localhost:7687", options)
      end

      def options
        super.merge(
          connect_timeout: 10
        )
      end
    end
  end
end
