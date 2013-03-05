class VideoTestScore < ActiveRecord::Base
  attr_accessible :test_time,
                  :source_node_name,
                  :source_ip_address,
                  :source_group,
                  :dest_node_name,
                  :dest_url,
                  :dest_group,
                  :resolution_time,
                  :connection_time,
                  :time_to_first_byte,
                  :time_to_first_frame,
                  :total_buffer_time,
                  :time_to_first_buffer,
                  :avg_butffer_rate,
                  :buffering_count,
                  :playback_duration,
                  :download_time,
                  :throuthput_time,
                  :playback_rate,
                  :resolution_sr,
                  :rebuffering_rate,
                  :connection_sr,
                  :total_sr,
                  :dest_ip_address,
                  :dest_nationality,
                  :dest_province,
                  :dest_locale,
                  :download_size,
                  :contents_size,
                  :return_code,
                  :add_ons,
                  :positive_items,
                  :negative_items,
                  :equal_items,
                  :positive_items_scores,
                  :negative_items_scores,
                  :equal_items_scores,
                  :total_scores
end