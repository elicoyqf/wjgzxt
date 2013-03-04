class ParamSettingController < ApplicationController
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
