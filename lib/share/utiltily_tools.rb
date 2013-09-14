#encoding : utf-8
module UtiltilyTools
  BACKBONE  = '广东铁通6-gddx(bgp)联通出口'
  #骨干为null，自租出口非null
  ZZNOTNULL = 1
  #骨干不为null,而自租出口为null
  ZZNULL    = -1

  #骨干出口有效数据
  def blackbone_data_valid(time_begin, time_end, ds = nil)
    #backbone_data     = HttpTestData.where('source_node_name = ? and test_time >= ? and test_time < ?', BACKBONE, Time.parse('2013-03-1 21:00:00'),
    #                                       Time.parse('2013-03-1 22:00:00'))
    if ds == nil
      backbone_data = HttpTestData.where('source_node_name = ? and test_time >= ? and test_time < ?', BACKBONE, time_begin, time_end)
    else
      backbone_data = ds.where('source_node_name = ? and test_time >= ? and test_time < ?', BACKBONE, time_begin, time_end)
    end
    new_backbone_data = []
    backbone_data.each do |bline|
      host_locale =''
      if !bline.dest_locale.blank? && bline.dest_locale.to_s.strip != 'NULL'
        host_locale = bline.dest_locale.to_s.strip
      end

      #判断自租出口数据是否有效的条件
      #目前只监测联通和电信出口
      if  !host_locale.blank? && host_locale =~ /联通/ || host_locale =~ /电信/
        new_backbone_data << bline
        #puts 'blackbone'+'-'*100+bline.id.to_s
      end
    end
    new_backbone_data
  end

  #对自租出口提取有效数据
  def other_data_valid(time_begin, time_end, ds = nil)
    if ds == nil
      other_data = HttpTestData.where('source_node_name != ? and test_time >= ? and test_time < ?', BACKBONE, time_begin, time_end)
    else
      other_data = ds.where('source_node_name != ? and test_time >= ? and test_time < ?', BACKBONE, time_begin, time_end)
    end
    new_data =[]
    other_data.each do |line|
      #编号要去出口对应关系里面找对应关系
      eno         = line.source_node_name.to_s
      e_name      = ExportName.find_by_alias(eno).name

      #source_node_arr = line.source_node_name.to_s.strip[-4..-3]
      host_locale =''
      if !line.dest_locale.blank? && line.dest_locale.to_s.strip != 'NULL'
        host_locale = line.dest_locale.to_s.strip
      end

      #判断自租出口数据是否有效的条件
      #出口与归属地必须要一致才有效
      if !e_name.blank? && !host_locale.blank? && contrast_locale(e_name, host_locale)
        new_data << line
        #puts 'other'+'-'*100+line.id.to_s
      end
    end
    new_data
  end

  def contrast_locale(ename, locale)
    if locale =~ /电信/
      ll = '电信'
    elsif locale =~ /联通/
      ll = '联通'
    else
      ll = '其它'
    end

    if ename =~ /#{ll}/
      true
    else
      false
    end
  end

  def cal_score(cons_data, odata, pc)
    t_score = 0
    weight  = pc.weight
    type    = pc.item_type
    ll      = pc.lower_limit
    ul      = pc.upper_limit

    if cons_data == 'NULL'
      if odata != 'NULL'
        t_score = ZZNOTNULL
      end
    else
      if odata == 'NULL'
        t_score = ZZNULL
      else
        case type
          when 1
            #越大越好
            t_score = cal_method_3(cons_data, odata, ll, ul)
          when 2
            #越小越好
            t_score = cal_method_4(cons_data, odata, ll, ul)
          else
        end
      end
    end
    t_score * weight
  end

  def cal_method_3(cons_data, odata, ll, ul)
    sc = 0
    if odata.to_s.to_f > cons_data.to_s.to_f
      sc = 1
    elsif odata.to_s.to_f == cons_data.to_s.to_f
      sc = 0
    elsif odata.to_s.to_f < cons_data.to_s.to_f
      sc = -1
    end
    sc
  end

  def cal_method_4(cons_data, odata, ll, ul)
    sc = 0
    if odata.to_s.to_f < cons_data.to_s.to_f
      sc = 1
    elsif odata.to_s.to_f == cons_data.to_s.to_f
      sc = 0
    elsif odata.to_s.to_f > cons_data.to_s.to_f
      sc = -1
    end
    sc
  end

  def cal_method_1(cons_data, odata, ll, ul)
    sc = 0
    if odata.to_s.to_f >= cons_data.to_s.to_f
      sc = 1
    elsif cons_data.to_s.to_f * ll < odata.to_s.to_f && odata.to_s.to_f < cons_data.to_s.to_f * ul
      sc = 0
    elsif odata.to_s.to_f <= cons_data.to_s.to_f * ll
      sc = -1
    end
    sc
  end

  def cal_method_2(cons_data, odata, ll, ul)
    sc = 0
    if odata.to_s.to_f <= cons_data.to_s.to_f
      sc = 1
    elsif cons_data.to_s.to_f * ll < odata.to_s.to_f && odata.to_s.to_f < cons_data.to_s.to_f * ul
      sc = 0
    elsif cons_data.to_s.to_f * ul <= odata.to_s.to_f
      sc = -1
    end
    sc
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