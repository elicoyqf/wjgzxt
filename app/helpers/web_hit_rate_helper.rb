module WebHitRateHelper
  def avg_whrs(time_begin, time_end)
    url_data = WebHitRateStatis.where('time_begin >= ? and time_begin < ?', time_begin, time_end)
    url_name = Set.new
    in_one   = []
    url_data.each do |line|
      url_name << line.url
    end

    url_name.each do |name|
      tmp = []
      dx  = url_data.where('url = ?', name).average('dx_hit_rate')
      lt  = url_data.where('url = ?', name).average('lt_hit_rate')
      tmp << name << dx << lt
      in_one << tmp
    end
    in_one
  end
end
