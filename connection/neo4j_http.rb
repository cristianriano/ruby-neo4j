# frozen_string_literal: true

require "neo4j/core/cypher_session/adaptors/http"
require "neo4j/core/cypher_session"

module Connection
  class Neo4jHttp
    class << self
      def session
        @@session ||= Neo4j::Core::CypherSession.new(adaptor)
      end

      private

      def adaptor
        Neo4j::Core::CypherSession::Adaptors::HTTP.new("http://neo4j:pass@localhost:7474", options)
      end

      def options
        {}
      end
    end
  end
end
