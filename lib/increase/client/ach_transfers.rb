module Increase
  class Client
    module ach_transfers
      def create_ach_transfer(
        account_id:, 
        account_number:, 
        routing_number:, 
        addendum:,
        amount:, 
        company_descriptive_date:,
        company_discretionary_data:,
        company_entry_description:,
        company_name:,
        effective_date:,
        external_account_id:,
        funding:,
        individual_id:,
        individual_name:,
        required_approval:,
        standard_entry_class_code:,
        statement_descriptor:
      ) 
        post("ach_transfers", {
          account_id: account_id, 
          account_number: account_number, 
          routing_number: routing_number, 
          addendum: addendum,
          amount: amount, 
          company_descriptive_date: company_descriptive_date,
          company_discretionary_data: company_discretionary_data,
          company_entry_description: company_entry_description,
          company_name: company_name,
          effective_date: effective_date,
          external_account_id: external_account_id,
          funding: funding,
          individual_id: individual_id,
          individual_name: individual_name,
          required_approval: required_approval,
          standard_entry_class_code: standard_entry_class_code,
          statement_descriptor: statement_descriptor
        }
      end


      def get_all_ach_transfers(
        account_id:,
        created_at_after:,
        created_at_before:,
        created_at_on_or_after:,
        created_at_on_or_before:,
        cursor:,
        external_account_id:,
        limit:,
        filters: {})
        get("ach_transfers", 
          account_id: account_id,
          created_at_after: created_at_after,
          created_at_before: created_at_before,
          created_at_on_or_after: created_at_on_or_after,
          created_at_on_or_before: created_at_on_or_before,
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