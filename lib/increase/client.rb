module Increase
  class Client < BaseClient
    autoload :Accounts, "increase/client/accounts"
    autoload :Transactions, "increase/client/transactions"
    autoload :AchTransfers, "increase/client/ach_transfers"
    autoload :AccountTransfers, "increase/client/account_transfers"
    include Accounts
    include Transactions
    include AchTransfers
    include AccountTransfers

    def initialize(api_base_url: nil, api_key: nil, headers: {})
      api_base_url ||= Increase.api_base_url
      api_key      ||= Increase.api_key
      super(api_base_url: api_base_url, headers: headers.merge(default_headers(api_key)))
    end

    def inspect
      %Q(#<Increase::Client:0x#{"%016X" % object_id}>)
    end

    private

    def default_headers(api_key)
      {
        "User-Agent" => "Increase v#{Increase::VERSION}",
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{api_key}"
      }
    end
  end
end