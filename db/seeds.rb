# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ParamScoreConfig.create(param_name: 'resolution_time', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'connection_time', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'time_to_first_byte', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'time_to_index', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'page_download_time', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'page_loading_time', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'total_time', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'throughput_time', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'overall_quality', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'resolution_sr', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'connection_sr', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'index_page_loading_sr', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'page_loading_r', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'loading_sr', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'download_size', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'contents_size', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'add_ons', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)
ParamScoreConfig.create(param_name: 'element_number', param_type: 'htd', normal: 0, good: 1, better: 2, bad: -1, worse: -2)

ParamRuleConfig.create(param_name: 'resolution_time', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'connection_time', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'time_to_first_byte', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'time_to_index', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'page_download_time', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'page_loading_time', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'total_time', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'throughput_time', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'overall_quality', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'resolution_sr', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'connection_sr', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'index_page_loading_sr', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'page_loading_r', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'loading_sr', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'download_size', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'contents_size', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'add_ons', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)
ParamRuleConfig.create(param_name: 'element_number', param_type: 'htd', item_type: 1, lower_limit: 1, upper_limit: 2)