class ApplicationController < ActionController::Base
  protect_from_forgery
  include ReportsHelper
  include WebHitRateHelper
  include WorkordersHelper
end
