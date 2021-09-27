# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    url = Url.new id: 1, short_url: 'KJRDJ', original_url: 'https://www.fullstacklabs.co'
    click = Click.new(url_id: url.id, platform: 'Windows', browser: 'Chrome', url: url)

    it 'validates click is valid' do
      expect(click).to be_valid
    end

    it 'validates url_id is valid' do
      click.url_id = nil
      expect(click).to_not be_valid
    end

    it 'validates browser is not null' do
      click.browser = nil
      expect(click).to_not be_valid
    end

    it 'validates platform is not null' do
      click.platform = nil
      expect(click).to_not be_valid
    end
  end
end
