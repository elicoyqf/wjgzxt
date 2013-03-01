#encoding : utf-8
require 'csv'
require_relative '../../app/models/http_test_data '

module CsvDb
  class CsvProcedure
    BACKBONE = '广东铁通6-gddx(bgp)联通出口'

    def testrake
      puts 'hello'
    end

    def csv_to_db
      file = Rails.root.join('public', 'HTTP_201302271700.csv')
      i    = 1
      CSV.foreach(file, encoding: 'GB2312:UTF-8', headers: true) do |row|
        HttpTestData.create(TestTime:       row[0], SourceNodeName: row[1], SourceIPAddress: row[2], SourceGroup: row[3], DestNodeName: row[4],
                            DestURL:        row[5], DestGroup: row[6], ResolutionTime: row[7], ConnectionTime: row[8], TimeToFirstByte: row[9],
                            TimeToIndex:    row[10], PageDownloadTime: row[11], PageLoadingTime: row[12], TotalTime: row[13], ThroughputTime: row[14],
                            OverallQuality: row[15], ResolutionSR: row[16], ConnectionSR: row[17], IndexPageLoadingSR: row[18],
                            PageLoadingR:   row[19], LoadingSR: row[20], DestIPAddress: row[21], DestNationality: row[22], DestProvince: row[23],
                            DestLocale:     row[24], DownloadSize: row[25], ContentsSize: row[26], ReturnCode: row[27], AddOns: row[28],
                            ElementNumber:  row[29])
        puts i
        i += 1
      end
    end

    def time_report
      time_data = HttpTestData.where('SourceNodeName = ? and TestTime > ? and TestTime < ?', BACKBONE,'2013-02-27 17:00:00',
                                         '2013-02-27 18:00:00')
      puts time_data.count


    end

    def day_report

    end

    def week_report

    end
  end
end