#encoding : utf-8
module DomainHelper
  def rand_domain(locale)
    tmp_data = nil
    if locale != '其它'
      tmp_data = TestDestNode.where('locale = ?', locale)
    else
      tmp_data = TestDestNode.where('locale not in (?)', ['电信', '联通', '移动', '铁通'])
    end

    out_arr = Set.new
    out_set = Set.new
    (1..5).each do |n|
      tmp = rand(tmp_data.size)
      out_set << tmp
      out_arr << tmp_data[tmp]
      if n == 5 && out_set.size != 5
        (1..(n-out_set.size)).each do |ag|
          tmp = rand(tmp_data.size)
          out_set << tmp
          out_arr << tmp_data[tmp]
        end
      end
    end
    out_arr
  end
end
