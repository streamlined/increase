RSpec.describe Increase::Client::AccountTransfers do
  let!(:client) {
    Increase::Client.new(
      api_base_url: "https://sandbox.increase.com"
    )
  }

  context 'methods' do
    describe 'list account_transfers' do
      it 'should return a list of account transfers' do
        VCR.use_cassette('list_account_transfers') do
          account_transfers = client.list_account_transfers
          expect(account_transfers).to be_a(Hash)
          expect(account_transfers["data"][0]).to include(
            "id",
            "account_id",
            "amount",
            "description",
            "destination_account_id",
            "created_at"
          )
        end
      end
    end

    describe 'create_account_transfer' do
      it 'should create an account transfer' do
        VCR.use_cassette('create_account_transfer') do
          account_transfer = client.create_account_transfer(
            account_id: "sandbox_account_kkcjd5zbximtpjn980tu",
            amount: 100,
            description: "test account transfer",
            destination_account_id: "sandbox_account_eph1lxpbg4blsrr99pgb"
          )

          expect(account_transfer).to be_a(Hash)
          expect(account_transfer["id"]).to be_a(String)
          expect(account_transfer["account_id"]).to eq("sandbox_account_kkcjd5zbximtpjn980tu")
          expect(account_transfer["amount"]).to eq(100)
          expect(account_transfer["description"]).to eq("test account transfer")
          expect(account_transfer["destination_account_id"]).to eq("sandbox_account_eph1lxpbg4blsrr99pgb")
        end
      end
    end
  end
end
