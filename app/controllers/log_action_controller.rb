require 'will_paginate'
require 'will_paginate/array'
class LogActionController < ApplicationController
  def index
    @enl = EmailNotifierLog.order('created_at DESC').limit(10)
    #@enl = EmailNotifierLog.paginate page: params[:page], per_page: 5
    #@edl = EmailDegradationLog.paginate page: params[:page], per_page: 5
    @edl = EmailDegradationLog.order('created_at DESC').limit(10)
  end

  def neg_r
    @enl = EmailNotifierLog.order('created_at DESC').paginate page: params[:page], per_page: 10
  end

  def neg_ru
    @edl = EmailDegradationLog.order('created_at DESC').paginate page: params[:page], per_page: 10
  end
end
