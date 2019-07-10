class Standard < ApplicationRecord
  #https://commonstandardsproject.com/developers

  def call_the_API(url)
    response = RestClient::Request.execute(
      method: :get,
      url: url,
      headers: {api_key: ENV['CCSS_KEY']}
      )
      hash = JSON.parse(response)["data"]
  end

  def ccss_standards
    self.call_the_API("https://api.commonstandardsproject.com/api/v1/jurisdictions/67810E9EF6944F9383DCC602A3484C23")["standardSets"]
  end

  def math_standards
    array = self.ccss_standards
    mstandards = array.select do |hash|
      hash["subject"] == "Common Core Mathematics"
    end
    mstandards.sort_by{|standard| standard["title"]}
  end


end
