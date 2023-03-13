RSpec.describe Increase::Client::Transactions do
  let!(:client) {
    Increase::Client.new(
      api_base_url: "https://sandbox.increase.com",
      api_key: ""
    )
  }

  context '#get_all_transactions' do
    it 'grabs all transactions' do
      VCR.use_cassette('transactions-get_all_transactions') do
        response = client.get_all_transactions
        expect(response).to be_a(Hash)
        expect(response["data"].count).to_not be(0)
      end
    end
  end

  context '#get_transaction' do
    it 'grabs all transactions' do
      VCR.use_cassette('transactions-get_transaction') do
        response = client.get_transaction(transaction_id: 'sandbox_transaction_4xdy2xwuvwhfmqfxb7ed')
        expect(response).to be_a(Hash)
        expect(response["account_id"]).to_not be(nil)
      end
    end
  end
end
