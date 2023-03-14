module Increase
  class Client
    module AchTransfers
      def create_ach_transfer(
        direction: ,
        account_id:,
        account_number: nil,
        routing_number: nil,
        addendum: nil,
        amount:,
        company_descriptive_date: nil,
        company_discretionary_data: nil,
        company_entry_description: nil,
        company_name: nil,
        effective_date: nil,
        external_account_id: nil,
        funding: nil,
        individual_id: nil,
        individual_name: nil,
        require_approval: false,
        standard_entry_class_code: nil,
        statement_descriptor:
      )
        abs_amount = amount.abs
        directional_amount = direction == "credit" ? abs_amount : -abs_amount
        post("ach_transfers",
          account_id: account_id,
          account_number: account_number,
          routing_number: routing_number,
          addendum: addendum,
          amount: directional_amount,
          company_descriptive_date: company_descriptive_date,
          company_discretionary_data: company_discretionary_data,
          company_entry_description: company_entry_description,
          company_name: company_name,
          effective_date: effective_date,
          external_account_id: external_account_id,
          funding: funding,
          individual_id: individual_id,
          individual_name: individual_name,
          require_approval: require_approval,
          standard_entry_class_code: standard_entry_class_code,
          statement_descriptor: statement_descriptor
        )
      end


      def get_all_ach_transfers(
        account_id: nil,
        created_at_after: nil,
        created_at_before: nil,
        created_at_on_or_after: nil,
        created_at_on_or_before: nil,
        cursor: nil,
        external_account_id: nil,
        limit: nil,
        filters: {})
        get("ach_transfers",
          account_id: account_id,
          'created_at.after': created_at_after,
          'created_at.before': created_at_before,
          'created_at.on_or_after': created_at_on_or_after,
          'created_at.on_or_before': created_at_on_or_before,
          cursor: cursor,
          external_account_id: external_account_id,
          limit: limit,
          filters: filters
        )
      end

      def get_ach_transfer(ach_transfer_id:)
        get("ach_transfers/#{ach_transfer_id}")
      end

      def cancel_pending_ach_transfer(ach_transfer_id:)
        post("ach_transfers/#{ach_transfer_id}/cancel")
      end
    end
  end
end
