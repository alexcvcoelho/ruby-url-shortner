# frozen_string_literal: true

class Url < ApplicationRecord
  after_initialize :set_defaults
  has_many :clicks
  validates :original_url, presence: true, url: true
  validates :short_url, presence: true, length: { is: 5 }, uniqueness: true, upper_case: true

  def set_defaults
    self.clicks_count = 0 if self.new_record?
  end
end
