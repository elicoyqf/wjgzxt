# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
#添加环境变量,否则找不到bundle命令。
set :output, "#{path}/log/whenever.log" #设置日志输出文件

#每个小时的第5分钟开始导入数据
every '1 * * * *' do
  rake 'database:csv2db'
end

#每个小时的第10分钟开始分析数据
#目前只对http数据分析
every '20 * * * *' do
  rake 'database:analyse_data'
end

#在每天的1点57分重新新建表,刚好一天所有的数据在一张表里面
every '57 1 * * *' do
  rake 'database:newtable'
end

#在7月14日的1点40分启动重新数据评测机制
every '40 1 14 7 *' do
  rake 'database:analyse_old_data'
end

#每天的晚班时间内做检查，从2点开始做到5点
#every '20 2-6 * * *' do
#  rake 'database:wocheck'
#end
#
#every '20 7 * * *' do
#  rake 'database:wofailcheck'
#end