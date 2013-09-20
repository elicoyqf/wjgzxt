#encoding : utf-8

require 'csv'
require 'will_paginate/array'
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

  def gen_report_data(time_begin, time_end, ef)
    etn = user_perm_ename_list(ef)

    psc        = ParamScoreConfig.where('param_type = ? and weight > ? ', 'htd', 0)
    title_name = []
    key1       = %w( source_node_name dest_node_name)
    key2       =%w(positive_items_scores negative_items_scores total_scores)

    key3 = []
    psc.each do |config|
      title_name << config.alias
      key3 << config.param_name
    end
    key = key1 + key3 + key2

    odata = []
    etn.each do |ename|
      tmp_arr = []
      tmp_arr << ExportName.where('alias = ? ', ename).first.name
      #tmp_data = HttpTestScore.select(key).where('test_time >= ? and test_time < ?', time_begin, time_end).order('total_scores DESC').paginate page: params[:page], per_page: 10
      tmp_data = HttpTestScore.select(key).where('test_time >= ? and test_time < ? and source_node_name = ?', time_begin, time_end, ename)
      unless tmp_data.blank?
        tmp_data.each do |line|
          tmp_arr << line.dest_node_name
          tmp_arr << line.time_to_index << line.total_time << line.throughput_time << line.connection_sr << line.index_page_loading_sr
          tmp_arr << line.positive_items_scores << line.negative_items_scores << line.total_scores
        end
      end
      odata << tmp_arr
    end
    odata.sort_by! { |x| x[9] }
    [title_name, odata.paginate(page: params[:page], per_page: 10)]
  end

  def gen_report_csv(time_begin, time_end, ef)
    etn = user_perm_ename_list(ef)

    psc        = ParamScoreConfig.where('param_type = ? and weight > ? ', 'htd', 0)
    title_name = []
    key1       = %w(test_time source_node_name source_ip_address source_group dest_node_name dest_url dest_group)
    key2       =%w(dest_ip_address dest_nationality dest_province dest_locale positive_items negative_items equal_items positive_items_scores
negative_items_scores equal_items_scores total_scores)

    key3 = []
    psc.each do |config|
      title_name << config.alias
      key3 << config.param_name
    end
    key = key1 + key3 + key2

    odata = []
    etn.each do |ename|
      tmp_data = HttpTestScore.select(key).where('test_time >= ? and test_time < ? and source_node_name = ?', time_begin, time_end, ename)
      odata += tmp_data
    end
    #odata.sort_by! { |x| x[9] }

    #odata = HttpTestScore.select(key).where('test_time >= ? and test_time < ?', time_begin, time_end).order('source_node_name')
    return key, odata, title_name
  end

  def user_perm_ename_list(ef)
    etn = Set.new

    if ef.blank?
      #查询当月的月表数据
      en = ExportName.where('user_id != 0')
      en.each do |line|
        unless line.alias.blank?
          etn << line.alias
        end
      end
    else
      ef.each do |t|
        unless t.alias.blank?
          etn << t.alias
        end
      end
    end
    #将对比标杆出口去掉
    etn.delete(BACKBONE)
    etn
  end

  def data_to_csv(title, key, data, option={})
    puts '-'*30+key.to_s
    CSV.generate(option) do |csv|
      #csv << %w(结果时间 源节点名称 源测试地址  源信息:分组名 目的节点名称 目的测试地址 目的信息:分组名 解析时间 连接时间 首字节时间
      #        首屏打开时间 下载时间 页面加载时间 总时间 吞吐率 综合质量 解析成功率 连接成功率  首页加载成功率 加载比例
      #        成功率 结果IP地址 结果国家名称 结果省名称 结果归属地 下载大小 内容大小 返回码 附加项 元素数量
      #        正分项数量 负分项数量 相等项数量 正项总分 负项总分 相等项总分 所有项总分)
      csv << %w(结果时间 源节点名称 源测试地址  源信息:分组名 目的节点名称 目的测试地址 目的信息:分组名) + title + %w(结果IP地址 结果国家名称 结果省名称 结果归属地 正分项数量 负分项数量 相等项数量 正项总分 负项总分 相等项总分 所有项总分)
      data.each do |tdata|
        tmp1 = [tdata.test_time, tdata.source_node_name, tdata.source_ip_address, tdata.source_group, tdata.dest_node_name, tdata.dest_url,
                tdata.dest_group]
        tmp2 = [tdata.dest_ip_address, tdata.dest_nationality, tdata.dest_province, tdata.dest_locale, tdata.positive_items, tdata.negative_items,
                tdata.equal_items, tdata.positive_items_scores, tdata.negative_items_scores, tdata.equal_items_scores, tdata.total_scores]
        tmp3 = []
        key.each do |k|
          case k
            when 'resolution_time'
              tmp3 << tdata.resolution_time
            when 'connection_time'
              tmp3 << tdata.connection_time
            when 'time_to_first_byte'
              tmp3 << tdata.time_to_first_byte
            when 'time_to_index'
              tmp3 << tdata.time_to_index
            when 'page_download_time'
              tmp3 << tdata.page_download_time
            when 'page_loading_time'
              tmp3 << tdata.page_loading_time
            when 'total_time'
              tmp3 << tdata.total_time
            when 'throughput_time'
              tmp3 << tdata.throughput_time
            when 'overall_quality'
              tmp3 << tdata.overall_quality
            when 'resolution_sr'
              tmp3 << tdata.resolution_sr
            when 'connection_sr'
              tmp3 << tdata.connection_sr
            when 'index_page_loading_sr'
              tmp3 << tdata.index_page_loading_sr
            when 'page_loading_r'
              tmp3 << tdata.page_loading_r
            when 'loading_sr'
              tmp3 << tdata.loading_sr
            else
          end
        end
        tmp = tmp1 + tmp3 + tmp2

        csv << tmp
        #csv << [tdata.test_time, tdata.source_node_name, tdata.source_ip_address, tdata.source_group, tdata.dest_node_name, tdata.dest_url,
        #        tdata.dest_group, tdata.resolution_time, tdata.connection_time, tdata.time_to_first_byte, tdata.time_to_index,
        #        tdata.page_download_time, tdata.page_loading_time, tdata.total_time, tdata.throughput_time, tdata.overall_quality,
        #        tdata.resolution_sr, tdata.connection_sr, tdata.index_page_loading_sr, tdata.page_loading_r, tdata.loading_sr,
        #        tdata.dest_ip_address, tdata.dest_nationality, tdata.dest_province, tdata.dest_locale, tdata.download_size, tdata.contents_size,
        #        tdata.return_code, tdata.add_ons, tdata.element_number, tdata.positive_items, tdata.negative_items, tdata.equal_items,
        #        tdata.positive_items_scores, tdata.negative_items_scores, tdata.equal_items_scores, tdata.total_scores]
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

  def cal_export_ranking(time_begin, time_end, ef = [])
    etn = Set.new

    if ef.blank?
      #查询当月的月表数据
      #en = ExportName.all
      en     = ExportName.where('status = 0')
      en.each do |line|
        unless line.alias.blank?
          etn << line.alias
        end
      end
    else
      ef.each do |t|
        unless t.alias.blank?
          etn << t.alias
        end
      end
    end
    #将对比标杆出口去掉
    etn.delete(BACKBONE)
    hts = HttpTestStatis.where('start_time >= ? and start_time < ?', time_begin, time_end)

    dx = TestDestNode.where('locale = ?', '电信').count
    lt = TestDestNode.where('locale = ?', '联通').count
    oe = TestDestNode.all.count - dx - lt

    total_pos = 0
    total_neg = 0
    total_eql = 0
    match_web = Set.new
    negat_web = Set.new
    dx_array  = []
    lt_array  = []
    etn.each do |ename|
      negative_total = 0
      all_total      = 0
      negative_web   = 0
      #用于封装所有数据的数组[出口名称，负值，总分，负值网站次数，有效总匹配网站数]
      t_array        = []
      en_tmp         = ExportName.where('alias = ?', ename).first
      unless en_tmp.name.blank?
        t_array << en_tmp.name
        match_web.clear
        negat_web.clear
        tmp = HttpTestScore.select('dest_url, total_scores').where('test_time >= ? and test_time < ? and source_node_name = ?',
                                                                   time_begin, time_end, ename)
        tmp.each do |t|
          match_web << t.dest_url
          if t.total_scores < 0
            negat_web << t.dest_url
          end
        end
        negative_total = hts.where('export_name = ? ', ename).sum(:negative_statis)
        all_total      = hts.where('export_name = ? ', ename).sum(:total_statis)
        negative_web   = negat_web.size
        if all_total > 0
          total_pos += 1
        elsif all_total < 0
          total_neg += 1
        else
          total_eql += 1
        end
        t_array << negative_total
        t_array << all_total
        t_array << negative_web
        t_array << match_web.size
        mws = match_web.size
        if match_web.size != 0
          t_array << (((mws.to_f - negative_web.to_f) / mws.to_f) * 100)
        else
          t_array << 0
        end

        if contrast_locale t_array[0].to_s, '电信'
          dx_array << t_array
        elsif contrast_locale t_array[0].to_s, '联通'
          lt_array << t_array
        end
      end

    end
    dx_array.sort_by! { |x| x[1] }
    lt_array.sort_by! { |x| x[1] }
    [dx, lt, oe, total_pos, total_neg, total_eql, dx_array, lt_array]
  end

  def contrast_locale(ename, locale)
    if ename =~ /#{locale}/
      true
    else
      false
    end
  end

  def cal_data(en)
    #[
    # {name: '新浪网', color: 'rgba(223, 83, 83, .5)',data:[[0, 2],[0, 2],[0, 2]]},
    # {name: '新浪网', color: 'rgba(223, 83, 83, .5)',data:[[0, 2],[0, 2],[0, 2]]}
    # ]
    out_d   = []
    c_year  = Time.now.year
    c_month = Time.now.month
    rt      = 0
    c_day   = Time.now.day - 1
    e_day   = Time.now.day
    y_date  = Time.now.at_beginning_of_day - 1.day
    c_date  = Time.now.at_beginning_of_day
    e_no    = ExportName.where('name = ?', en).first.alias
    hts     = HttpTestScore.where('test_time >= ? and test_time < ? and source_node_name = ?', y_date, c_date, e_no)
    ename   = Set.new
    hts.each do |ts|
      ename << ts.dest_url
    end
    ename.each do |line|
      tmp_h          = {}
      tmp_h['name']  = line.to_s
      tmp_h['color'] = 'rgba('+rand(255).to_s + ',' + rand(255).to_s + ',' + rand(255).to_s + ', .5)'
      tmp_arr        = []
      (0..23).each do |pi|
        #取真实的测试数据值
        th = []
        if pi == 23
          t_date = c_year.to_s + '-' + c_month.to_s + '-' + c_day.to_s + ' ' + pi.to_s
          e_date = Time.parse(t_date).at_beginning_of_day + 1.day
          c_hts  = hts.where('test_time >= ? and test_time < ? and dest_url = ?', Time.parse(t_date), e_date, line)
          if c_hts.size == 0
            #此处修改了，如果没有分值则为空，不能为0，0是有效测试数据。
            #th << rt << 0
            th << rt
            tmp_arr << th
          elsif c_hts.size == 1
            th << rt << c_hts.first.total_scores
            tmp_arr << th
          else
            c_hts.each do |ch|
              th.clear
              th << rt << ch.total_scores
              tmp_arr << th
            end
          end
        else
          t_date = c_year.to_s + '-' + c_month.to_s + '-' + c_day.to_s + ' ' + pi.to_s
          e_date = c_year.to_s + '-' + c_month.to_s + '-' + c_day.to_s + ' ' + (pi+1).to_s
          c_hts  = hts.where('test_time >= ? and test_time < ? and dest_url = ?', Time.parse(t_date), Time.parse(e_date), line)
          if c_hts.size == 0
            #此处修改了，如果没有分值则为空，不能为0，0是有效测试数据。
            #th << rt << 0
            th << rt
            tmp_arr << th
          elsif c_hts.size == 1
            th << rt << c_hts.first.total_scores
            tmp_arr << th
          else
            c_hts.each do |ch|
              th.clear
              th << rt << ch.total_scores
              tmp_arr << th
            end
          end
        end
        rt += 1
      end
      tmp_h['data'] = tmp_arr
      out_d << tmp_h
    end
    out_d.to_s.gsub!(/=>/, ':')
  end

