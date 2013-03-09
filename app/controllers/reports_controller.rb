#encoding : utf-8
require 'set'

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
    hts     = HttpTestScore.where('test_time >= ? and test_time < ?', Time.now.at_beginning_of_month, Time.now.at_beginning_of_month + 1.month)
    @export = Set.new
    hts.each do |line|
      @export.add line.source_node_name
    end
    @nega_arr  = []
    @nega_no   = []
    @total_arr = []
    @match_no  = []
    @dx        = 0
    @lt        = 0
    match      = Set.new

    @export.each do |e|
      nega_val  = 0
      total_val = 0
      negano    = 0
      match.clear
      export_s  = HttpTestScore.find_all_by_source_node_name(e)
      export_s.each do |es|
        total_val += es.total_scores
        if es.total_scores < 0
          nega_val += es.total_scores
          negano   += 1
        end
        match << es.dest_url
      end

      ename = e[-4..-3]
      case ename
        when '电信'
          @dx += 1
        when '联通'
          @lt += 1
        else
      end

      @nega_no << negano
      @nega_arr << nega_val
      @total_arr << total_val
      @match_no << match.size
    end


  end

  def website_select
    @tdn = TestDestNode.all

  end

  def website_ranking
    @ws       = params[:dest_node_name]
    @url_test = HttpTestScore.where('dest_url = ?', @ws).order('total_scores DESC')
  end

  def locale_ranking
    @ldata = LocaleData.all
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
