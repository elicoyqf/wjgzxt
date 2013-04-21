#encoding : utf-8

class GraphsController < ApplicationController
  layout 'application'

  def index
    response.content_type = Mime::HTML
  end

  def data_json
    total_h          = {}
    chart_h          = { "palette"       => "2",
                         "caption"       => "网站测试日得分统计表",
                         "yaxisname"     => "测试分值",
                         "xaxisname"     => "时间点（以24为一周期）",
                         "xaxismaxvalue" => "1000",
                         "xaxisminvalue" => "0",
                         "yaxismaxvalue" => "8" }
    total_h["chart"] = chart_h

    categories_h = {
        "verticallinecolor"     => "666666",
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
    puts '-'*50
    puts total_h
    @test_j = total_h
    @data_j = '{
        "chart": {
            "palette": "2",
            "caption": "网站测试日得分统计表",
            "yaxisname": "测试分值",
            "xaxisname": "时间点（以24为一周期）",
            "xaxismaxvalue": "1400",
            "xaxisminvalue": "0",
            "yaxismaxvalue": "8"
        },
        "categories": [
            {
                "verticallinecolor": "666666",
                "verticallinethickness": "1",
                "category": [
                    {

                        "x": "23",
                        "showverticalline": "1"
                    },
                    {
                        "label": "47",
                        "x": "47",
                        "showverticalline": "1"
                    },
                    {
                        "label": "71",
                        "x": "71",
                        "showverticalline": "1"
                    },
                    {
                        "label": "95",
                        "x": "95",
                        "showverticalline": "1"
                    },
                    {
                        "label": "119",
                        "x": "119",
                        "showverticalline": "1"
                    },
                    {
                        "label": "143",
                        "x": "143",
                        "showverticalline": "1"
                    },
                    {
                        "label": "167",
                        "x": "167",
                        "showverticalline": "1"
                    },
                    {
                        "label": "191",
                        "x": "191",
                        "showverticalline": "1"
                    },
                    {
                        "label": "215",
                        "x": "215",
                        "showverticalline": "1"
                    },
                    {
                        "label": "239",
                        "x": "239",
                        "showverticalline": "1"
                    },
                    {
                        "label": "263",
                        "x": "263",
                        "showverticalline": "1"
                    },
                    {
                        "label": "287",
                        "x": "287",
                        "showverticalline": "1"
                    },
                    {
                        "label": "311",
                        "x": "311",
                        "showverticalline": "1"
                    },
                    {
                        "label": "335",
                        "x": "335",
                        "showverticalline": "1"
                    },
                    {
                        "label": "359",
                        "x": "359",
                        "showverticalline": "1"
                    },
                    {
                        "label": "383",
                        "x": "383",
                        "showverticalline": "1"
                    }
                ]
            }
        ],
        "dataset": [
            {
                "seriesname": "新浪网",
                "color": "009900",
                "anchorsides": "3",
                "anchorradius": "1",
                "anchorbgcolor": "D5FFD5",
                "anchorbordercolor": "009900",
                "data": [
                    {
                        "y": "-2.4",
                        "x": "0"
                    },
                    {
                        "y": "3.5",
                        "x": "1"
                    },
                    {
                        "y": "2.5",
                        "x": "2"
                    },
                    {
                        "y": "4.1",
                        "x": "3"
                    },
                    {
                        "y": "3.5",
                        "x": "4"
                    },
                    {
                        "y": "4.6",
                        "x": "5"
                    },
                    {
                        "y": "4.8",
                        "x": "6"
                    },
                    {
                        "y": "4.9",
                        "x": "7"
                    },
                    {
                        "y": "4.6",
                        "x": "8"
                    },
                    {
                        "y": "4.2",
                        "x": "9"
                    },
                    {
                        "y": "1",
                        "x": "10"
                    },
                    {
                        "y": "-2",
                        "x": "11"
                    },
                    {
                        "y": "1",
                        "x": "12"
                    },
                    {
                        "y": "2",
                        "x": "13"
                    },
                    {
                        "y": "4",
                        "x": "14"
                    },
                    {
                        "y": "3",
                        "x": "15"
                    },
                    {
                        "y": "1",
                        "x": "16"
                    },
                    {
                        "y": "3",
                        "x": "17"
                    },
                    {
                        "y": "2",
                        "x": "18"
                    },
                    {
                        "y": "-1",
                        "x": "19"
                    },
                    {
                        "y": "-2",
                        "x": "20"
                    },
                    {
                        "y": "-1",
                        "x": "21"
                    },
                    {
                        "y": "2",
                        "x": "22"
                    },
                    {
                        "y": "3",
                        "x": "23"
                    }
                ]
            },
            {
                "seriesname": "搜狐网",
                "color": "0000FF",
                "anchorsides": "4",
                "anchorradius": "1",
                "anchorbgcolor": "C6C6FF",
                "anchorbordercolor": "0000FF",
                "data": [
                    {
                        "y": "1.4",
                        "x": "24"
                    },
                    {
                        "y": "1.5",
                        "x": "25"
                    },
                    {
                        "y": "1.5",
                        "x": "26"
                    },
                    {
                        "y": "1.1",
                        "x": "27"
                    },
                    {
                        "y": "1.5",
                        "x": "28"
                    },
                    {
                        "y": "1.6",
                        "x": "29"
                    },
                    {
                        "y": "1.8",
                        "x": "30"
                    },
                    {
                        "y": "1.9",
                        "x": "31"
                    },
                    {
                        "y": "1.6",
                        "x": "32"
                    },
                    {
                        "y": "1.2",
                        "x": "33"
                    },
                    {
                        "y": "1.9",
                        "x": "34"
                    },
                    {
                        "y": "1.1",
                        "x": "35"
                    },
                    {
                        "y": "1.9",
                        "x": "36"
                    },
                    {
                        "y": "1.7",
                        "x": "37"
                    },
                    {
                        "y": "1.1",
                        "x": "38"
                    },
                    {
                        "y": "1.3",
                        "x": "39"
                    },
                    {
                        "y": "1.7",
                        "x": "40"
                    },
                    {
                        "y": "1.8",
                        "x": "41"
                    },
                    {
                        "y": "1.9",
                        "x": "42"
                    },
                    {
                        "y": "-2",
                        "x": "43"
                    },
                    {
                        "y": "1.0",
                        "x": "44"
                    },
                    {
                        "y": "-2",
                        "x": "45"
                    },
                    {
                        "y": "-1",
                        "x": "46"
                    },
                    {
                        "y": "-5",
                        "x": "47"
                    }
                ]
            },
            {
                "seriesname": "中华网",
                "color": "0000FF",
                "anchorsides": "4",
                "anchorradius": "1",
                "anchorbgcolor": "C6C6FF",
                "anchorbordercolor": "0000FF",
                "data": [
                    {
                        "y": "1.4",
                        "x": "48"
                    },
                    {
                        "y": "1.5",
                        "x": "49"
                    },
                    {
                        "y": "1.5",
                        "x": "50"
                    },
                    {
                        "y": "1.1",
                        "x": "51"
                    },
                    {
                        "y": "1.5",
                        "x": "52"
                    },
                    {
                        "y": "1.6",
                        "x": "53"
                    },
                    {
                        "y": "1.8",
                        "x": "54"
                    },
                    {
                        "y": "1.9",
                        "x": "55"
                    },
                    {
                        "y": "1.6",
                        "x": "56"
                    },
                    {
                        "y": "1.2",
                        "x": "57"
                    },
                    {
                        "y": "1.9",
                        "x": "58"
                    },
                    {
                        "y": "1.1",
                        "x": "59"
                    },
                    {
                        "y": "1.9",
                        "x": "60"
                    },
                    {
                        "y": "1.7",
                        "x": "61"
                    },
                    {
                        "y": "1.1",
                        "x": "62"
                    },
                    {
                        "y": "1.3",
                        "x": "63"
                    },
                    {
                        "y": "1.7",
                        "x": "64"
                    },
                    {
                        "y": "1.8",
                        "x": "65"
                    },
                    {
                        "y": "1.9",
                        "x": "66"
                    },
                    {
                        "y": "-2",
                        "x": "67"
                    },
                    {
                        "y": "1.0",
                        "x": "68"
                    },
                    {
                        "y": "-2",
                        "x": "69"
                    },
                    {
                        "y": "-1",
                        "x": "70"
                    },
                    {
                        "y": "-5",
                        "x": "71"
                    }
                ]
            },
            {
                "seriesname": "太平洋网",
                "color": "0000FF",
                "anchorsides": "4",
                "anchorradius": "1",
                "anchorbgcolor": "C6C6FF",
                "anchorbordercolor": "0000FF",
                "data": [
                    {
                        "y": "1.4",
                        "x": "24"
                    },
                    {
                        "y": "1.5",
                        "x": "25"
                    },
                    {
                        "y": "1.5",
                        "x": "26"
                    },
                    {
                        "y": "1.1",
                        "x": "27"
                    },
                    {
                        "y": "1.5",
                        "x": "28"
                    },
                    {
                        "y": "1.6",
                        "x": "29"
                    },
                    {
                        "y": "1.8",
                        "x": "30"
                    },
                    {
                        "y": "1.9",
                        "x": "31"
                    },
                    {
                        "y": "1.6",
                        "x": "32"
                    },
                    {
                        "y": "1.2",
                        "x": "33"
                    },
                    {
                        "y": "1.9",
                        "x": "34"
                    },
                    {
                        "y": "1.1",
                        "x": "35"
                    },
                    {
                        "y": "1.9",
                        "x": "36"
                    },
                    {
                        "y": "1.7",
                        "x": "37"
                    },
                    {
                        "y": "1.1",
                        "x": "38"
                    },
                    {
                        "y": "1.3",
                        "x": "39"
                    },
                    {
                        "y": "1.7",
                        "x": "40"
                    },
                    {
                        "y": "1.8",
                        "x": "41"
                    },
                    {
                        "y": "1.9",
                        "x": "42"
                    },
                    {
                        "y": "-2",
                        "x": "43"
                    },
                    {
                        "y": "1.0",
                        "x": "44"
                    },
                    {
                        "y": "-2",
                        "x": "45"
                    },
                    {
                        "y": "-1",
                        "x": "46"
                    },
                    {
                        "y": "-5",
                        "x": "47"
                    }
                ]
            },
            {
                "seriesname": "人人网",
                "color": "0000FF",
                "anchorsides": "4",
                "anchorradius": "1",
                "anchorbgcolor": "C6C6FF",
                "anchorbordercolor": "0000FF",
                "data": [
                    {
                        "y": "1.4",
                        "x": "24"
                    },
                    {
                        "y": "1.5",
                        "x": "25"
                    },
                    {
                        "y": "1.5",
                        "x": "26"
                    },
                    {
                        "y": "1.1",
                        "x": "27"
                    },
                    {
                        "y": "1.5",
                        "x": "28"
                    },
                    {
                        "y": "1.6",
                        "x": "29"
                    },
                    {
                        "y": "1.8",
                        "x": "30"
                    },
                    {
                        "y": "1.9",
                        "x": "31"
                    },
                    {
                        "y": "1.6",
                        "x": "32"
                    },
                    {
                        "y": "1.2",
                        "x": "33"
                    },
                    {
                        "y": "1.9",
                        "x": "34"
                    },
                    {
                        "y": "1.1",
                        "x": "35"
                    },
                    {
                        "y": "1.9",
                        "x": "36"
                    },
                    {
                        "y": "1.7",
                        "x": "37"
                    },
                    {
                        "y": "1.1",
                        "x": "38"
                    },
                    {
                        "y": "1.3",
                        "x": "39"
                    },
                    {
                        "y": "1.7",
                        "x": "40"
                    },
                    {
                        "y": "1.8",
                        "x": "41"
                    },
                    {
                        "y": "1.9",
                        "x": "42"
                    },
                    {
                        "y": "-2",
                        "x": "43"
                    },
                    {
                        "y": "1.0",
                        "x": "44"
                    },
                    {
                        "y": "-2",
                        "x": "45"
                    },
                    {
                        "y": "-1",
                        "x": "46"
                    },
                    {
                        "y": "-5",
                        "x": "47"
                    }
                ]
            }
        ]
    } '
    respond_to do |f|
      f.json { render json: @test_j }
    end
  end
end
