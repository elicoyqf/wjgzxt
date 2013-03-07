class RenameThrouthputTimeToVideoTestData < ActiveRecord::Migration
  def up
    rename_column :video_test_data, :throuthput_time, :throughput_time
  end

  def down
    rename_column :video_test_data, :throughput_time, :throuthput_time
  end
end
