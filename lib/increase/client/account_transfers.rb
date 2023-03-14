module Increase
  class Client
    module AccountTransfers
      def create_account_transfer(
        account_id: ,
        amount: , 
        description: , 
        destination_account_id: , 
        require_approval: false
      )
        post("account_transfers",{
          account_id: account_id,
          amount: amount,
          description: description,
          destination_account_id: destination_account_id,
          require_approval: require_approval
        })
      end

      def get_account_transfer(account_transfer_id:)
        get("account_transfers/#{account_transfer_id}")
      end

      def list_account_transfers(
        account_id: nil,
        created_at_after: nil,
        created_at_before: nil,
        created_at_on_or_after: nil,
        created_at_on_or_before: nil,
        cursor: nil,
        limit: nil,
        filters: {})
        get("account_transfers",
          account_id: account_id,
          'created_at.after': created_at_after,
          'created_at.before': created_at_before,
          'created_at.on_or_after': created_at_on_or_after,
          'created_at.on_or_before': created_at_on_or_before,
          cursor: cursor,
          limit: limit,
          filters: filters
        )
      end
    end
  end
end
