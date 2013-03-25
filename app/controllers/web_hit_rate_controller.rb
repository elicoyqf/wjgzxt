require 'set'
class WebHitRateController < ApplicationController
  def time_r
    @whrs = WebHitRateStatis.paginate page: params[:page], per_page: 20
  end

  def select_day_report

  end

  def day_r
    day         = Time.parse params[:date]
    @day_out    = day
    url_data    = WebHitRateStatis.where('time_begin >= ? and time_begin < ?', day, day + 1.day)
    url_name    = Set.new
    @all_in_one = []
    url_data.each do |line|
      url_name << line.url
    end

    url_name.each do |name|
      tmp = []
      dx  = url_data.where('url = ?', name).average('dx_hit_rate')
      lt  = url_data.where('url = ?', name).average('lt_hit_rate')
      tmp << name << dx << lt
      @all_in_one << tmp
    end

  end

  def month_r
  end

  def index
  end
end
