# frozen_string_literal: true

require 'colmena/port_injection'


module Colmena
  class Listener
    include Colmena::PortInjection
  end
end
