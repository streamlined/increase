RSpec.describe Increase::Client::Accounts do
  let!(:client) {
    Increase::Client.new(
      api_base_url: "https://sandbox.increase.com",
      api_key: "yFj6HZkoI1qJa9EVjLVCwYNbYGjNS0KH"
    )
  }

  context 'methods' do
    describe 'get_all_accounts' do
      let(:action) {
        client.get_all_accounts
      }

      it 'returns a list of account data' do
        expect(action["data"][0]).to include(
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

      context 'when open filter is passed' do
        let(:action) {
          client.get_all_accounts(filters: {
            status: "open"
          })
        }

        it 'only returns open accounts' do
          expect(action["data"][0]["status"]).to eql("open")
        end
      end
    end

    describe 'get_account' do
      let(:action) {
        client.get_account(account_id: "sandbox_account_kkcjd5zbximtpjn980tu") # ID in sandbox account
      }

      it 'returns an account' do
        expect(action).to include(
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

      context 'bad account_id' do
        let(:action) {
          client.get_account(account_id: 'bobross')
        }

        it 'fails' do
          expect(action).to be_kind_of(Increase::Error::NotFound)
        end
      end
    end

    describe 'create_account' do
      let(:action) {
        client.create_account(
          name: "rspec test creation"
        )
      }

      it 'returns an account' do
        expect(action).to include(
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

      # delete newly created account
      before do
        accounts = client.get_all_accounts
        account_id = accounts["data"]&.first["id"]
        client.close_account(account_id: account_id)
      end
    end

    describe 'update_account' do
      let(:action) {
        accounts = client.get_all_accounts
        account_id = accounts["data"]&.first["id"]
        client.update_account(
          account_id: account_id,
          name: "test"
        )
      }

      it 'returns an account' do
        expect(action["name"]).to eql("test")
      end

      context 'invalid account_id' do
        let(:action) {
          client.update_account(
            account_id: "test",
            name: "test"
          )
        }

        it 'returns nil or fails' do
          expect(action).to be_kind_of(Increase::Error::NotFound)
        end
      end
    end

    describe 'close_account' do
      it 'deletes the created account' do
        account_to_close = client.create_account(
          name: "rspec test creation"
        )
        closed_account = client.close_account(account_id: account_to_close["id"])
        expect(closed_account).to be_a(Hash)
        expect(closed_account["id"]).to eql(account_to_close["id"])
      end

      context 'invalid account_id' do
        let(:action) {
          client.close_account(account_id: "test")
        }

        it 'returns nil or fails' do
          expect(action).to be_kind_of(Increase::Error::NotFound)
        end
      end
    end

    describe 'create_account_number' do
      let(:action) {
        client.create_account_number(
          account_id: "sandbox_account_kkcjd5zbximtpjn980tu",  # settlement account id in sandbox
          name: "Rspec generated account number"
        )
      }

      it 'returns an account number' do
        expect(action).to include(
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

    describe 'get_account_number' do
      let(:account_number_id) {
        client.get_all_account_numbers["data"].first["id"]
      }
      let(:action) {
        client.get_account_number(account_number_id: account_number_id)
      }

      it 'returns an account number' do
        expect(action).to include(
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
