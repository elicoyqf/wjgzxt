#encoding : utf-8

class ParamSettingController < ApplicationController
  before_filter :user_level

  def adduser

  end

  def u_user
    uid   = params[:id]
    @user = User.find(uid.to_s.to_i)
  end

  def p_u_user
    loginname = params[:loginname]
    passwd    = params[:passwd]
    passwd1   = params[:passwd1]
    level     = params[:level]
    realname  = params[:realname]
    email     = params[:email]
    contact   = params[:contect]
    uid       = params[:u_id]

    if loginname.blank? || passwd.blank? || passwd1.blank? || level.blank? || realname.blank? || email.blank? || contact.blank?
      flash[:error] = '所有资料都必须要输入，请检查。'
      redirect_to action: 'adduser'
    elsif passwd != passwd1
      flash[:error] = '两次密码验证失败，请检查。'
      redirect_to action: 'adduser'
    else
      if passwd.to_s.size == 32
        User.find(uid.to_s.to_i).update_attributes(uname: loginname, status: 0, level: level, alias: realname, email: email, contact: contact, password: passwd)
        flash[:success] = '更新用户成功，如下示。'
        redirect_to action: 'mng_user'
      elsif passwd.to_s.size < 6 || passwd.to_s.size > 18 && passwd.to_s.size < 32
        flash[:error] = '密码长度必须要在6-18，请检查。'
        redirect_to action: 'adduser'
      else
        User.find(uid.to_s.to_i).update_attributes(uname: loginname, status: 0, level: level, alias: realname, email: email, contact: contact, password: Digest::MD5.hexdigest(passwd))
        redirect_to action: 'mng_user'
      end

    end
  end

  def s_user
    uid  = params[:id]
    user = User.find(uid.to_s.to_i)

    if user.status == 1
      user.update_attribute('status', 0)
    else
      user.update_attribute('status', 1)
    end
    redirect_to action: 'mng_user'
  end

  def d_user
    uid = params[:id]
    User.destroy(uid.to_s.to_i)
    de = ExportName.find_all_by_user_id(uid.to_s.to_i)
    if de.size == 1
      de.first.update_attribute('user_id', 0)
    elsif de.size > 1
      de.each do |m|
        m.update_attribute('user_id', 0)
      end
    end
    redirect_to action: 'mng_user'
  end

  def p_adduser
    loginname = params[:loginname]
    passwd    = params[:passwd]
    passwd1   = params[:passwd1]
    level     = params[:level]
    realname  = params[:realname]
    email     = params[:email]
    contact   = params[:contect]

    if loginname.blank? || passwd.blank? || passwd1.blank? || level.blank? || realname.blank? || email.blank? || contact.blank?
      flash[:error] = '所有资料都必须要输入，请检查。'
      redirect_to action: 'adduser'
    elsif passwd != passwd1
      flash[:error] = '两次密码验证失败，请检查。'
      redirect_to action: 'adduser'
    elsif passwd.to_s.size < 6 || passwd.to_s.size > 18
      flash[:error] = '密码必须要符号6-18位，请检查。'
      redirect_to action: 'adduser'
    else
      User.create(uname: loginname, status: 0, level: level, alias: realname, email: email, contact: contact,
                  password: Digest::MD5.hexdigest(passwd))
      flash[:success] = '添加用户成功，如下示。'
      redirect_to action: 'mng_user'
    end

  end

  def interaction
    #查询出所有未关联的出口
    @en    = ExportName.find_all_by_user_id(0)
    #查询出所有用户
    @users = User.where('uname != ?','admin')
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
    @en = ExportName.all :include => [:user]
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

  private
  def user_level
    if current_user.level < 3
      redirect_to controller: 'export', action: 'perm_deni'
    end

  end
end
