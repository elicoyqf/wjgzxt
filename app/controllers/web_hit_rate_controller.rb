#encoding : utf-8
require 'set'
require 'will_paginate/array'
class WebHitRateController < ApplicationController
  def time_r
    @whrs = WebHitRateStatis.paginate page: params[:page], per_page: 20
  end

  def select_day_report

  end

  def list_locale
    @url       = params[:url]
    day        = params[:day]
    date_begin = Time.parse(day).at_beginning_of_hour
    url_data   = HttpTestData.where('dest_url = ? and test_time >= ? and test_time < ?', @url, date_begin, date_begin+1.hour)
    @all_in_one = []
    url_data.each do |record|
      tmp = []
      tmp << record.source_node_name << record.dest_locale
      @all_in_one << tmp
    end
  end

  def list_day
    @url        = params[:url]
    mon         = params[:month]
    ntime       = Time.now
    year        = ntime.year.to_s
    d_str       = year +'-'+ mon + '-1'
    date_begin  = Time.parse(d_str)
    f_day       = date_begin.at_beginning_of_month.day
    l_day       = date_begin.at_end_of_month.day
    url_data    = WebHitRateStatis.where('url = ?  and time_begin >= ? and time_begin < ?', @url, date_begin, date_begin+1.month)
    @all_in_one = []
    (f_day..l_day).each do |d|
      tmp = []
      dx  = url_data.where('time_begin >= ? and time_begin < ?', date_begin, date_begin + 1.day).average('dx_hit_rate')
      lt  = url_data.where('time_begin >= ? and time_begin < ?', date_begin, date_begin + 1.day).average('lt_hit_rate')
      tmp << date_begin << dx << lt
      date_begin += 1.day
      @all_in_one << tmp
    end
  end

  def list_time
    @url        = params[:url]
    day         = params[:day]
    date_begin  = Time.parse(day).at_beginning_of_day
    url_data    = WebHitRateStatis.where('url = ?  and time_begin >= ? and time_begin < ?', @url, date_begin, date_begin+1.day)
    @all_in_one = []
    (0..23).each do |time|
      tmp     = []
      dx      = 0
      lt      = 0
      dx_data = url_data.where('time_begin = ? ', date_begin)
      lt_data = url_data.where('time_begin = ? ', date_begin)
      dx = dx_data.average('dx_hit_rate') unless dx_data.blank?
      lt = lt_data.average('dx_hit_rate') unless lt_data.blank?
      date_point = Time.parse(day.to_s+' '+ time.to_s + ':00')
      tmp << date_point << dx << lt
      date_begin += 1.hour
      @all_in_one << tmp
    end
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
        @mon_out    = Time.parse(mon).month
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
