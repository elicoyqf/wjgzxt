#encoding : utf-8
module ReportsHelper
  BACKBONE  = '广东铁通6-gddx(bgp)联通出口'
  #骨干为null，自租出口非null
  ZZNOTNULL = 2
  #骨干不为null,而自租出口为null
  ZZNULL    = -2

  #骨干出口有效数据
  def blackbone_data_valid
    backbone_data     = HttpTestData.where('source_node_name = ? and test_time >= ? and test_time < ?', BACKBONE, Time.parse('2013-03-1 21:00:00'),
                                           Time.parse('2013-03-1 22:00:00'))
    new_backbone_data = []
    backbone_data.each do |bline|
      host_locale =''
      if !bline.dest_locale.blank? && bline.dest_locale.to_s.strip != 'NULL'
        host_locale = bline.dest_locale.to_s.strip
      end

      #判断自租出口数据是否有效的条件
      #目前只监测联通和电信出口
      if  !host_locale.blank? && host_locale == '联通' || host_locale == '电信'
        new_backbone_data << bline
        puts 'blackbone'+'-'*100+bline.id.to_s
      end
    end
    backbone_data
  end

  #对自租出口提取有效数据
  def other_data_valid
    other_data = HttpTestData.where('source_node_name != ? and test_time >= ? and test_time < ?', BACKBONE, Time.parse('2013-03-1 21:00:00'),
                                    Time.parse('2013-03-1 22:00:00'))
    new_data   =[]
    other_data.each do |line|
      source_node_arr = line.source_node_name.to_s.strip[-4..-3]
      host_locale     =''
      if !line.dest_locale.blank? && line.dest_locale.to_s.strip != 'NULL'
        host_locale = line.dest_locale.to_s.strip
      end

      #判断自租出口数据是否有效的条件
      #出口与归属地必须要一致才有效
      if !source_node_arr.blank? && !host_locale.blank? && (source_node_arr == host_locale)
        new_data << line
        puts 'other'+'-'*100+line.id.to_s
      end
    end
    new_data
  end

  def data_to_csv(data, option={})
    CSV.generate(option) do |csv|
      csv << %w(TestTime SourceNodeName SourceIPAddress  SourceGroup DestNodeName DestURL DestGroup ResolutionTime ConnectionTime TimeToFirstByte
              TimeToIndex PageDownloadTime PageLoadingTime TotalTime ThroughputTime OverallQuality ResolutionSR ConnectionSR  IndexPageLoadingSR PageLoadingR
              LoadingSR DestIPAddress DestNationality DestProvince DestLocale DownloadSize ContentsSize ReturnCode AddOns ElementNumber
              positive_items negative_items equal_items positiveItems_scores negativeItems_scores equalItems_scores total_scores)
      data.each do |tdata|
        csv << [tdata.test_time, tdata.source_node_name, tdata.source_ip_address, tdata.source_group, tdata.dest_node_name, tdata.dest_url,
                tdata.dest_group, tdata.resolution_time, tdata.connection_time, tdata.time_to_first_byte, tdata.time_to_index,
                tdata.page_download_time, tdata.page_loading_time, tdata.total_time, tdata.throughput_time, tdata.overall_quality,
                tdata.resolution_sr, tdata.connection_sr, tdata.index_page_loading_sr, tdata.page_loading_r, tdata.loading_sr,
                tdata.dest_ip_address, tdata.dest_nationality, tdata.dest_province, tdata.dest_locale, tdata.download_size, tdata.contents_size,
                tdata.return_code, tdata.add_ons, tdata.element_number, tdata.positive_items, tdata.negative_items, tdata.equal_items,
                tdata.positiveItems_scores, tdata.negativeItems_scores, tdata.equalItems_scores, tdata.total_scores]
      end
    end
  end

  def cal_score(cons_data, odata)
    t_score = 0
    if cons_data == 'NULL'
      if odata != 'NULL'
        t_score = ZZNOTNULL
      end
    else
      if odata == 'NULL'
        t_score = ZZNULL
      elsif odata.to_s.to_f < cons_data.to_s.to_f
        t_score += 1
      elsif cons_data.to_s.to_f <= odata.to_s.to_f && odata.to_s.to_f <= cons_data.to_s.to_f * 2
        t_score += 0
      elsif cons_data.to_s.to_f*2 < odata.to_s.to_f
        t_score += -1
      end
    end
    t_score
=begin
    if t_score > 0
      positive_items    += 1
      positive_i_scores += t_score
    elsif t_score == 0
      equal_items        += 1
      equal_items_scores += t_score
    else
      negative_items    += 1
      negative_i_scores += t_score
    end
=end
    #%w(t_score,positive_items,positive_items_scores,equal_items,equal_items_scores,negative_items,negative_items_scores)
  end

  def statis_score(arr)
    positive_items     = 0
    equal_items        = 0
    negative_items     = 0
    positive_i_scores  = 0
    equal_items_scores = 0
    negative_i_scores  = 0

    arr.each do |element|
      if element > 0
        positive_items    += 1
        positive_i_scores += element
      elsif element < 0
        negative_items    += 1
        negative_i_scores += element
      else
        equal_items        += 1
        equal_items_scores += element
      end
    end
    [positive_items, positive_i_scores, negative_items, negative_i_scores, equal_items, equal_items_scores]
  end


end
