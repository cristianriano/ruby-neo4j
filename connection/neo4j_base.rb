# frozen_string_literal: true

require "neo4j/core/cypher_session"

module Connection
  class Neo4jBase
    class << self
      def session
        raise NotImplemented.new("No session for #{self}")
      end

      private

      def options
        {
          logger: logger,
          skip_instrumentation: false, # Log queries, for testing
          verbose_query_logs: true
        }
      end

      def logger
        log_file = File.open("./log/#{self.name.split("::").last.downcase}", "a+")
        Logger.new(log_file)
      end
    end
  end
end
