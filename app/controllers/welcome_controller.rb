class WelcomeController < ApplicationController
  def index
    #将停用的出口数据在月报表中屏蔽掉。
    ef          = ExportName.where('user_id = ? and status = 0', current_user.id)

    #[dx,lt,oe,total_pos,total_neg,total_eql,dx_array,lt_array]
    @time_begin = Time.now.at_beginning_of_day
    @time_end   = Time.now

    @dx, @lt, @oe, @total_pos, @total_neg, @total_eql, @dx_array, @lt_array = cal_export_ranking @time_begin, @time_end, ef
    render layout: 'application'
  end
end
