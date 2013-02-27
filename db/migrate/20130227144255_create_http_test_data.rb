class CreateHttpTestData < ActiveRecord::Migration
  def change
    create_table :http_test_data do |t|
      t.datetime :TestTime
      t.string :SourceNodeName
      t.string :SourceIPAddress
      t.string :SourceGroup
      t.string :DestNodeName
      t.string :DestURL
      t.string :DestGroup
      t.string :ResolutionTime
      t.string :ConnectionTime
      t.string :TimeToFirstByte
      t.string :TimeToIndex
      t.string :PageDownloadTime
      t.string :PageLoadingTime
      t.string :TotalTime
      t.string :ThroughputTime
      t.string :OverallQuality
      t.string :ResolutionSR
      t.string :ConnectionSR
      t.string :IndexPageLoadingSR
      t.string :PageLoadingR
      t.string :LoadingSR
      t.string :DestIPAddress
      t.string :DestNationality
      t.string :DestProvince
      t.string :DestLocale
      t.string :DownloadSize
      t.string :ContentsSize
      t.string :ReturnCode
      t.string :AddOns
      t.string :ElementNumber


      t.timestamps
    end
  end
end
