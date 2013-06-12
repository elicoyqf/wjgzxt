#encoding : utf-8
require 'set'
#
class ReportsController < ApplicationController
  def index

  end

  def export_rep
    @ms = []
    (1..12).each do |n|
      @ms << [n, n.to_s+'月']
    end
  end

  def select_date_report
    @ds = []
    (0..23).each do |n|
      @ds << [n, n]
    end
  end

  def select_day_report

  end

  def select_week_report

  end

  def select_month_report
    @ms = []
    (1..12).each do |n|
      @ms << [n, n.to_s+'月']
    end
  end

  def date2month_report
    ef         = ExportName.find_all_by_user_id(current_user.id)
    time_begin = nil
    time_end   = nil
    if params[:ms].blank?
      time_begin = session[:date2month_tb]
      time_end   = session[:date2month_te]
    else
      ms                      = params[:ms]
      tmp_str                 = Time.now.year.to_s
      new_str                 = tmp_str + '-' + ms + '-01'
      time_begin              = Time.parse(new_str).at_beginning_of_month
      time_end                = time_begin + 1.month
      session[:date2month_tb] = time_begin
      session[:date2month_te] = time_end
    end
    @title_name, @odata = gen_report_data(time_begin, time_end, ef)
    render template: 'reports/date2time_report'
  end

  def date2week_report
    ef         = ExportName.find_all_by_user_id(current_user.id)
    time_begin = nil
    time_end   = nil
    if params[:day_begin].blank? || params[:day_end].blank?
      time_begin = session[:date2week_tb]
      time_end   = session[:date2week_te]
    else
      db_str                 = params[:day_begin]
      de_str                 = params[:day_end]
      time_begin             = Time.parse(db_str)
      time_end               = Time.parse(de_str)
      session[:date2week_tb] = time_begin
      session[:date2week_te] = time_end
    end
    @title_name, @odata = gen_report_data(time_begin, time_end, ef)
    render template: 'reports/date2time_report'
  end

  def date2day_report
    ef         = ExportName.find_all_by_user_id(current_user.id)
    time_begin = nil
    time_end   = nil
    if params[:date].blank?
      time_begin = session[:date2day_tb]
      time_end   = session[:date2day_te]
    else
      d_str                 = params[:date]
      time_str              = d_str
      time_begin            = Time.parse(time_str)
      time_end              = time_begin + 1.day
      session[:date2day_tb] = time_begin
      session[:date2day_te] = time_end
    end
    @title_name, @odata = gen_report_data(time_begin, time_end, ef)
    render template: 'reports/date2time_report'
  end

  def date2time_report
    ef         = ExportName.find_all_by_user_id(current_user.id)
    time_begin = nil
    time_end   = nil
    if params[:date].blank?
      time_begin = session[:date2time_tb]
      time_end   = session[:date2time_te]
    else
      d_str                  = params[:date]
      ds                     = params[:ds]
      time_str               = d_str + ' ' + ds
      time_begin             = Time.parse(time_str)
      time_end               = time_begin + 1.hour
      session[:date2time_tb] = time_begin
      session[:date2time_te] = time_end
    end
    @title_name, @odata = gen_report_data(time_begin, time_end, ef)
  end

  def website_select
    @tdn    = TestDestNode.all
    #查询当月的月表数据
    hts     = HttpTestStatis.where('start_time >= ? and start_time < ?', Time.now.at_beginning_of_week, Time.now.at_beginning_of_week + 1.week)
    hdata   = HttpTestScore.where('test_time >= ? and test_time < ?', Time.now.at_beginning_of_week, Time.now.at_beginning_of_week + 1.week)
    #hts    = HttpTestStatis.where('start_time >= ? and start_time < ?', Time.now.at_beginning_of_week, Time.now.at_beginning_of_week + 1.week)
    @e_name = Set.new
    hts.each do |line|
      @e_name << line.export_name
    end
    #将对比标杆出口去掉
    @e_name.delete(BACKBONE)
    @out_data = []
    @e_name.each do |fuck|
      tmp_arr = []
      tmp_arr << fuck
      nega_scores = hdata.where('source_node_name = ?', fuck).group('dest_url').sum(:negative_items_scores)
      puts nega_scores.inspect
      sns = nega_scores.to_a.sort_by! { |a, b| b }[0..4]
      tmp_arr << sns
      @out_data << tmp_arr
    end
    @out_data

  end

  def website_ranking
    @ws       = params[:dest_node_name]
    @url_test = HttpTestScore.where('dest_url = ?', @ws).order('total_scores DESC')
  end

  def locale_ranking
    dx            = TestDestNode.find_all_by_locale('电信').size
    lt            = TestDestNode.find_all_by_locale('联通').size
    yd            = TestDestNode.find_all_by_locale('移动').size
    tt            = TestDestNode.find_all_by_locale('铁通').size
    other         = TestDestNode.all.size - dx - lt - yd -tt
    @locale       = {}
    @locale['电信'] = dx
    @locale['联通'] = lt
    @locale['移动'] = yd
    @locale['铁通'] = tt
    @locale['其它'] = other
  end

  def time_report
    ef         = ExportName.find_all_by_user_id(current_user.id)
    d_str      = params[:date]
    ds         = params[:ds]
    time_str   = d_str + ' ' + ds
    time_begin = Time.parse(time_str)
    time_end   = time_begin + 1.hour

    key, odata, title_name = gen_report_csv(time_begin, time_end, ef)

    respond_to do |format|
      format.csv { send_data data_to_csv(title_name, key, odata), :filename => "#{time_begin.strftime('%Y%m%d-%H')}次报表.csv", :disposition => 'attachment' }
    end
  end

  def day_report_csv
    ef         = ExportName.find_all_by_user_id(current_user.id)
    d_str      = params[:date]
    time_str   = d_str
    time_begin = Time.parse(time_str)
    time_end   = time_begin + 1.day

    key, odata, title_name = gen_report_csv(time_begin, time_end, ef)

    respond_to do |format|
      format.csv { send_data data_to_csv(title_name, key, odata), :filename => "#{time_begin.strftime('%Y%m%d')}日报表.csv", :disposition => 'attachment' }
    end
  end

  def week_report_csv
    ef         = ExportName.find_all_by_user_id(current_user.id)
    db_str     = params[:day_begin]
    de_str     = params[:day_end]
    time_begin = Time.parse(db_str)
    time_end   = Time.parse(de_str)

    key, odata, title_name = gen_report_csv(time_begin, time_end, ef)

    respond_to do |format|
      format.csv { send_data data_to_csv(title_name, key, odata), :filename => "#{time_begin.strftime('%Y%m%d')}周报表.csv", :disposition => 'attachment' }
    end
  end

  def month_report_csv
    ef         = ExportName.find_all_by_user_id(current_user.id)
    ms         = params[:ms]
    tmp_str    = Time.now.year.to_s
    new_str    = tmp_str + '-' + ms + '-01'
    time_begin = Time.parse(new_str).at_beginning_of_month
    time_end   = time_begin + 1.month

    key, odata, title_name = gen_report_csv(time_begin, time_end, ef)

    respond_to do |format|
      format.csv { send_data data_to_csv(title_name, key, odata), :filename => "#{time_begin.strftime('%Y%m')}月报表.csv", :disposition => 'attachment' }
    end
  end

  def day_report
    #[dx,lt,oe,total_pos,total_neg,total_eql,dx_array,lt_array]
    ef          = ExportName.find_all_by_user_id(current_user.id)
    s_day       = params[:s_day]
    @time_begin = Time.parse(s_day).at_beginning_of_day
    @time_end   = @time_begin + 1.day

    @dx, @lt, @oe, @total_pos, @total_neg, @total_eql, @dx_array, @lt_array = cal_export_ranking @time_begin, @time_end, ef
    render :template => 'reports/export_ranking'
  end

  def week_report
    #开始时间是从选择时间的0点开始，结束时间是从选择的时间+1天的开始。
    ef          = ExportName.find_all_by_user_id(current_user.id)
    #[dx,lt,oe,total_pos,total_neg,total_eql,dx_array,lt_array]
    @time_begin = Time.parse(params[:day_begin]).at_beginning_of_day
    @time_end   = Time.parse(params[:day_end]).at_beginning_of_day + 1.day

    @dx, @lt, @oe, @total_pos, @total_neg, @total_eql, @dx_array, @lt_array = cal_export_ranking @time_begin, @time_end, ef
    render :template => 'reports/export_ranking'
  end

  def month_report
    #[dx,lt,oe,total_pos,total_neg,total_eql,dx_array,lt_array]
    ef          = ExportName.find_all_by_user_id(current_user.id)
    ms          = params[:ms]
    tmp_str     = Time.now.year.to_s
    new_str     = tmp_str + '-' + ms + '-01'
    @time_begin = Time.parse(new_str).at_beginning_of_month
    @time_end   = @time_begin + 1.month

    @dx, @lt, @oe, @total_pos, @total_neg, @total_eql, @dx_array, @lt_array = cal_export_ranking @time_begin, @time_end, ef
    render :template => 'reports/export_ranking'
  end

  def export_ranking
    #提取原来的方法成为了辅助方法，现在只做为纯模板映射。
  end

  def r_graph
    @en = params[:en]
    val = cal_data @en
    if val.blank?
      @value = []
    else
      @value = val
    end
  end

=begin
  def get_data
    @test_j = gen_json

    respond_to do |f|
      f.json { render json: @test_j }
    end
  end
=end

  def locale_detail
    @lc = params[:lc]
    if @lc != '其它'
      @out_lc = TestDestNode.where('locale = ?', @lc)
    else
      @out_lc = TestDestNode.where('locale not in (?)', ['电信', '联通', '移动', '铁通'])
    end
  end
end
