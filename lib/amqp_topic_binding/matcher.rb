module AmqpTopicBinding
  class Matcher
    def initialize(pattern)
      @pattern = pattern || ''
      @pattern_parts = @pattern.split('.')
    end

    def matches?(routing_key)
      if routing_key.nil? || routing_key == ''
        return false
      end

      if @pattern == routing_key
        return true
      end

      routing_key_parts = routing_key.split('.')

      if @pattern_parts.length > routing_key_parts.length
        return false
      end

      last_checked_index = 0

      @pattern_parts.each_with_index do |pattern_part, index|
        if pattern_part == '#'
          return true
        end

        routing_key_part = routing_key_parts[index]

        if pattern_part != '*' && pattern_part != routing_key_part
          return false
        end

        last_checked_index = index
      end

      if routing_key_parts.length > (last_checked_index + 1)
        return false
      end

      return true
    end
  end
end
