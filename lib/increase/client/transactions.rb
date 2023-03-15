module Increase
  class Client
    module Transactions
      def get_all_transactions(
        account_id: nil,
        category_in: nil,
        created_at_after: nil,
        created_at_before: nil,
        created_at_on_or_after: nil,
        created_at_on_or_before: nil,
        cursor: nil,
        limit: nil,
        route_id: nil,
        filters: {}
      )

        get("transactions",{
          account_id: account_id,
          'category.in': %w(category_in),
          'created_at.after': created_at_after,
          'created_at.before': created_at_before,
          'created_at.on_or_after': created_at_on_or_after,
          'created_at.on_or_before': created_at_on_or_before,
          cursor: cursor,
          limit: limit,
          route_id: route_id
        }.compact
        )
      end

      def get_transaction(transaction_id:)
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
