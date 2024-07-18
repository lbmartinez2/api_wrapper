module Rawg
  class Request
    BASE_URL = 'https://api.rawg.io/api'
    TOKEN = ENV['RAWG_API_TOKEN']

    def self.call(http_method, endpoint, params = {})
      url = "#{BASE_URL}#{endpoint}?key=#{TOKEN}"
      url += "/&#{params.to_s}" unless params.empty?

      result = RestClient::Request.execute(
        method: http_method,
        url: url,
        headers: {'Content-Type' => 'application/json'}
      )

      { code: result.code, status: 'Success', data: JSON.parse(result.body) }
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code) }
    end
  end
end
