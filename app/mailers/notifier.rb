#encoding : utf-8
class Notifier < ActionMailer::Base
  default from: "yiqf@sg.cttgd.com"

  def notifier_mail(email, nega, all_match, tb, te)
    @negative_num  = nega
    @all_match_num = all_match
    @time_begin    = tb
    @time_end      = te
    mail to: email, subject: '出口质量劣化信息，请登录系统查看详细信息'
  end

  def notifier_degradation_mail(email, nega_r, ahan_r, tb, te)
    @negative_r  = nega_r
    @ahan_r = ahan_r
    @time_begin    = tb
    @time_end      = te
    mail to: email, subject: '出口质量劣化信息，请登录系统查看详细信息'
  end
end
