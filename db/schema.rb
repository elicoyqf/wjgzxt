# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130306172328) do

  create_table "http_test_data", :force => true do |t|
    t.datetime "test_time"
    t.string   "source_node_name"
    t.string   "source_ip_address"
    t.string   "source_group"
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.string   "dest_group"
    t.string   "resolution_time"
    t.string   "connection_time"
    t.string   "time_to_first_byte"
    t.string   "time_to_index"
    t.string   "page_download_time"
    t.string   "page_loading_time"
    t.string   "total_time"
    t.string   "throughput_time"
    t.string   "overall_quality"
    t.string   "resolution_sr"
    t.string   "connection_sr"
    t.string   "index_page_loading_sr"
    t.string   "page_loading_r"
    t.string   "loading_sr"
    t.string   "dest_ip_address"
    t.string   "dest_nationality"
    t.string   "dest_province"
    t.string   "dest_locale"
    t.string   "download_size"
    t.string   "contents_size"
    t.string   "return_code"
    t.string   "add_ons"
    t.string   "element_number"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "http_test_scores", :force => true do |t|
    t.datetime "test_time"
    t.string   "source_node_name"
    t.string   "source_ip_address"
    t.string   "source_group"
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.string   "dest_group"
    t.integer  "resolution_time"
    t.integer  "connection_time"
    t.integer  "time_to_first_byte"
    t.integer  "time_to_index"
    t.integer  "page_download_time"
    t.integer  "page_loading_time"
    t.integer  "total_time"
    t.integer  "throughput_time"
    t.integer  "overall_quality"
    t.integer  "resolution_sr"
    t.integer  "connection_sr"
    t.integer  "index_page_loading_sr"
    t.integer  "page_loading_r"
    t.integer  "loading_sr"
    t.string   "dest_ip_address"
    t.string   "dest_nationality"
    t.string   "dest_province"
    t.string   "dest_locale"
    t.integer  "download_size"
    t.integer  "contents_size"
    t.string   "return_code"
    t.integer  "add_ons"
    t.integer  "element_number"
    t.integer  "positive_items"
    t.integer  "negative_items"
    t.integer  "equal_items"
    t.integer  "positive_items_scores"
    t.integer  "negative_items_scores"
    t.integer  "equal_items_scores"
    t.integer  "total_scores"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "locale_data", :force => true do |t|
    t.string   "locale_name"
    t.integer  "locale_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "param_score_configs", :force => true do |t|
    t.string   "param_name"
    t.string   "param_type"
    t.integer  "normal"
    t.integer  "good"
    t.integer  "better"
    t.integer  "bad"
    t.integer  "worse"
    t.integer  "weight"
    t.integer  "item_type"
    t.float    "lower_limit"
    t.float    "upper_limit"
    t.string   "alias"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ping_test_data", :force => true do |t|
    t.datetime "test_time"
    t.string   "source_node_name"
    t.string   "source_ip_address"
    t.string   "source_group"
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.string   "dest_group"
    t.string   "resolution_time"
    t.string   "lost_packets"
    t.string   "send_packets"
    t.string   "lost_packets_no"
    t.string   "delay"
    t.string   "max_delay"
    t.string   "min_delay"
    t.string   "std_delay"
    t.string   "jitter"
    t.string   "max_jitter"
    t.string   "min_jitter"
    t.string   "std_jitter"
    t.string   "dest_ip_address"
    t.string   "dest_nationality"
    t.string   "dest_province"
    t.string   "dest_locale"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ping_test_scores", :force => true do |t|
    t.datetime "test_time"
    t.string   "source_node_name"
    t.string   "source_ip_address"
    t.string   "source_group"
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.string   "dest_group"
    t.string   "resolution_time"
    t.integer  "lost_packets"
    t.integer  "send_packets"
    t.integer  "lost_packets_no"
    t.integer  "delay"
    t.integer  "max_delay"
    t.integer  "min_delay"
    t.integer  "std_delay"
    t.integer  "jitter"
    t.integer  "max_jitter"
    t.integer  "min_jitter"
    t.integer  "std_jitter"
    t.string   "dest_ip_address"
    t.string   "dest_nationality"
    t.string   "dest_province"
    t.string   "dest_locale"
    t.integer  "positive_items"
    t.integer  "negative_items"
    t.integer  "equal_items"
    t.integer  "positive_items_scores"
    t.integer  "negative_items_scores"
    t.integer  "equal_items_scores"
    t.integer  "total_scores"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "test_dest_nodes", :force => true do |t|
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "video_test_data", :force => true do |t|
    t.datetime "test_time"
    t.string   "source_node_name"
    t.string   "source_ip_address"
    t.string   "source_group"
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.string   "dest_group"
    t.string   "resolution_time"
    t.string   "connection_time"
    t.string   "time_to_first_byte"
    t.string   "time_to_first_frame"
    t.string   "total_buffer_time"
    t.string   "time_to_first_buffer"
    t.string   "avg_butffer_rate"
    t.string   "buffering_count"
    t.string   "playback_duration"
    t.string   "download_time"
    t.string   "throuthput_time"
    t.string   "playback_rate"
    t.string   "resolution_sr"
    t.string   "rebuffering_rate"
    t.string   "connection_sr"
    t.string   "total_sr"
    t.string   "dest_ip_address"
    t.string   "dest_nationality"
    t.string   "dest_province"
    t.string   "dest_locale"
    t.string   "download_size"
    t.string   "contents_size"
    t.string   "return_code"
    t.string   "add_ons"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "video_test_scores", :force => true do |t|
    t.datetime "test_time"
    t.string   "source_node_name"
    t.string   "source_ip_address"
    t.string   "source_group"
    t.string   "dest_node_name"
    t.string   "dest_url"
    t.string   "dest_group"
    t.integer  "resolution_time"
    t.integer  "connection_time"
    t.integer  "time_to_first_byte"
    t.integer  "time_to_first_frame"
    t.integer  "total_buffer_time"
    t.integer  "time_to_first_buffer"
    t.integer  "avg_butffer_rate"
    t.integer  "buffering_count"
    t.integer  "playback_duration"
    t.integer  "download_time"
    t.integer  "throuthput_time"
    t.integer  "playback_rate"
    t.integer  "resolution_sr"
    t.integer  "rebuffering_rate"
    t.integer  "connection_sr"
    t.integer  "total_sr"
    t.string   "dest_ip_address"
    t.string   "dest_nationality"
    t.string   "dest_province"
    t.string   "dest_locale"
    t.integer  "download_size"
    t.integer  "contents_size"
    t.string   "return_code"
    t.integer  "add_ons"
    t.integer  "positive_items"
    t.integer  "negative_items"
    t.integer  "equal_items"
    t.integer  "positive_items_scores"
    t.integer  "negative_items_scores"
    t.integer  "equal_items_scores"
    t.integer  "total_scores"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

end
