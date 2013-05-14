#encoding : utf-8
require 'set'

class DomainController < ApplicationController
  def validate
    @dx = rand_domain '电信'
    @lt = rand_domain '联通'
    @yd = rand_domain '移动'
    @tt = rand_domain '铁通'
    @ot = rand_domain '其它'
  end

  def test
    v_domain = params[:v_domain]
    tdn = TestDestNode.all
    v_data = []
    tdn.each do |line|
      v_data << line.dest_url
    end

    if v_data.include?(v_domain)
      flash[:error] = '此测试域名存在重复，无需再次添加。'
    else
      flash[:success] = '此测试域名不存在重复，可以添加到测试数据里面。'
    end

    redirect_to action: 'validate'
  end


end

