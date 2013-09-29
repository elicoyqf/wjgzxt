#encoding : utf-8

require 'will_paginate/array'
class RdataController < ApplicationController
  def index
    @ds = []
    (0..23).each do |n|
      @ds << [n, n]
    end
  end

  def q_rdata_report
    d_str      = params[:date]
    ds         = params[:ds]
    time_str   = d_str + ' ' + ds
    time_begin = Time.parse(time_str)
    time_end   = time_begin + 1.hour

    #先去统计表里面查询得负分的记录
    #然后再去原始记录表中查询原始记录

    #通过用户获得其所管辖的出口
    user       = User.find(session[:user_id])
    e_name     = user.export_names
    oth_arr    = []
    @out       = []
    if e_name.blank?
      ena = ExportName.all
      ena.each do |en|
        tmp_arr   = []
        p_records = HttpTestScore.where('test_time >= ? and test_time < ? and source_node_name = ? and total_scores < 0 ', time_begin, time_end, en.alias)
        unless p_records.blank?
          p_records.each do |line|
            q_data = HttpTestData.where('test_time = ? and dest_node_name = ? and  dest_url = ?', line.test_time, line.dest_node_name, line.dest_url).first
            unless q_data.blank?
              tmp_arr << q_data.test_time << en.name << q_data.dest_url << q_data.time_to_index << q_data.total_time << q_data.throughput_time << q_data.connection_sr << q_data.index_page_loading_sr
            end
          end
        end

        oth_arr << tmp_arr
      end
    else
      e_name.each do |en|
        tmp_arr   = []
        p_records = HttpTestScore.where('test_time >= ? and test_time < ? and source_node_name = ? and total_scores < 0 ', time_begin, time_end, en.alias)
        unless p_records.blank?
          p_records.each do |line|
            q_data = HttpTestData.where('test_time = ? and dest_node_name = ? and  dest_url = ?', line.test_time, line.dest_node_name, line.dest_url).first
            unless q_data.blank?
              tmp_arr << q_data.test_time << en.name << q_data.dest_url << q_data.time_to_index << q_data.total_time << q_data.throughput_time << q_data.connection_sr << q_data.index_page_loading_sr
            end
          end
        end

        oth_arr << tmp_arr
      end
    end

    #查询骨干网数据,还要进行对比
    oth_arr.each do |line|
      tmp_arr = []
      tmp_arr << line
      bbdata = HttpTestData.where('test_time >= ? and test_time < ? and source_node_name = ?  and  dest_url = ? ', time_begin, time_end, BACKBONE, line[2])
      unless bbdata.blank?
        if bbdata.size == 1
          if bbdata.first.dest_locale =~/电信/ || bbdata.first.dest_locale =~ /联通/
            tmp_arr << [bbdata.first.test_time, BACKBONE, bbdata.first.dest_url, bbdata.first.time_to_index, bbdata.first.total_time, bbdata.first.throughput_time, bbdata.first.connection_sr, bbdata.first.index_page_loading_sr]
            @out << tmp_arr
          end
        else
          bbdata.each do |bb|
            if bb.dest_locale =~/电信/ || bb.dest_locale =~ /联通/
              tmp_arr << [bb.test_time, BACKBONE, bb.dest_url, bb.time_to_index, bb.total_time, bb.throughput_time, bb.connection_sr, bb.index_page_loading_sr]
              @out << tmp_arr
            end
            @out << tmp_arr
          end
        end
      end

      @out = @out.paginate(page: params[:page], per_page: 5)
    end
  end
end