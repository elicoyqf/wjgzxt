#encoding : utf-8
require 'set'
require 'will_paginate/array'
class WebHitRateController < ApplicationController
  def time_r
    @whrs = WebHitRateStatis.paginate page: params[:page], per_page: 20
  end

  def select_day_report

  end

  def list_day
    url         = params[:url]
    mon         = params[:month]
    ntime       = Time.now
    year        = ntime.year.to_s
    d_str       = year +'-'+ mon + '-1'
    date_begin  = Time.parse(d_str)
    f_day       = date_begin.at_beginning_of_month.day
    l_day       = date_begin.at_end_of_month.day
    url_data    = WebHitRateStatis.where('url = ?  and time_begin >= ? and time_end < ?', url, date_begin, date_begin+1.month)
    tmp         = []
    @all_in_one = []
    (f_day..l_day).each do |d|
      dx = url_data.where('time_begin >= ? and time_end < ?', date_begin, date_begin + 1.day).average('dx_hit_rate')
      lt = url_data.where('time_begin >= ? and time_end < ?', date_begin, date_begin + 1.day).average('lt_hit_rate')
      tmp << date_begin << dx << lt
      date_begin += 1.day
      @all_in_one << tmp
    end
  end

  def list_time

  end

  #显示今年的月份
  def select_month_report
    @month = []
    (1..12).each do |mon|
      tmp = []
      tmp << mon << mon.to_s + '月'
      @month << tmp
    end
  end

  def day_r
    if params[:date].blank?
      if session[:whr_day].blank?
        redirect_to root_url
      else
        day         = session[:whr_day]
        @day_out    = day
        in_one      = avg_whrs(day, day + 1.day)
        @all_in_one = in_one.paginate page: params[:page], per_page: 20
      end
    else
      day               = Time.parse params[:date]
      session[:whr_day] = day
      @day_out          = day
      in_one            = avg_whrs(day, day + 1.day)
      @all_in_one       = in_one.paginate page: params[:page], per_page: 20
    end
  end


  def month_r
    if params[:month].blank?
      if session[:whr_month].blank?
        redirect_to root_url
      else
        mon         = session[:whr_month]
        @mon_out    = mon
        in_one      = avg_whrs(mon, mon + 1.month)
        @all_in_one = in_one.paginate page: params[:page], per_page: 20
      end
    else
      mon                 = params[:month]
      @mon_out            = mon
      ntime               = Time.now
      year                = ntime.year.to_s
      d_str               = year +'-'+ mon + '-1'
      date_begin          = Time.parse(d_str)
      date_end            = date_begin + 1.month
      session[:whr_month] = date_begin
      in_one              = avg_whrs(date_begin, date_end)
      @all_in_one         = in_one.paginate page: params[:page], per_page: 20
    end
  end

  def index
  end
end
