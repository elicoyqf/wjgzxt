#encoding : utf-8
class ExportController < ApplicationController
  before_filter :user_level, except: [:perm_deni]

  def flag
    @en = ExportName.all
  end

  def add_flag
  end

  def p_add_flag
    e_no   = params[:e_no]
    e_name = params[:e_name]
    en     = ExportName.new(name: e_name, status: 0, user_id: session[:user_id], alias: e_no)
    if en.save
      flash[:success] = '添加出口编号成功。'
    else
      flash[:error] = '更新出口编号失败，可能编号或者名称存在重复，请检查。'
    end
    redirect_to action: 'add_flag'
  end

  def modify
    @en = ExportName.find(params[:id])
  end

  def mdf
    id     = params[:id]
    e_name = params[:name]
    ExportName.find(id).update_attribute('name', e_name)
    redirect_to action: 'flag'
  end

  def chg_status
    @en = ExportName.find(params[:id])
    if @en.status == 0
      @en.update_attribute('status',1)
    else
      @en.update_attribute('status',0)
    end
    flash[:success] = '更新出口状态成功。'
    redirect_to action: 'flag'
  end

  def del
    @en = ExportName.find(params[:id])
    @en.destroy
    flash[:success] = '删除出口编号成功。'
    redirect_to action: 'flag'
  end

  def block
  end

  def perm_deni

  end

  private
  def user_level
    if current_user.level < 3
      redirect_to action: 'perm_deni'
    end

  end
end
