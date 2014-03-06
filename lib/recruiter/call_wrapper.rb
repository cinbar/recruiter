module Recruiter
  module CallWrapper

    def execute_safely(context, method_name, args, default_return_value=nil, &block)
      begin
        context.send(method_name, *args, &block)
      rescue Exception => ex
        log "#{context.class} raised an error while trying to execute `#{method_name}` with arguments: #{args.inspect}."
        log ex.message
        execute_block_if_given(default_return_value, &block)
      end
    end

    def log(message)
      Rails.logger.debug message
    end

    private
    def execute_block_if_given(default_return_value, &block)
      if block_given?
        block.call
      else
        default_return_value
      end
    end
  end
end