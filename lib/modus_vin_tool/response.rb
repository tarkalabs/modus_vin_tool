module ModusVinTool
  class Response
    attr_reader :raw_response, :parsed_response

    def initialize(raw_response)
      @raw_response = raw_response  
      @parsed_response = JSON.parse(raw_response)
    end

    def compatible?(device_name = nil)
      return @parsed_response['compatible'] if @parsed_response['device']
      device_info = @parsed_reponse['devices'].select{|d| d['name'] == device_name }.first
      return device_info['compatible'] if device_info
    end

    def incompatible_devices
      return @parsed_response['devices'].select{|d| !d['compatible'] }.map{|d| d['name'] }
    end

    def incompatibility_code
      @parsed_response['incompatibility_code']
    end

    def incompatibility_reason
      @parsed_response['incompatibility_reason']
    end

    def make
      @parsed_response['make']
    end

    def model
      @parsed_response['model']
    end

    def trim
      @parsed_response['trim']
    end

    def year
      @parsed_response['year']
    end

    def error_code
      @parsed_response['code']
    end

    def error_message
      @parsed_response['message']
    end
  end
end
