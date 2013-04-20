#encoding : utf-8
require 'will_paginate/array'

class WorkordersController < ApplicationController
  def index
  end

  def wo_table
    #todo:此处的用户Id在使用了session后需要进行修改成session里面的用户id值
    #通过用户获得其所管辖的出口
    user      = User.first
    e_name    = user.export_names
    @dls_name = user.alias

    #工单显示的顺序从当前往后排列,先保存当月的数据
    t_year    = Time.now.year
    t_day     = Time.now.day
    t_month   = Time.now.month

    p_year  = 0
    p_day   = 1
    p_month = 0
    #显示最近两个月的日报表数据
    #首先判断一下是不是在1月
    if t_month == 1
      p_month = 12
      p_year  = t_year -1
    else
      p_month = t_month - 1
      p_year  = t_year
    end

    #获得上一个月的最大天数
    p_str      = p_year.to_s + '-' + p_month.to_s + '-' + p_day.to_s
    p_date     = Time.parse(p_str)
    p_min_day  = 1
    p_max_day  = p_date.at_end_of_month.day


    #列出当前月的数据统计,如果是当月1日，则直接略过当月的数据，直接显示前一个月即可。
    @out_arr   = []
    all_in_one = []
    unless t_day == 1
      c_day = t_day -1
      while c_day >= 1
        c_str    = t_year.to_s + '-' + t_month.to_s + '-' + c_day.to_s
        c_b_date = Time.parse(c_str)
        rl       = ReportLog.where('r_date = ? and user_id = ? ', c_b_date, user.id)
        puts '-'*50
        puts rl.inspect
        tmp_arr  = []
        tmp_arr << c_b_date << '所有关联出口日报表'
        tmp_arr << rl[0].view_date unless rl.blank?
        all_in_one << tmp_arr
        c_day -= 1
      end
    end

    #列出前一个月的数据统计
    while p_max_day >= 1
      p_str    = p_year.to_s + '-' + p_month.to_s + '-' + p_max_day.to_s
      p_b_date = Time.parse(p_str)
      rl       = ReportLog.where('r_date = ? and user_id = ? ', p_b_date, user.id)
      tmp_arr  = []
      tmp_arr << p_b_date << '所有关联出口日报表'
      tmp_arr << rl[0].view_date unless rl.blank?
      all_in_one << tmp_arr
      p_max_day -= 1
    end

    @out_arr = all_in_one.paginate page: params[:page], per_page: 10
  end

  def day_wo
    #todo:此处的用户Id在使用了session后需要进行修改成session里面的用户id值
    #通过用户获得其所管辖的出口
    user   = User.first
    e_name = user.export_names
    @dls_name = user.alias

    r_date   = Time.parse params[:date]

    @out_arr = []
    @out_arr = statis_d_data(e_name, r_date)

    ReportLog.create(r_type: 'day', r_date: r_date, user_id: user.id, view_date: Time.now)


    render :template => 'workorders/out_template'
  end

  def day_wo1
    #todo:此处的用户Id在使用了session后需要进行修改成session里面的用户id值
    #通过用户获得其所管辖的出口
    user      = User.first
    e_name    = user.export_names
    @dls_name = user.alias

    #工单显示的顺序从当前往后排列,先保存当月的数据
    t_year    = Time.now.year
    t_day     = Time.now.day
    t_month   = Time.now.month

    p_year  = 0
    p_day   = 1
    p_month = 0
    #显示最近两个月的日报表数据
    #首先判断一下是不是在1月
    if t_month == 1
      p_month = 12
      p_year  = t_year -1
    else
      p_month = t_month - 1
      p_year  = t_year
    end

    #获得上一个月的最大天数
    p_str     = p_year.to_s + '-' + p_month.to_s + '-' + p_day.to_s
    p_date    = Time.parse(p_str)
    p_min_day = 1
    p_max_day = p_date.at_end_of_month.day

    #列出当前月的数据统计,如果是当月1日，则直接略过当月的数据，直接显示前一个月即可。
    @out_arr  = []
    unless t_day == 1
      c_day = t_day -1
      while c_day >= 1
        @out_arr += statis_d_data(e_name, c_day, t_month, t_year)
        c_day    -= 1
      end
    end

    #列出前一个月的数据统计
    while p_max_day >= 1
      @out_arr  += statis_d_data(e_name, p_max_day, p_month, p_year)
      p_max_day -= 1
    end
    render :template => 'workorders/out_template'
  end


  def week_wo

  end

  def month_wo

  end

  def out_template

  end


end