=begin
  def gen_json
    total_h          = {}
    chart_h          = { "palette"         => "2",
                         "caption"         => "网站测试日得分统计表",
                         "yaxisname"       => "测试分值",
                         "xaxisname"       => "时间点（以24为一周期）",
                         "xaxismaxvalue"   => "1000",
                         "xaxisminvalue"   => "0",
                         "animation"       => "1",
                         "yaxisminvalue"   => "-6",
                         "yaxismaxvalue"   => "6",
                         "yAxisValuesStep" => "1",
                         "xAxisValuesStep" => "1",
                         "showBorder"      => "0"
    }
    total_h["chart"] = chart_h

    categories_h = {
        "verticallinecolor"     => "0000FF",
        "verticallinethickness" => "1",
    }

    #此处需要进行循环,生成以24间隔的竖隔线
    category_a   = []
    #category_a[0]            = category_h
    #按一天一个出口1400条有效数据来算
    vline        = []
    (0..140).each do |point|
      tmp_h                     = {}
      tmp_v                     = {}
      tmp_h["x"]                = (23 + 24*point).to_s
      tmp_h["showverticalline"] = "1"
      if point > 0
        tmp_v["startvalue"] = (point*24 - 1).to_s
      else
        tmp_v["startvalue"] = (point*24).to_s
      end
      tmp_v["endvalue"] = (23 + 24*point).to_s
      tmp_v["alpha"]    = "15"
      color             = ''
      case point % 6
        when 0
          color = "0000FF"
        when 1
          color = "FFFF00"
        when 2
          color = "FF0000"
        when 3
          color = "00FFFF"
        when 4
          color = "00FF00"
        when 5
          color = "FF00FF"
        else
          color = "FFFFFF"
      end
      tmp_v["color"] = color
      vline << tmp_v
      category_a << tmp_h
    end

    categories_h["category"] = category_a
    total_h["categories"]    = [categories_h]

    en      = params[:en]
    c_year  = Time.now.year
    c_month = Time.now.month
    #c_day = Time.now.day - 1
    #此处还需要对月末的日期做分析
    c_day   = Time.now.day - 1
    e_day   = Time.now.day

    c_date = c_year.to_s + '-' + c_month.to_s + '-' + c_day.to_s + ' ' + c_day.to_s
    e_date = c_year.to_s + '-' + c_month.to_s + '-' + e_day.to_s + ' ' + '0'
    hts    = HttpTestScore.where('test_time >= ? and test_time < ? and source_node_name = ?', Time.now.at_beginning_of_day - 1.day, Time.now.at_beginning_of_day, en)
    ename  = Set.new
    hts.each do |ts|
      ename << ts.dest_url
    end
    dataset_test = []
    rt           = 0
    ename.each do |line|
      #此处需要进行循环,生成一个网站的所有数据
      dataset_h = {
          "seriesname"        => line,
          "color"             => "0000FF",
          "anchorsides"       => (rand(6)+1).to_s,
          "anchorradius"      => "2",
          "anchorbgcolor"     => "C6C6FF",
          "anchorbordercolor" => "009900"
      }
      data_h    = []
      #此处需要进行循环
      #提取指定出口其中有效匹配的网站进行查询，并按时间点将数据存放起来
      #rt记录当前记录指针位置

      #要按网站进行循环
      (0..23).each do |pi|
        tmp_h = {}
        #取真实的测试数据值
        if pi == 23

        else
          t_date = c_year.to_s + '-' + c_month.to_s + '-' + c_day.to_s + ' ' + pi.to_s
          e_date = c_year.to_s + '-' + c_month.to_s + '-' + c_day.to_s + ' ' + (pi+1).to_s
          c_hts  = hts.where('test_time >= ? and test_time < ? and dest_url = ?', Time.parse(t_date), Time.parse(e_date), line)
          if c_hts.size == 0
            tmp_h.clear
            tmp_h["x"] = rt
            tmp_h["y"] = 0
            data_h << tmp_h
          elsif c_hts.size == 1
            tmp_h.clear
            tmp_h["x"] = rt
            tmp_h["y"] = c_hts.first.total_scores
            data_h << tmp_h
          else
            tmp_h.clear
            c_hts.each do |ch|
              tmp_h["x"] = rt
              tmp_h["y"] = ch.total_scores
              data_h << tmp_h
            end
          end
        end
        rt += 1
      end

      dataset_h["data"] = data_h

      dataset_test << dataset_h
    end
    total_h["dataset"] = [dataset_test]


    vtrendlines ={
        "line" => vline
    }

    total_h["vtrendlines"] = vtrendlines
    total_h
  end

=end
end
