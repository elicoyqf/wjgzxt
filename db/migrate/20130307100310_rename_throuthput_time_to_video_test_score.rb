class RenameThrouthputTimeToVideoTestScore < ActiveRecord::Migration
  def up
    rename_column :video_test_scores, :throuthput_time, :throughput_time
  end

  def down
    rename_column :video_test_scores, :throuthput_time, :throughput_time
  end
end
