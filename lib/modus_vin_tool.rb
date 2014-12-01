require 'nokogiri'
require 'net/http'
require 'json'

require "modus_vin_tool/version"

module ModusVinTool

  class API
    def initialize(info = {})
      @info = info
    end
    
    def get_compatibility_info
      account_name = @info[:account_name]
      device_name  = @info[:device_name]
      api_key      = @info[:api_key]
      vin          = @info[:vin]

      raw_response = send_request(account_name, device_name, api_key, vin)
      response = Response.new(raw_response)
      return response
    end

    private
      def send_request(account_name, device_name, api_key, vin)
        uri = URI('http://vin.modustools.com/api/check_compatibility')
        params = {account_name: account_name, device_name: device_name, api_key: api_key, vin: vin}
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        return res.body
      end
  end

  class Response
    attr_reader :raw_response, :parsed_response

    def initialize(raw_response)
      @raw_response = raw_response  
      @parsed_response = JSON.parse(raw_response)
    end

    def compatible
      @parsed_response['compatible']
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