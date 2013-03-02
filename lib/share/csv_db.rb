#encoding : utf-8
require 'csv'
include UtiltilyTools

module CsvDb
  class CsvProcedure
    def testrake
      puts 'hello'
    end

    def csv_to_db(filename)
      file = Rails.root.join('public', 'HTTP_201303012100.csv')
      i    = 1
      CSV.foreach(file, encoding: 'GB2312:UTF-8', headers: true) do |row|
        HttpTestData.create(test_time:       row[0], source_node_name: row[1], source_ip_address: row[2], source_group: row[3], dest_node_name: row[4],
                            dest_url:        row[5], dest_group: row[6], resolution_time: row[7], connection_time: row[8], time_to_first_byte: row[9],
                            time_to_index:   row[10], page_download_time: row[11], page_loading_time: row[12], total_time: row[13], throughput_time: row[14],
                            overall_quality: row[15], resolution_sr: row[16], connection_sr: row[17], index_page_loading_sr: row[18],
                            page_loading_r:  row[19], loading_sr: row[20], dest_ip_address: row[21], dest_nationality: row[22], dest_province: row[23],
                            dest_locale:     row[24], download_size: row[25], contents_size: row[26], return_code: row[27], add_ons: row[28],
                            element_number:  row[29])
        puts i
        i += 1
      end
    end

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

        #todo:此处对比未考虑权重因素，后期需要加上。
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

          hts[:resolution_time] = cal_score(cons_data.resolution_time, odata.resolution_time)
          scores << hts[:resolution_time]

          hts[:connection_time] = cal_score(cons_data.connection_time, odata.connection_time)
          scores << hts[:connection_time]

          hts[:time_to_first_byte] = cal_score(cons_data.time_to_first_byte, odata.time_to_first_byte)
          scores << hts[:time_to_first_byte]

          hts[:time_to_index] = cal_score(cons_data.time_to_index, odata.time_to_index)
          scores << hts[:time_to_index]

          hts[:page_download_time] = cal_score(cons_data.page_download_time, odata.page_download_time)
          scores << hts[:page_download_time]

          hts[:page_loading_time] = cal_score(cons_data.page_loading_time, odata.page_loading_time)
          scores << hts[:page_loading_time]

          hts[:total_time] = cal_score(cons_data.total_time, odata.total_time)
          scores << hts[:total_time]

          hts[:throughput_time] = cal_score(cons_data.throughput_time, odata.throughput_time)
          scores << hts[:throughput_time]

          hts[:overall_quality] = cal_score(cons_data.overall_quality, odata.overall_quality)
          scores << hts[:overall_quality]

          hts[:resolution_sr] = cal_score(cons_data.resolution_sr, odata.resolution_sr)
          scores << hts[:resolution_sr]

          hts[:connection_sr] = cal_score(cons_data.connection_sr, odata.connection_sr)
          scores << hts[:connection_sr]

          hts[:index_page_loading_sr] = cal_score(cons_data.index_page_loading_sr, odata.index_page_loading_sr)
          scores << hts[:index_page_loading_sr]

          hts[:page_loading_r] = cal_score(cons_data.page_loading_r, odata.page_loading_r)
          scores << hts[:page_loading_r]

          hts[:loading_sr] = cal_score(cons_data.loading_sr, odata.loading_sr)
          scores << hts[:loading_sr]

          hts[:download_size] = cal_score(cons_data.download_size, odata.download_size)
          scores << hts[:download_size]

          hts[:contents_size] = cal_score(cons_data.contents_size, odata.contents_size)
          scores << hts[:contents_size]

          hts[:add_ons] = cal_score(cons_data.add_ons, odata.add_ons)
          scores << hts[:add_ons]

          hts[:element_number] = cal_score(cons_data.element_number, odata.element_number)
          scores << hts[:element_number]

          puts scores.inspect
          hts[:positive_items], hts[:positive_items_scores], hts[:negative_items], hts[:negative_items_scores], hts[:equal_items],
              hts[:equal_items_scores] =statis_score scores

          hts[:total_scores] = hts[:positive_items_scores] + hts[:negative_items_scores]
          hts_record         = HttpTestScore.new(hts)
          if hts_record.save
            puts '-'*100+'保存成功.'
          else
            puts '-'*100+'保存失败.'
          end
        end
      end
    end

  end
end