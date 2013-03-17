class WebHitRateController < ApplicationController
  def time_r
    @whrs = WebHitRateStatis.all
  end

  def day_r
  end

  def month_r
  end

  def index
  end
end
