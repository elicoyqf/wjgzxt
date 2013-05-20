#encoding : utf-8
class PwdModifyController < ApplicationController
  def modify

  end

  def p_modify
    o_pass = params[:o_pass]
    n_pass = params[:n_pass]
    a_pass = params[:a_pass]
    user   = User.find(session[:user_id])
    if Digest::MD5.hexdigest(o_pass) == user.password
      if n_pass == a_pass
        if n_pass.blank?
          flash[:error] = '为保证帐号的安全性，密码不允许为空，请重新输入。'
          redirect_to action: 'modify'
        elsif n_pass.to_s.size < 6 || n_pass.to_s.size > 18
          flash[:error] = '密码长度必须要在6-18，请检查。'
          redirect_to action: 'modify'
        else
          p_md5 = Digest::MD5.hexdigest(n_pass)
          user.update_attribute(:password, p_md5)
          flash[:success] = '密码修改成功，请保存好你的新密码。'
          redirect_to action: 'modify'
        end
      else
        flash[:error] = '新密码两次确认不一致，请重新输入。'
        redirect_to action: 'modify'
      end
    else
      flash[:error] = '原始密码输入不正确，请重新输入。'
      redirect_to action: 'modify'
    end
  end
end
