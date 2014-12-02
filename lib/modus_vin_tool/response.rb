module ModusVinTool
  class Response
    attr_reader :raw_response, :parsed_response

    def initialize(raw_response)
      @raw_response = raw_response  
      @parsed_response = JSON.parse(raw_response)
    end

    def compatible?
      @parsed_response['compatible']
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