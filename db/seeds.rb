#encoding : utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#http设置默认参数
ParamScoreConfig.create(param_name: 'resolution_time', alias: '解析时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'connection_time', alias: '连接时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'time_to_first_byte', alias: '首字节时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'time_to_index', alias: '首页打开时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  2, lower_limit: 1, upper_limit: 2, weight: 1)
ParamScoreConfig.create(param_name: 'page_download_time', alias: '页面下载时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'page_loading_time', alias: '页面加载时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name:  'total_time', alias: '总时间', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1, item_type: 2,
                        lower_limit: 1, upper_limit: 2, weight: 1)
ParamScoreConfig.create(param_name: 'throughput_time', alias: '吞吐率', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 0.5, upper_limit: 1, weight: 1)
ParamScoreConfig.create(param_name: 'overall_quality', alias: '综合质量', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'resolution_sr', alias: '解析成功率', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'connection_sr', alias: '连接成功率', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 0.9, upper_limit: 1, weight: 1)
ParamScoreConfig.create(param_name: 'index_page_loading_sr', alias: '首页加载成功率', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 0.9, upper_limit: 1, weight: 1)
ParamScoreConfig.create(param_name: 'page_loading_r', alias: '加载比例', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name:  'loading_sr', alias: '成功率', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1, item_type: 1,
                        lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'download_size', alias: '下载大小', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'contents_size', alias: '内容大小', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name:  'add_ons', alias: '附加项', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1, item_type: 1,
                        lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'element_number', alias: '元素数量', param_type: 'htd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)

#ping设置默认参数
ParamScoreConfig.create(param_name: 'resolution_time', alias: '解析时间', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'lost_packets', alias: '丢包', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 1)
ParamScoreConfig.create(param_name: 'send_packets', alias: '发包数', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'lost_packets_no', alias: '丢包数', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  2, lower_limit: 1, upper_limit: 1.5, weight: 0)
ParamScoreConfig.create(param_name: 'delay', alias: '时延', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  2, lower_limit: 1, upper_limit: 2, weight: 1)
ParamScoreConfig.create(param_name: 'max_delay', alias: '最大时延', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'min_delay', alias: '最小时延', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'std_delay', alias: 'STD 时延', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'jitter', alias: '抖动', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'max_jitter', alias: '最大抖动', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'min_jitter', alias: '最小抖动', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'std_jitter', alias: 'STD 抖动', param_type: 'ptd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)

#video设置默认参数
ParamScoreConfig.create(param_name: 'resolution_time', alias: '解析时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'connection_time', alias: '连接时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'time_to_first_byte', alias: '首字节时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'time_to_first_frame', alias: '首帧时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'total_buffer_time', alias: '总缓冲时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  2, lower_limit: 1, upper_limit: 2, weight: 1)
ParamScoreConfig.create(param_name: 'time_to_first_buffer', alias: '首缓冲时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'avg_butffer_rate', alias: '平均缓冲比', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'buffering_count', alias: '缓冲次数', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  2, lower_limit: 1, upper_limit: 2, weight: 1)
ParamScoreConfig.create(param_name: 'playback_duration', alias: '播放时长', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'download_time', alias: '下载时间', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'throuthput_time', alias: '吞吐率', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 0.5, upper_limit: 1, weight: 1)
ParamScoreConfig.create(param_name: 'playback_rate', alias: '播放速率', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'resolution_sr', alias: '解析成功率', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'rebuffering_rate', alias: '再缓冲率', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'connection_sr', alias: '连接成功率', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 0.9, upper_limit: 1, weight: 1)
ParamScoreConfig.create(param_name: 'total_sr', alias: '成功率', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'download_size', alias: '下载大小', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'contents_size', alias: '内容大小', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'return_code', alias: '返回码', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)
ParamScoreConfig.create(param_name: 'add_ons', alias: '附加项', param_type: 'vtd', normal: 0, good: 1, better: 1, bad: -1, worse: -1,
                        item_type:  1, lower_limit: 1, upper_limit: 2, weight: 0)






























