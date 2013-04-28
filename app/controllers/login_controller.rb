class LoginController < ApplicationController
  def index
    render layout: 'login'
  end

  def login
    redirect_to '/welcome'
  end

  def logout
    reset_session
    redirect_to root_url
  end
end
