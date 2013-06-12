#encoding : utf-8
class Notifier < ActionMailer::Base
  default from: 'elico_yqf@126.com'

  def notifier_mail(email, nega, all_match, tb, te, en)
    @negative_num  = nega
    @all_match_num = all_match
    @time_begin    = tb
    @time_end      = te
    @ename         = en
    mail to: email, subject: '出口质量劣化信息，请登录系统查看详细信息'
  end

  def notifier_degradation_mail(email, nega_n, ahan_n, tb, te, en)
    @negative_n = nega_n
    @ahan_n     = ahan_n
    @time_begin = tb
    @time_end   = te
    @ename      = en
    mail to: email, subject: '出口质量劣化信息，请登录系统查看详细信息'
  end
end
