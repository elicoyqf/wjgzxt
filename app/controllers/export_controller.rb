class ExportController < ApplicationController
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
end
