module Increase
  class Client
    module Transactions
      def get_all_transactions(filters: {})
        get("transactions", filters)
      end

      def get_transactions(transaction_id:)
        get("transactions/#{transaction_id}")
      end

      # Pending
      def get_all_pending_transactions(filters: {})
        get("pending_transactions", filters)
      end

      def get_pending_transactions(pending_transaction_id:)
        get("pending_transactions/#{pending_transaction_id}")
      end

      # Declined
      def declined_transactions(filters: {})
        get("declined_transactions", filters)
      end

      def declined_transactions(declined_transaction_id:)
        get("declined_transactions/#{declined_transaction_id}")
      end

      # we can add limits if we need
    end
  end
end
