module ModusVinTool
  class API
    def initialize(info = {})
      @info = info
    end
  
    def get_compatibility_info
      account_name     = ModusVinTool.config[:account_name]
      for_account_name = @info[:for_account_name]
      api_key          = ModusVinTool.config[:api_key]
      device_name      = @info[:device_name]
      vin              = @info[:vin]


      raw_response = send_request(account_name, device_name, api_key, vin, for_account_name)
      response = Response.new(raw_response)
      return response
    end

    private
      def send_request(account_name, device_name, api_key, vin, for_account_name)
        uri = URI('http://vin.modustools.com/api/check_compatibility')
        params = {account_name: account_name, device_name: device_name, api_key: api_key, vin: vin, for_account_name: for_account_name}
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        return res.body
      end
  end
end
