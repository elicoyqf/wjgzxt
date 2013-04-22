#encoding : utf-8

class GraphsController < ApplicationController
  layout 'application'

  def index
    response.content_type = Mime::HTML
  end

  def data_json
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
                         "showBorder"       => "0"
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
    (0..1399).each do |point|
      tmp_h                     = {}
      tmp_h["x"]                = (23 + 24*point).to_s
      tmp_h["showverticalline"] = "1"
      category_a << tmp_h
    end

    categories_h["category"] = category_a
    total_h["categories"]    = [categories_h]

    dataset_test = []
    rt           = 0

    (0..6).each do |line|
      #此处需要进行循环,生成一个网站的所有数据
      dataset_h = {
          "seriesname"        => "新浪网",
          "color"             => "0000FF",
          "anchorsides"       => (rand(10)+1).to_s,
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
        tmp_h      = {}
        #取真实的测试数据值
        score      = (-5..5).to_a
        tmp_h["y"] = score[rand(score.size)]
        tmp_h["x"] = rt
        data_h << tmp_h
        rt += 1
      end

      dataset_h["data"] = data_h

      dataset_test << dataset_h
    end
    total_h["dataset"] = [dataset_test]


    vtrendlines = {}
    vtrendlines ={
        "line" => [
            {
                "startvalue" => "0",
                "endvalue"   => "23",
                "alpha"      => "5",
                "color"      => "00FF00"
            },
            {
                "startvalue" => "23",
                "endvalue"   => "47",
                "alpha"      => "15",
                "color"      => "FFFF00"
            },
            {
                "startvalue" => "47",
                "endvalue"   => "71",
                "alpha"      => "15",
                "color"      => "FF0000"
            }
        ]
    }

    total_h["vtrendlines"] = vtrendlines
    #puts '-'*50
    #puts total_h
    @test_j = total_h

    respond_to do |f|
      f.json { render json: @test_j }
    end
  end
end
