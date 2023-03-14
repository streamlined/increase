module Increase
  class Client
    module AccountTransfers
      def create_account_transfer(account_id: , amount: , description: , destination_account_id: , require_approval: false)
        post("account_transfers",{
          account_id: account_id,
          amount: amount,
          description: description,
          destination_account_id: destination_account_id,
          require_approval: require_approval
        })
      end
    end
  end
end
