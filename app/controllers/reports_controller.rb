#encoding : utf-8
class ReportsController < ApplicationController
  BACKBONE = '广东铁通6-gddx(bgp)联通出口'
  def time_report
    time_data = HttpTestData.where('SourceNodeName = ? and TestTime > ? and TestTime < ?', BACKBONE, '2013-02-27 17:00:00',
                                       '2013-02-27 18:00:00')
    puts '-'*100+'>>'+time_data.count.to_s
    @count = time_data.count
  end

  def day_report

  end

  def week_report

  end
end
