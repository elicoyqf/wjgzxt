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

  def website_ranking
    #todo:此处还需要进行过滤出口名单
    @hts      = HttpTestScore.first
    #export = Set.new
    #hts.each do |line|
    #  export.add line.dest_url
    #end
    #@name = export.first
    @url_test = HttpTestScore.where('dest_url = ?', @hts.dest_url).order('total_scores DESC')
  end

  def locale_ranking

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
