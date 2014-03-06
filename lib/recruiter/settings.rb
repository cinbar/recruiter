require 'recruiter/call_wrapper'
require 'figaro'

module Recruiter
  class Settings
    include Recruiter::CallWrapper

    def method_missing(method_sym, *arguments, &block)
      execute_safely(Figaro.env, method_sym, arguments)
    end

    def respond_to?(method_sym)
      true
    end
  end
end
