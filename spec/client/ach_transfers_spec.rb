RSpec.describe Increase::Client::AchTransfers do
  let!(:client) {
    Increase::Client.new(
      api_base_url: "https://sandbox.increase.com",
      api_key: "yFj6HZkoI1qJa9EVjLVCwYNbYGjNS0KH"
    )
  }

  context 'ach_transfers' do
    it 'should create an ach_transfer with account_id, statement_descriptor, amount' do
      VCR.use_cassette('create_ach_transfer') do
        ach_transfer = client.create_ach_transfer(
          account_id: "acc_1",
          statement_descriptor: "test ach transfer",
          amount: 100,
          direction: "to_increase"
        )

        expect(ach_transfer).to be_a(Hash)
        expect(ach_transfer["id"]).to be_a(String)
        expect(ach_transfer["account_id"]).to eq("acc_1")
        expect(ach_transfer["descriptor"]).to eq("test ach transfer")
        expect(ach_transfer["amount"]).to eq(100)
      end
    end
  end
end
