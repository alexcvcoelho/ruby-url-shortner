# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  url = Url.new id: 1, short_url: 'KJRDJ', original_url: 'https://www.fullstacklabs.co'
  describe 'validations' do
    it 'validates URL valid' do
      expect(url).to be_valid
    end

    it 'validates original URL is a valid URL' do
      url.original_url = nil
      expect(url).to_not be_valid
      url.original_url = "https//www.fullstacklabs.co"
      expect(url).to_not be_valid
    end

    it 'validates short URL is present' do
      url.short_url = nil
      expect(url).to_not be_valid
    end

    it 'validates short URL is valid' do
      url.short_url = "BBBBBB"
      expect(url).to_not be_valid
      url.short_url = "BBB1B"
      expect(url).to_not be_valid
      url.short_url = "aAAAsF"
      expect(url).to_not be_valid
    end
  end
end
