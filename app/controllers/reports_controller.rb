#encoding : utf-8
require 'set'

class ReportsController < ApplicationController
  def index

  end

  def export_ranking
    #todo:此处还需要进行过滤出口名单
    hts     = HttpTestScore.all
    @export = Set.new
    hts.each do |line|
      @export.add line.source_node_name
    end
    @nega_arr  = []
    @total_arr = []

    @export.each do |e|
      nega_val  = 0
      total_val = 0
      export_s  = HttpTestScore.where('source_node_name = ?', e)
      export_s.each do |es|
        nega_val  += es.negative_items_scores
        total_val += es.total_scores
      end
      @nega_arr << nega_val
      @total_arr << total_val

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
    #todo:此处不能选择全部，正式应用后应该在每次自动更新数据库表数据。并且此处未去重复数据。
    hts = HttpTestData.where('source_node_name = ? and test_time >= ? and test_time < ?', BACKBONE, Time.parse('2013-03-1 21:00:00'),
                             Time.parse('2013-03-1 22:00:00'))
    ld  = LocaleData.all
    if ld.blank?
      dx    = 0
      lt    = 0
      yd    = 0
      tt    = 0
      other = 0
      hts.each do |h|
        sname = h.dest_locale.to_s.strip
        puts '-'*50+sname
        case sname
          when '电信'
            dx += 1
          when '联通'
            lt += 1
          when '移动'
            yd += 1
          when '铁通'
            tt += 1
          else
            other += 1
        end
      end
      LocaleData.create(locale_name: '电信',locale_number: dx)
      LocaleData.create(locale_name: '联通',locale_number: lt)
      LocaleData.create(locale_name: '移动',locale_number: yd)
      LocaleData.create(locale_name: '铁通',locale_number: tt)
      LocaleData.create(locale_name: '其它',locale_number: other)
    end
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
