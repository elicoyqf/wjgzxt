class ExportController < ApplicationController
  before_filter :user_level, except: [:perm_deni]

  def flag
    @en = ExportName.all
  end

  def modify
    @en = ExportName.find(params[:id])
  end

  def mdf
    id = params[:id]
    as = params[:alias]
    ExportName.find(id).update_attribute('alias', as)
    redirect_to action: :flag
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
