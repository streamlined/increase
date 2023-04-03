module Increase
  class Client
    module Accounts
      def get_all_accounts(filters: {status: "open"}) # default to only open accounts
        get("accounts", filters)
      end

      def get_account(account_id:)
        get("accounts/#{account_id}")
      end

      def create_account(entity_id: nil, informational_entity_id: nil, name:, program_id:)
        post("accounts", {
              # needs to be a separate entity object (ID)
               entity_id: entity_id,
               # an entity which does not own the account, but is associated to its activity
               informational_entity_id: informational_entity_id,
               name: name,
               program_id: program_id
             })
      end

      def close_account(account_id:)
        post("accounts/#{account_id}/close")
      end

      def update_account(account_id:, name: nil)
        patch("accounts/#{account_id}", {
                name: name
              })
      end

      def close_account(account_id:)
        post("accounts/#{account_id}/close")
      end

      def create_account_number(account_id:, name:)
        post("/account_numbers", {
          account_id: account_id,
          name: name
        })
      end

      def get_all_account_numbers(account_id: nil, filters: {status: "active"})
        get("/account_numbers", filters)
      end

      def get_account_number(account_number_id:)
        get("/account_numbers/#{account_number_id}")
      end

      def cancel_account_number(account_number_id:)
        patch("/account_numbers/#{account_number_id}", {
          status: 'canceled'
        })
      end

      def disable_account_number(account_number_id:)
        patch("/account_numbers/#{account_number_id}", {
          status: 'disabled'
        })
      end
    end
  end
end
