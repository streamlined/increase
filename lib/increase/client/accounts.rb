module Increase
  class Client
    module Accounts
      def get_all_accounts(filters: {})
        get("accounts", filters)
      end

      def get_account(account_id:)
        get("accounts/#{account_id}")
      end

      def create_account(entity_id: nil, informational_entity_id: nil, name:)
        post("accounts", {
              # needs to be a separate entity object (ID)
               entity_id: entity_id,
               # an entity which does not own the account, but is associated to its activity
               informational_entity_id: informational_entity_id,
               name: name
             })
      end

      def update_account(account_id:, name: nil)
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
