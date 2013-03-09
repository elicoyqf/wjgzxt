#encoding : utf-8
require 'csv'
include UtiltilyTools

module CsvDb
  class CsvProcedure
    def testrake
      puts 'hello'
    end

    def csv_to_db(filename)
      #file = Rails.root.join('public', 'HTTP_201303012100.csv')
      ld    = LocaleData.all
      dx    = 0
      lt    = 0
      yd    = 0
      tt    = 0
      other = 0
      filename.each do |fname|
        case fname
          when /HTTP/
            i = 1
            CSV.foreach(fname, encoding: 'GB2312:UTF-8', headers: true) do |row|
              HttpTestData.create(test_time:       row[0], source_node_name: row[1], source_ip_address: row[2], source_group: row[3], dest_node_name: row[4],
                                  dest_url:        row[5], dest_group: row[6], resolution_time: row[7], connection_time: row[8], time_to_first_byte: row[9],
                                  time_to_index:   row[10], page_download_time: row[11], page_loading_time: row[12], total_time: row[13], throughput_time: row[14],
                                  overall_quality: row[15], resolution_sr: row[16], connection_sr: row[17], index_page_loading_sr: row[18],
                                  page_loading_r:  row[19], loading_sr: row[20], dest_ip_address: row[21], dest_nationality: row[22], dest_province: row[23],
                                  dest_locale:     row[24], download_size: row[25], contents_size: row[26], return_code: row[27], add_ons: row[28],
                                  element_number:  row[29])

              #更新归属地数据和测试网站相关信息
              sname = row[24].to_s.strip
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

              #直接将数据插入数据库即可，model进行限制去重。
              TestDestNode.create(dest_node_name: row[4].to_s.strip, dest_url: row[5].to_s.strip)

              i += 1
            end
            puts "http_data_file(#{fname}) have ------>" + i.to_s + ' lines.'
          when /Video/
            i = 1
            CSV.foreach(fname, encoding: 'GB2312:UTF-8', headers: true) do |row|
              VideoTestData.create(test_time:            row[0], source_node_name: row[1], source_ip_address: row[2], source_group: row[3],
                                   dest_node_name:       row[4], dest_url: row[5], dest_group: row[6], resolution_time: row[7], connection_time: row[8],
                                   time_to_first_byte:   row[9], time_to_first_frame: row[10], total_buffer_time: row[11],
                                   time_to_first_buffer: row[12], avg_buffer_rate: row[13], buffering_count: row[14], playback_duration: row[15],
                                   download_time:        row[16], throughput_time: row[17], playback: row[18], resolution_sr: row[19],
                                   rebuffering_rate:     row[20], connection_sr: row[21], total_sr: row[22], dest_ip_address: row[23],
                                   dest_nationality:     row[24], dest_province: row[25], dest_locale: row[26], download_size: row[27],
                                   contents_size:        row[28], return_code: row[29], add_ons: row[30])
              i += 1
            end
            puts "video_data_file(#{fname}) have ------>" + i.to_s + ' lines.'
          when /PING/
            i = 1
            CSV.foreach(fname, encoding: 'GB2312:UTF-8', headers: true) do |row|
              PingTestData.create(test_time:       row[0], source_node_name: row[1], source_ip_address: row[2], source_group: row[3], dest_node_name: row[4],
                                  dest_url:        row[5], dest_group: row[6], resolution_time: row[7], lost_packets: row[8],
                                  send_packets:    row[9], lost_packets_no: row[10], delay: row[11], max_delay: row[12], min_delay: row[13],
                                  std_delay:       row[14], jitter: row[15], max_jitter: row[16], min_jitter: row[17], std_jitter: row[18],
                                  dest_ip_address: row[19], dest_nationality: row[20], dest_province: row[21], dest_locale: row[22])
              i += 1
            end
            puts "ping_data_file(#{fname}) have ------>" + i.to_s + ' lines.'
          else

        end
      end

      ld.each do |tmp|
        case tmp.locale_name
          when '电信'
            puts 'dx is -----=>' + dx.to_s
            tmp.update_attribute(locale_number: dx)
          when '联通'
            puts 'lt is -----=>' + lt.to_s
            tmp.update_attribute(locale_number: lt)
          when '移动'
            puts 'yd is -----=>' + yd.to_s
            tmp.update_attribute(locale_number: yd)
          when '铁通'
            puts 'tt is -----=>' + tt.to_s
            tmp.update_attribute(locale_number: tt)
          else
            puts 'other is -----=>' + other.to_s
            tmp.update_attribute(locale_number: other)
        end
      end
    end

    #目前只对http数据分析
    def analyse_data_to_db(time_begin, time_end)
      t_b            = time_begin
      t_e            = time_end
      blackbone_data = blackbone_data_valid(t_b, t_e)
      other_data     = other_data_valid(t_b, t_e)

      other_data.each do |odata|
        flag_data = []
        blackbone_data.each do |bdata|
          if  odata.dest_url == bdata.dest_url
            flag_data << bdata
          end
        end
        #此处只取第一条对比数据出来进行对比
        cons_data = flag_data.first

        unless cons_data.blank?
          hts                         = {}
          hts[:test_time]             = odata.test_time
          hts[:source_node_name]      = odata.source_node_name
          hts[:source_ip_address]     = odata.source_ip_address
          hts[:source_group]          = odata.source_group
          hts[:dest_node_name]        = odata.dest_node_name
          hts[:dest_url]              = odata.dest_url
          hts[:dest_group]            = odata.dest_group
          hts[:return_code]           = odata.return_code
          hts[:dest_ip_address]       = odata.dest_ip_address
          hts[:dest_nationality]      = odata.dest_nationality
          hts[:dest_province]         = odata.dest_province
          hts[:dest_locale]           = odata.dest_locale

          #正分、负分、零分有多少项及各项的分值
          hts[:positive_items]        = 0
          hts[:negative_items]        = 0
          hts[:equal_items]           = 0
          hts[:positive_items_scores] = 0
          hts[:negative_items_scores] = 0
          hts[:equal_items_scores]    = 0
          scores                      = []

          psc = ParamScoreConfig.where('param_type = ? and weight > ?', 'htd', 0)
          psc.each do |pc|
            case pc.param_name
              when 'resolution_time'
                hts[:resolution_time] = cal_score(cons_data.resolution_time, odata.resolution_time, pc)
                scores << hts[:resolution_time]
              when 'connection_time'
                hts[:connection_time] = cal_score(cons_data.connection_time, odata.connection_time, pc)
                scores << hts[:connection_time]
              when 'time_to_first_byte'
                hts[:time_to_first_byte] = cal_score(cons_data.time_to_first_byte, odata.time_to_first_byte, pc)
                scores << hts[:time_to_first_byte]
              when 'time_to_index'
                hts[:time_to_index] = cal_score(cons_data.time_to_index, odata.time_to_index, pc)
                scores << hts[:time_to_index]
              when 'page_download_time'
                hts[:page_download_time] = cal_score(cons_data.page_download_time, odata.page_download_time, pc)
                scores << hts[:page_download_time]
              when 'page_loading_time'
                hts[:page_loading_time] = cal_score(cons_data.page_loading_time, odata.page_loading_time, pc)
                scores << hts[:page_loading_time]
              when 'total_time'
                hts[:total_time] = cal_score(cons_data.total_time, odata.total_time, pc)
                scores << hts[:total_time]
              when 'throughput_time'
                hts[:throughput_time] = cal_score(cons_data.throughput_time, odata.throughput_time, pc)
                scores << hts[:throughput_time]
              when 'overall_quality'
                hts[:overall_quality] = cal_score(cons_data.overall_quality, odata.overall_quality, pc)
                scores << hts[:overall_quality]
              when 'resolution_sr'
                hts[:resolution_sr] = cal_score(cons_data.resolution_sr, odata.resolution_sr, pc)
                scores << hts[:resolution_sr]
              when 'connection_sr'
                hts[:connection_sr] = cal_score(cons_data.connection_sr, odata.connection_sr, pc)
                scores << hts[:connection_sr]
              when 'index_page_loading_sr'
                hts[:index_page_loading_sr] = cal_score(cons_data.index_page_loading_sr, odata.index_page_loading_sr, pc)
                scores << hts[:index_page_loading_sr]
              when 'page_loading_r'
                hts[:page_loading_r] = cal_score(cons_data.page_loading_r, odata.page_loading_r, pc)
                scores << hts[:page_loading_r]
              when 'loading_sr'
                hts[:loading_sr] = cal_score(cons_data.loading_sr, odata.loading_sr, pc)
                scores << hts[:loading_sr]
              when 'download_size'
                hts[:download_size] = cal_score(cons_data.download_size, odata.download_size, pc)
                scores << hts[:download_size]
              when 'contents_size'
                hts[:contents_size] = cal_score(cons_data.contents_size, odata.contents_size, pc)
                scores << hts[:contents_size]
              when 'add_ons'
                hts[:add_ons] = cal_score(cons_data.add_ons, odata.add_ons, pc)
                scores << hts[:add_ons]
              when 'element_number'
                hts[:element_number] = cal_score(cons_data.element_number, odata.element_number, pc)
                scores << hts[:element_number]
              else
                puts 'null.'
            end
          end

          hts[:positive_items], hts[:positive_items_scores], hts[:negative_items], hts[:negative_items_scores], hts[:equal_items],
              hts[:equal_items_scores] =statis_score scores

          hts[:total_scores] = hts[:positive_items_scores] + hts[:negative_items_scores]
          hts_record         = HttpTestScore.new(hts)
          if hts_record.save
            puts '-'*50+'save success.'
          else
            puts '-'*20+'save failure.'
          end
        end
      end
    end
  end
end