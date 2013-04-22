#encoding : utf-8

class ParamSettingController < ApplicationController
  def adduser

  end

  def p_adduser
    loginname = params[:loginname]
    passwd    = params[:passwd]
    passwd1   = params[:passwd1]
    level     = params[:level]
    realname  = params[:realname]
    email     = params[:email]
    contact   = params[:contect]

    puts

    if loginname.blank? || passwd.blank? || passwd1.blank? || level.blank? || realname.blank? || email.blank? || contact.blank?
      flash[:error] = '所有资料都必须要输入，请检查。'
      redirect_to action: 'adduser'
    elsif passwd != passwd1
      flash[:error] = '两次密码验证失败，请检查。'
      redirect_to action: 'adduser'
    else
      User.create(uname: loginname,status: 0,level: level, alias: realname,email: email,contact: contact)
      flash[:success] = '添加用户成功，如下示。'
      redirect_to action: 'mng_user'
    end

  end

  def interaction
    #查询出所有未关联的出口
    @en    = ExportName.where('user_id = 0')
    #查询出所有用户
    @users = User.all

  end

  def p_interaction
    #取得数据值
    exname = params[:excblist]
    uname  = params[:uid]

    exname.each do |ex|
      ExportName.find(ex.to_s.to_i).update_attribute('user_id', uname)
    end

    redirect_to action: :interaction
  end

  def view_interaction
    @en = ExportName.all
  end

  def del_interaction
    id = params[:id]
    ExportName.find(id.to_s.to_i).update_attribute('user_id', 0)
    redirect_to action: :view_interaction
  end

  def mng_user
    @user = User.all
  end

  def http
    @psc = ParamScoreConfig.where('param_type = ? and weight > ?', 'htd', 0)

    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  def ping
    @psc = ParamScoreConfig.where('param_type = ? and weight > ?', 'ptd', 0)

    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  def route
    @psc = ParamScoreConfig.where('param_type = ? and weight > ?', 'ptd', 0)

    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  def video
    @psc = ParamScoreConfig.where('param_type = ? and weight > ?', 'vtd', 0)

    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end
end
