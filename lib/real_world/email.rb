# frozen_string_literal: true

module RealWorld
  module Email
    # Source: http://emailregex.com/
    VALIDATION_REGEX = /^\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z$/i
  end
end
