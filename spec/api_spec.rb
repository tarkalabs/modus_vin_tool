require 'spec_helper.rb'

describe ModusVinTool::API do

  it "hit api with no params to get error" do
    info = {device_name: '', vin: ''}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.error_code).to eq '404'
  end

  it "hit api with params for error response" do
    ModusVinTool.configure_with('./appconfig.yml')
    info = {device_name: 'lmu3030', vin: '1G11B5SLOEF266568'}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.error_message).to eq 'Please ensure a valid VIN is being checked.'
  end

  it "hit api for success response" do
    ModusVinTool.configure_with('./appconfig.yml')
    info = {device_name: 'lmu3030', vin: '1NXBA02E8TZ394564'}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.compatible).to eq true
  end

end
