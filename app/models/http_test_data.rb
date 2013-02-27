class HttpTestData < ActiveRecord::Base
  attr_accessible :DestGroup, :DestNodeName, :DestURL, :ResolutionTime, :SourceGroup, :SourceIPAddress, :SourceNodeName, :TestTime,
                  :ConnectionTime, :TimeToFirstByte, :TimeToIndex, :PageDownloadTime, :PageLoadingTime, :TotalTime,
                  :ThroughputTime, :OverallQuality, :ResolutionSR, :ConnectionSR, :IndexPageLoadingSR, :PageLoadingR, :LoadingSR, :DestIPAddress,
                  :DestNationality, :DestProvince, :DestLocale, :DownloadSize, :ContentsSize, :ReturnCode, :AddOns, :ElementNumber
end
