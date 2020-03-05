# frozen_string_literal: true

require "neo4j/core/cypher_session/adaptors/http"
require "faraday"

Faraday.default_adapter =
  if RUBY_PLATFORM == "java"
    require "manticore"
    require "faraday/adapter/manticore"
    require "newrelic/manticore"
    :manticore
  else
    :net_http_persistent
  end

module Connection
  class Neo4jHttp < Neo4jBase
    class << self
      def session
        @@session ||= Neo4j::Core::CypherSession.new(adaptor)
      end

      private

      def adaptor
        Neo4j::Core::CypherSession::Adaptors::HTTP.new("http://neo4j:pass@localhost:7474", options)
      end

      def options
        super.merge(
          faraday_configurator: proc do |faraday|
            faraday.adapter Faraday.default_adapter
            # If you need to set options which would normally be the second argument of `Faraday.new`, you can do the following:
            faraday.options[:open_timeout] = 5
            faraday.options[:timeout] = 60
            # faraday.options[:ssl] = { verify: true }
          end
        )
      end
    end
  end
end
