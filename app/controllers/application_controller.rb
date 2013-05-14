class ApplicationController < ActionController::Base
  before_filter :authenticate
  protect_from_forgery
  include ReportsHelper
  include WebHitRateHelper
  include WorkordersHelper
  include ApplicationHelper
  include DomainHelper

  def authenticate
    unless session[:user_id]
      redirect_to root_path
    end
  end

end
