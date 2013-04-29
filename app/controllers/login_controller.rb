#encoding : utf-8

class LoginController < ApplicationController
  skip_before_filter :authenticate, :only => [:index,:login]
  def index
    render layout: 'login'
  end

  def login
    name = params[:name]
    pass = params[:pass]
    user = User.find_by_uname(name)
    if user.blank?
      flash[:error] = '用户名或密码输入不正确，请重试!'
      redirect_to root_path
    else
      if Digest::MD5.hexdigest(pass) == user.password
        session[:user_id] = user.id
        redirect_to '/welcome',layout: 'application'
      else
        flash[:error] = '用户名或密码输入不正确，请重试!'
        redirect_to root_path
      end
    end
  end

  def logout
    reset_session
    redirect_to root_url
  end
end
