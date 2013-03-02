#encoding: utf-8

namespace :database do
  BACKBONE = '广东铁通6-gddx(bgp)联通出口'
  desc '定时执行将csv原始文件导入至数据库中'
  task :csv2db => :environment do
    update_db = CsvDb::CsvProcedure.new
    update_db.csv_to_db
  end

  desc '按次出报表'
  task :time_report => :environment do
    te = CsvDb::CsvProcedure.new
    te.time_report
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