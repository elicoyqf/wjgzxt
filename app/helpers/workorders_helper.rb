module WorkordersHelper
  #type参数用来区分日、周、月报表类型
  def statis_d_data(e_name, date, type)
    out      = []
    p_b_date = date
    case type
      when 1
        p_e_date = p_b_date + 1.day
      when 2
        p_e_date = p_b_date + 1.week
      when 3
        p_e_date = p_b_date + 1.month
      else
        p_e_date = Time.now
    end

    e_name.each do |en|
      tmp_arr   = []
      p_records = HttpTestStatis.where('start_time >= ?  and end_time < ? and export_name = ?', p_b_date, p_e_date, en.name)
      nega_val  = p_records.sum(:negative_statis)
      tota_val  = p_records.sum(:total_statis)
      tmp_arr << en.name << nega_val << tota_val << p_b_date << p_e_date
      puts tmp_arr
      out << tmp_arr
    end

    out
  end

  def statis_d_data1(e_name, p_max_day, p_month, p_year)
    out      = []
    p_str    = p_year.to_s + '-' + p_month.to_s + '-' + p_max_day.to_s
    p_b_date = Time.parse(p_str)
    p_e_date = p_b_date + 1.day
    e_name.each do |en|
      tmp_arr   = []
      p_records = HttpTestStatis.where('start_time >= ?  and end_time < ? and export_name = ?', p_b_date, p_e_date, en.name)
      nega_val  = p_records.sum(:negative_statis)
      tota_val  = p_records.sum(:total_statis)
      tmp_arr << en.name << nega_val << tota_val << p_b_date
      puts tmp_arr
      out << tmp_arr
    end

    out
  end
end
