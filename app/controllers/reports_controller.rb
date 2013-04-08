#encoding : utf-8
require 'set'
#
class ReportsController < ApplicationController
  def index

  end

  def select_date_report
    @ds = []
    (0..23).each do |n|
      @ds << [n, n]
    end
  end

  def date2time_report
    d_str       = params[:date]
    ds          = params[:ds]
    time_str    = d_str + ' ' + ds
    time_begin  = Time.parse(time_str)
    time_end    = time_begin + 1.hour
    psc         = ParamScoreConfig.where('param_type = ? and weight > ? ', 'htd', 0)
    @title_name = []
    key1        = %w( source_node_name dest_node_name)
    key2        =%w(positive_items_scores negative_items_scores total_scores)

    key3 = []
    psc.each do |config|
      @title_name << config.alias
      key3 << config.param_name
    end
    key = key1 + key3 + key2

    @odata = HttpTestScore.select(key).where('test_time >= ? and test_time < ?', time_begin, time_end).order('total_scores DESC')

  end

  def export_ranking
    #查询当月的月表数据
    hts     = HttpTestStatis.where('start_time >= ? and start_time < ?', Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month)
    @e_name = Set.new
    hts.each do |line|
      @e_name << line.export_name
    end
    #将对比标杆出口去掉
    @e_name.delete(BACKBONE)

    @dx = TestDestNode.where('locale = ?', '电信').count
    @lt = TestDestNode.where('locale = ?', '联通').count
    @oe = TestDestNode.all.count - @dx - @lt

    @total_pos = 0
    @total_neg = 0
    @total_eql = 0
    match_web  = Set.new
    negat_web  = Set.new
    @dx_array  = []
    @lt_array  = []
    @e_name.each do |ename|
      negative_total = 0
      all_total      = 0
      negative_web   = 0
      #用于封装所有数据的数组[出口名称，负值，总分，负值网站次数，有效总匹配网站数]
      t_array        = []
      t_array << ename
      match_web.clear
      negat_web.clear
      tmp = HttpTestScore.select('dest_url, total_scores').where('test_time >= ? and test_time < ? and source_node_name = ?',
                                                                 Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month, ename)
      tmp.each do |t|
        match_web << t.dest_url
        if t.total_scores < 0
          negat_web << t.dest_url
        end
      end
      negative_total = hts.where('export_name = ? ', ename).sum(:negative_statis)
      all_total      = hts.where('export_name = ? ', ename).sum(:total_statis)
      negative_web   = negat_web.size
      if all_total > 0
        @total_pos += 1
      elsif all_total < 0
        @total_neg += 1
      else
        @total_eql += 1
      end
      t_array << negative_total
      t_array << all_total
      t_array << negative_web
      t_array << match_web.size
      mws = match_web.size
      if match_web.size != 0
        t_array << (((mws.to_f - negative_web.to_f) / mws.to_f) * 100)
      else
        t_array << 0
      end

      if t_array[0][-4..-3] == '电信'
        @dx_array << t_array
      else
        @lt_array << t_array
      end
    end
    @dx_array.sort_by! { |x| x[1] }
    @lt_array.sort_by! { |x| x[1] }
  end

  def website_select
    @tdn = TestDestNode.all

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
    #todo:需要考虑不同的类型的数据报表，此处未实现
    psc        = ParamScoreConfig.where('param_type = ? and weight > ? ', 'htd', 0)
    title_name = []
    key1       = %w(test_time source_node_name source_ip_address source_group dest_node_name dest_url dest_group)
    key2       =%w(dest_ip_address dest_nationality dest_province dest_locale positive_items negative_items equal_items positive_items_scores
negative_items_scores equal_items_scores total_scores)

    key3 = []
    psc.each do |config|
      title_name << config.alias
      key3 << config.param_name
    end
    key = key1 + key3 + key2

    odata = HttpTestScore.select(key).order('source_node_name')

    respond_to do |format|
      format.csv { send_data data_to_csv(title_name, key, odata), :filename => '次报表.csv', :disposition => 'attachment' }
    end
  end

  def day_report

  end

  def week_report

  end
end
