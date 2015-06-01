module Ost
  module Web
    def self.queue_names
      queues = []
      cursor = 0
      begin
        cursor, results = Ost.redis.call("SCAN", cursor, "match", "ost:*")
        queues += results
      end until cursor.to_i == 0
      queues.map { |queue| queue.sub(/^ost:/, "") }
    end

    def self.queues
      queue_names.map { |name| Ost::Web[name] }
    end

    def self.[](queue)
      Ost::Web::Queue.new(Ost[queue])
    end
  end
end
