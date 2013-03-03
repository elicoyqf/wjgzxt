class ParamSettingController < ApplicationController
  def http
    @psc = ParamScoreConfig.find_all_by_param_type('htd')
    @prc = ParamRuleConfig.find_all_by_param_type('htd')

    respond_to do |format|
      format.html { render layout: 'application'}
    end
  end

  def ping
  end

  def route
  end

  def video
  end
end
