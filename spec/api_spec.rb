require 'spec_helper.rb'

describe ModusVinTool::API do

  # FIXME - will need to mock these api responses since rules can change and don't actually want it to go out if we don't need it to

  it "hit api with no params to get error" do
    info = {device_name: '', vin: ''}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.error_code).to eq '404'
  end

  it "hit api with params for error response" do
    ModusVinTool.configure_with('./appconfig.yml')
    info = {device_name: 'lmu3030', vin: 'V1231231231231231'}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.error_message).to eq 'Please ensure a valid VIN is being checked.'

    expect(res).to_not be_compatible
  end

  it "hit api for success response" do
    ModusVinTool.configure_with('./appconfig.yml')
    info = {device_name: 'lmu3030', vin: '1NXBA02E8TZ394564'}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.compatible?).to eq true
  end

  it "hit api for incompatibility reason" do
    ModusVinTool.configure_with('./appconfig.yml')
    info = {device_name: 'lmu3030', vin: 'JTDKN3DU1C1507948'}
    check = ModusVinTool::API.new(info)
    res = check.get_compatibility_info
    expect(res.incompatibility_reason).to eq 'Other'
  end
end
