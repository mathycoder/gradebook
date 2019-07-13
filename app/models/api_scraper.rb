class ApiScraper < ApplicationRecord

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

  def self.scrape_math_standards
    array = self.ccss_standards
    mstandards = array.select do |hash|
      hash["subject"] == "Common Core Mathematics"
    end
    mstandards = mstandards.sort_by{|standard| standard["title"]}
    mstandards.map do |item|
      Standard.new(grade: item["title"], grade_id: item["id"] )
    end
    the_standards = []
    mstandards.each do |grade|
      self.grade_standards(grade["id"]).each do |standard|
        the_standards << Standard.find_or_create_by(api_standard_id: standard[1]["id"], standard_notation: standard[1]["statementNotation"]||standard[1]["description"], alt_standard_notation: standard[1]["altStatementNotation"], description: standard[1]["description"], grade: grade["title"], grade_id: grade["id"])
      end
    end
    the_standards
  end

  def self.grade_standards(url)
    array = self.call_the_API("https://api.commonstandardsproject.com/api/v1/standard_sets/#{url}")["standards"]
  end
end
