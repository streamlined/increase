require "increase/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"
require "date"

require_relative "increase/version"

class Increase
  autoload :BaseClient, "increase/base_client"
  autoload :Client, "increase/client"
  autoload :Types, "increase/types"
  autoload :Error, "increase/error"

  @api_base_url = "https://sandbox.increase.com"

  class << self
    attr_accessor :api_base_url, :api_key, :debug_logger

    def client
      @client ||= Client.new(
        api_base_url: Increase.api_base_url,
        api_key: Increase.api_key
      )
    end
  end
end
