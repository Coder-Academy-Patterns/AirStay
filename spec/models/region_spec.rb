require 'rails_helper'

RSpec.describe Region, type: :model do
  it 'should allow valid values' do
    expect(Region.new(name: 'Victoria', country_code: 'au')).to be_valid
    expect(Region.new(name: 'Victoria', country_code: 'AU')).to be_valid
  end

  it 'should disallow empty values' do
    expect(Region.new(name: '', country_code: '')).to_not be_valid
    expect(Region.new(name: 'Victoria', country_code: '')).to_not be_valid
    expect(Region.new(name: '', country_code: 'au')).to_not be_valid
    expect(Region.new).to_not be_valid
  end

  it 'should disallow invalid country codes' do
    expect(Region.new(name: 'Victoria', country_code: 'usa')).to_not be_valid
    expect(Region.new(name: 'Victoria', country_code: 'zz')).to_not be_valid
    expect(Region.new(name: 'Victoria', country_code: 'a')).to_not be_valid
  end

  it 'should downcase country codes' do
    expect(Region.create!(name: 'Victoria', country_code: 'AU').country_code).to eq('au')
  end
end
