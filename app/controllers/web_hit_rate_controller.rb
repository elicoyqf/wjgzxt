class WebHitRateController < ApplicationController
  def time_r
    @whrs = WebHitRateStatis.paginate  page: params[:page], per_page: 20
  end

  def day_r
  end

  def month_r
  end

  def index
  end
end
