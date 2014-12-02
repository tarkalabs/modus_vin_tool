require 'nokogiri'
require 'net/http'
require 'json'

require "modus_vin_tool/version"

module ModusVinTool

  @config = {
    account_name: '',
    api_key:''
  }

  @valid_config_keys = @config.keys

  def self.configure(opts = {})
    opts.each{|k, v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  def self.configure_with(path_to_yaml)
    begin 
      config = YAML::load(IO.read(path_to_yaml))
    rescue Errno::ENOENT
      log(:warning, "File not found #{File.expand_path(path_to_yaml)}")
    rescue Psych::SyntaxError
      log(:warning, "#{File.expand_path(path_to_yaml)} syntax invalid.")
    end
    configure(config)
  end

  def self.config
    @config
  end


  class API
    def initialize(info = {})
      @info = info
    end
    
    def get_compatibility_info
      account_name = ModusVinTool.config[:account_name]
      api_key      = ModusVinTool.config[:api_key]
      device_name  = @info[:device_name]
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