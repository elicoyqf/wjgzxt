#encoding : utf-8
class Notifier < ActionMailer::Base
  default from: "yiqf@sg.cttgd.com"

  def notifier_mail(comment)
    @comment = comment
    @url     = 'www.sina.com.cn'

    mail to: '13826386421@139.com', subject: '中文测试'
  end
end
