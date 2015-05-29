require "delegate"

module Ost
  module Web
    class Queue < SimpleDelegator
      def backup?
        !hostname.nil?
      end

      def name
        key_parts[1]
      end

      def hostname
        key_parts[2]
      end

      def pid
        key_parts[3]
      end

      def href
        key_parts[1..3].join(':')
      end

      def running?
        Process.getpgid pid.to_i
        true
      rescue
        false
      end

      private

      def key_parts
        key.split(":")
      end
    end
  end
end
