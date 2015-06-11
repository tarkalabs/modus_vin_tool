require 'nokogiri'
require 'net/http'
require 'json'
require "yaml"
require "modus_vin_tool/version"
require "modus_vin_tool/api"
require "modus_vin_tool/response"

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

end
