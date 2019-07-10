class Standard < ApplicationRecord
  #https://commonstandardsproject.com/developers

  def call_the_API
    response = RestClient::Request.execute(
      method: :get,
      url: 'https://api.commonstandardsproject.com/api/v1/jurisdictions',
      headers: {api_key: ENV['CCSS_KEY']}
      )
      hash = JSON.parse(response)["data"]
  end
end
