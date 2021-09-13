require 'browser'
module RequestHelper
  def get_request_info(request)
    browser = Browser.new(request.env['HTTP_USER_AGENT'])
    { :browser => browser.name, :platform => browser.platform }
  end
end
