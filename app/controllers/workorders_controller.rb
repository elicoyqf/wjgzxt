#encoding : utf-8
require 'will_paginate/array'

class WorkordersController < ApplicationController
  def index
  end

  def wo_table
    #通过用户获得其所管辖的出口
    user      = User.find(session[:user_id])
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
        rl       = ReportLog.where('r_date = ? and user_id = ? and r_type = "day"', c_b_date, user.id)
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
      rl       = ReportLog.where('r_date = ? and user_id = ? and r_type = "day"', p_b_date, user.id)
      tmp_arr  = []
      tmp_arr << p_b_date << '所有关联出口日报表'
      tmp_arr << rl[0].view_date unless rl.blank?
      all_in_one << tmp_arr
      p_max_day -= 1
    end

    @out_arr = all_in_one.paginate page: params[:page], per_page: 10
  end

  def day_wo
    #通过用户获得其所管辖的出口
    user      = User.find(session[:user_id])
    e_name    = user.export_names
    @dls_name = user.alias

    r_date = Time.parse params[:date]

    @out_arr = []
    @out_arr = statis_d_data(e_name, r_date, 1)
    puts '-'*100
    puts r_date
    puts '-'*100
    ReportLog.create(r_type: 'day', r_date: r_date, user_id: user.id, view_date: Time.now)
    render :template => 'workorders/out_template'
  end

=begin
  def day_wo1
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
        @out_arr += statis_d_data1(e_name, c_day, t_month, t_year)
        c_day    -= 1
      end
    end

    #列出前一个月的数据统计
    while p_max_day >= 1
      @out_arr  += statis_d_data1(e_name, p_max_day, p_month, p_year)
      p_max_day -= 1
    end
    render :template => 'workorders/out_template'
  end
=end


  def export_detail
    #现在是统计一天的数据
    @q_export = params[:ename]
    b_time    = Time.parse(params[:bdate])
    e_time    = Time.parse(params[:edate])
    #只查询出来那些测试为负的数据。
    @q_data   = HttpTestScore.where('source_node_name = ? and test_time >= ? and test_time < ? and negative_items_scores < ?', @q_export, b_time, e_time, 0).order('negative_items_scores')
  end

  def week_table
    #通过用户获得其所管辖的出口
    user      = User.find(session[:user_id])
    e_name    = user.export_names
    @dls_name = user.alias

    #工单显示的是最近8个星期的统计数据,从周一到周末，如果为周一，则加多一个星期
    t_year    = Time.now.year
    t_day     = Time.now.at_beginning_of_day
    t_wb_day  = Time.now.at_beginning_of_week
    t_we_day  = Time.now.at_end_of_week
    t_month   = Time.now.month

    @out_arr = []
    if t_day == t_wb_day
      #为周1则需要加多一个星期
      (1..8).each do |num|
        tmp_arr = []
        t_wb    = t_wb_day - num.week
        t_we    = t_we_day - num.week
        rl      = ReportLog.where('r_date = ? and user_id = ? and r_type = "week"', t_wb, user.id)

        tmp_arr << t_wb << t_we << '所有关联出口周报表'
        tmp_arr << rl[0].view_date unless rl.blank?
        @out_arr << tmp_arr
      end
    else
      #不是周1的情况则按正常排序即可
      (0..7).each do |num|
        tmp_arr = []
        t_wb    = t_wb_day - num.week
        if num == 0
          t_we = t_day
        else
          t_we = t_we_day - num.week
        end
        rl = ReportLog.where('r_date = ? and user_id = ? and r_type = "week"', t_wb, user.id)

        tmp_arr << t_wb << t_we << '所有关联出口周报表'
        tmp_arr << rl[0].view_date unless rl.blank?
        @out_arr << tmp_arr
      end
    end
  end

  def week_wo
    #通过用户获得其所管辖的出口
    user      = User.find(session[:user_id])
    e_name    = user.export_names
    @dls_name = user.alias
    r_date    = Time.parse params[:date]
    @out_arr  = statis_d_data(e_name, r_date, 2)

    ReportLog.create(r_type: 'week', r_date: r_date, user_id: user.id, view_date: Time.now)
    render :template => 'workorders/out_template'
  end

  def month_table
    #通过用户获得其所管辖的出口
    user      = User.find(session[:user_id])
    e_name    = user.export_names
    @dls_name = user.alias

    #工单显示的是最近8个星期的统计数据,从周一到周末，如果为周一，则加多一个星期
    t_year    = Time.now.year
    t_day     = Time.now.at_beginning_of_day
    t_wb_day  = Time.now.at_beginning_of_month
    t_we_day  = Time.now.at_end_of_month
    t_month   = Time.now.month

    @out_arr = []
    #判断一下是不是当月的第一天，如果是则往往推两个月。
    if t_day.day == 1
      (1..2).each do |num|
        tmp_arr = []
        t_wb    = t_wb_day - num.month
        t_we    = t_wb.at_end_of_month
        rl      = ReportLog.where('r_date = ? and user_id = ? and r_type = "month"', t_wb, user.id)

        tmp_arr << t_wb << t_we << '所有关联出口月报表'
        tmp_arr << rl[0].view_date unless rl.blank?
        @out_arr << tmp_arr
      end
    else
      (0..1).each do |num|
        tmp_arr = []
        t_wb    = t_wb_day - num.month
        if num == 0
          t_we = t_day
        else
          t_we = t_wb.at_end_of_month
        end
        rl = ReportLog.where('r_date = ? and user_id = ? and r_type = "month"', t_wb, user.id)

        tmp_arr << t_wb << t_we << '所有关联出口月报表'
        tmp_arr << rl[0].view_date unless rl.blank?
        @out_arr << tmp_arr
      end
    end
  end

  def month_wo
    #通过用户获得其所管辖的出口
    user      = User.find(session[:user_id])
    e_name    = user.export_names
    @dls_name = user.alias
    r_date    = Time.parse params[:date]
    @out_arr  = statis_d_data(e_name, r_date, 3)

    ReportLog.create(r_type: 'month', r_date: r_date, user_id: user.id, view_date: Time.now)
    render :template => 'workorders/out_template'
  end

  def out_template

  end


end
