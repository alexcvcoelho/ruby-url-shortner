module ShortUrlHelper
  def generate_short_url(length)
    ('A'..'Z').to_a.shuffle[0..length - 1].join
  end
end
