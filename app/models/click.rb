# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url
  validates :url_id, :browser, :platform, presence: true
end
