#encoding: utf-8

namespace :database do
  BACKBONE = '广东铁通6-gddx(bgp)联通出口'
  desc '定时执行将csv原始文件导入至数据库中'
  task :csv2db => :environment do
    #todo:此处的文件位置还需要再调整，可以直接通过绝对路径指向目录
    #dir = '/home/wgdata/'
    #time = Time.now.at_beginning_of_hour - 1.hour
    #c_name = 'HTTP_'+ time.strftime('%Y%m%d%H%M')+'.csv'
    #filename =  "HTTP_201303022100.csv"
    filename = '/home/wgdata/HTTP_201303022100.csv'
    update_db = CsvDb::CsvProcedure.new
    update_db.csv_to_db filename
  end

  desc '定时分析数据'
  task :analyse_data => :environment do
    #取前一个小时的数据进行自动分析
    time_begin = Time.now.at_beginning_of_hour - 1.hour
    time_end   = Time.now.at_beginning_of_hour

    #通过数据进行分析
    a_data     = CsvDb::CsvProcedure.new
    a_data.analyse_data_to_db(time_begin, time_end)
  end

  desc '定时清除60天以前的数据'
  task :dbclear => :environment do

  end

  desc '测试是否生效'
  task :test => :environment do
    te = CsvDb::CsvProcedure.new
    te.testrake
  end
end