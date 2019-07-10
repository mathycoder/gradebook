class Standard < ApplicationRecord
  #https://commonstandardsproject.com/developers

  def self.call_the_API(url)
    response = RestClient::Request.execute(
      method: :get,
      url: url,
      headers: {api_key: ENV['CCSS_KEY']}
      )
      hash = JSON.parse(response)["data"]
  end

  def self.ccss_standards
    self.call_the_API("https://api.commonstandardsproject.com/api/v1/jurisdictions/67810E9EF6944F9383DCC602A3484C23")["standardSets"]
  end

  def self.math_standards
    array = self.ccss_standards
    mstandards = array.select do |hash|
      hash["subject"] == "Common Core Mathematics"
    end
    mstandards = mstandards.sort_by{|standard| standard["title"]}
    mstandards.map do |item|
      Standard.new(grade: item["title"], grade_id: item["id"] )
    end
  end

  def self.by_grade(url)
    array = self.call_the_API("https://api.commonstandardsproject.com/api/v1/standard_sets/#{url}")["standards"]
    standards = array.map do |standard|
      Standard.new(api_standard_id: standard[1]["id"], standard_notation: standard[1]["statementNotation"], alt_standard_notation: standard[1]["altStatementNotation"], description: standard[1]["description"])
    end
  end

end
