module Increase
  class Client
    module Accounts
      def get_all_accounts(filters: {})
        get("accounts", filters)
      end

      def get_account(account_id:)
        get("accounts/#{account_id}")
      end

      def create_account(entity_id:, informational_entity_id:, name:)
        post("accounts", {
               entity_id: entity_id,
               informational_entity_id: informational_entity_id,
               name: name
             })
      end

      def update_account(account_id:, name:)
        patch("accounts/#{account_id}", {
                name: name
              })
      end

      def close_account(account_id:)
        post("accounts/#{account_id}/close")
      end
    end
  end
end
