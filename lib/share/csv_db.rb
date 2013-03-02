#encoding : utf-8
require 'csv'

module CsvDb
  class CsvProcedure
    BACKBONE  = '广东铁通6-gddx(bgp)联通出口'
    #骨干为null，自租出口非null
    ZZNOTNULL = 2
    #骨干不为null,而自租出口为null
    ZZNULL    = -2

    def testrake
      puts 'hello'
    end

    def csv_to_db
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

    def analyse_data_to_db

    end


  end
end