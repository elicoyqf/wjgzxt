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

#每天的正常上班时间内，一个小时内做4次，每次15分钟
#every '9,25,41,57 8-22 * * *' do
#  rake 'database:woprocess'
#end

#每天的晚班时间内做检查，从2点开始做到5点
#every '20 2-6 * * *' do
#  rake 'database:wocheck'
#end
#
#every '20 7 * * *' do
#  rake 'database:wofailcheck'
#end