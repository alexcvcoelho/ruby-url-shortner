# frozen_string_literal: true

require 'json'
class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.last(10).reverse
  end

  def create
    url = Url.new(url_params)
    url.short_url = helpers.generate_short_url(5)
    if url.valid?
      url.save
      flash[:success] = "Url created: http://localhost:3000/#{url.short_url}"
    else
      flash[:error] = url.errors.full_messages[0]
    end
    redirect_to action: 'index'
  end

  def show
    @url = Url.find_by_short_url params[:url]
    @daily_clicks = []

    clicks = Click.where('created_at BETWEEN ? AND ? AND url_id = ?',
                         Date.current.beginning_of_month,
                         Date.current.end_of_month,
                         @url.id)

    @daily_clicks = clicks
                    .group_by { |click| click.created_at.day }
                    .transform_values { |value| value.count }
                    .map { |key, value| [key.to_s, value] }

    @browsers_clicks = clicks
                    .group_by { |click| click.browser }
                    .transform_values { |value| value.count }
                    .map { |key, value| [key, value] }

    @platform_clicks = clicks
                    .group_by { |click| click.platform }
                    .transform_values { |value| value.count }
                    .map { |key, value| [key, value] }

  end

  def visit
    url = Url.find_by_short_url(params[:short_url])
    browser_info = helpers.get_request_info(request)
    if url
      url.clicks_count += 1
      url.save
      Click.create(
        url_id: url.id,
        browser: browser_info[:browser],
        platform: browser_info[:platform]
      )
      redirect_to url.original_url
    else
      render_404
    end
  end

  def api
    urls = Url.includes(:clicks).last(10).reverse
    urls = urls.map {|url| {
      type: 'urls', 
      id: url.id, 
        attributes: {
        'created-at': url.created_at,
        'original-url': url.original_url,
        url: "https://127.0.0.1:3000/#{url.short_url}",
        clicks: url.clicks_count
      },
      relationships: {
        clicks: {
          data: url.clicks.map {|val| {id: val.id, type: 'clicks'}}
        }
      }
    }}
    
    render json: urls
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
