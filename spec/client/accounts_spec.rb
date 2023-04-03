RSpec.describe Increase::Client::Accounts do
  let!(:client) {
    Increase::Client.new(
      api_base_url: "https://sandbox.increase.com"
    )
  }

  context 'methods' do
    describe 'get_all_accounts' do
      let(:action) {
        client.get_all_accounts
      }

      it 'returns a list of account data' do
        VCR.use_cassette('get_all_accounts') do
          response = client.get_all_accounts
          expect(response).to be_a(Hash)
          expect(response["data"][0]).to include(
            "balance",
            "balances",
            "bank",
            "created_at",
            "currency",
            "entity_id",
            "informational_entity_id",
            "id",
            "interest_accrued",
            "interest_accrued_at",
            "name",
            "status",
            "replacement",
            "type"
          )
        end
      end

      context 'when open filter is passed' do
        it 'only returns open accounts' do
          VCR.use_cassette('get_all_accounts_with_filter') do
            response = client.get_all_accounts(filters: {
              status: "open"
            })
            expect(response).to be_a(Hash)
            expect(response["data"][0]["status"]).to eql("open")
          end
        end
      end
    end

    describe 'get_account' do
      it 'returns an account' do
        VCR.use_cassette('accounts-get_account') do
          response = client.get_account(account_id: "sandbox_account_kkcjd5zbximtpjn980tu") # ID in sandbox account
          expect(response).to be_a(Hash)
          expect(response).to include(
            "balance",
            "balances",
            "bank",
            "created_at",
            "currency",
            "entity_id",
            "informational_entity_id",
            "id",
            "interest_accrued",
            "interest_accrued_at",
            "name",
            "status",
            "replacement",
            "type"
          )
        end
      end

      context 'bad account_id' do
        it 'fails' do

          VCR.use_cassette('accounts-get_account_failure') do
            response = client.get_account(account_id: 'bobross')
            expect(response).to be_kind_of(Increase::Error::NotFound)
          end
        end
      end
    end

    describe 'create_account' do
      let(:action) {
        client.create_account(
          name: "rspec test creation",
          program_id: 'sandbox_program_1'
        )
      }

      it 'returns an account' do
        VCR.use_cassette('accounts-create_account') do
          response = client.create_account(
            name: "rspec test creation",
            program_id: 'sandbox_program_1'
          )
          expect(response).to be_a(Hash)
          expect(response).to include(
            "balance",
            "balances",
            "bank",
            "created_at",
            "currency",
            "entity_id",
            "informational_entity_id",
            "id",
            "interest_accrued",
            "interest_accrued_at",
            "name",
            "status",
            "replacement",
            "type"
          )
        end
      end
    end

    describe 'update_account' do

      it 'returns an account' do
        VCR.use_cassette('accounts-update_account') do
          accounts = client.get_all_accounts
          account_id = accounts["data"]&.first["id"]
          response = client.update_account(
            account_id: account_id,
            name: "test"
          )
          expect(response["name"]).to eql("test")
        end
      end

      context 'invalid account_id' do
        it 'returns nil or fails' do
          VCR.use_cassette('accounts-update_account_failure') do
            response = client.update_account(
              account_id: "test",
              name: "test"
            )
            expect(response).to be_kind_of(Increase::Error::NotFound)
          end
        end
      end
    end

    describe 'close_account' do
      it 'deletes the created account' do
        VCR.use_cassette('accounts-close_account') do
          account_to_close = client.create_account(
            name: "rspec test creation",
            program_id: 'sandbox_program_1'
          )
          closed_account = client.close_account(account_id: account_to_close["id"])
          expect(closed_account).to be_a(Hash)
          expect(closed_account["id"]).to eql(account_to_close["id"])
        end
      end

      context 'invalid account_id' do
        it 'returns nil or fails' do
          VCR.use_cassette('accounts-close_account_failure') do
            response = client.close_account(account_id: "test")
            expect(response).to be_kind_of(Increase::Error::NotFound)
          end
        end
      end
    end

    describe 'create_account_number' do
      it 'returns an account number' do
        VCR.use_cassette('accounts-create_account_number') do
          response = client.create_account_number(
            account_id: "sandbox_account_kkcjd5zbximtpjn980tu",  # settlement account id in sandbox
            name: "Rspec generated account number"
          )
          expect(response).to include(
            "account_id",
            "account_number",
            "id",
            "created_at",
            "name",
            "routing_number",
            "status",
            "replacement",
            "type"
          )
        end
      end
    end

    describe 'get_all_account_numbers' do
      it 'returns a list of account numbers' do
        VCR.use_cassette('accounts-get_all_account_numbers') do
          response = client.get_all_account_numbers
          expect(response).to be_a(Hash)
          expect(response["data"][0]).to include(
            "account_id",
            "account_number",
            "id",
            "created_at",
            "name",
            "routing_number",
            "status",
            "replacement",
            "type"
          )
        end
      end
    end

    describe 'get_account_number' do
      it 'returns an account number' do
        VCR.use_cassette('accounts-get_account_number') do
          account_numbers = client.get_all_account_numbers
          account_number_id = account_numbers["data"].first["id"]
          response = client.get_account_number(account_number_id: account_number_id)
          expect(response).to include(
            "account_id",
            "account_number",
            "id",
            "created_at",
            "name",
            "routing_number",
            "status",
            "replacement",
            "type"
          )
        end
      end
    end
  end
end
