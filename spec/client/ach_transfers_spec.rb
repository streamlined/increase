RSpec.describe Increase::Client::AchTransfers do
  let!(:client) {
    Increase::Client.new(
      api_base_url: "https://sandbox.increase.com",
    )
  }

  context 'ach_transfers' do
    it 'should create an ach credit transfer' do
      VCR.use_cassette('create_ach_transfer-credit') do
        ach_transfer = client.create_ach_transfer(
          account_number: "5574354847",
          routing_number: "074920909",
          account_id: "sandbox_account_kkcjd5zbximtpjn980tu",
          statement_descriptor: "test ach transfer",
          amount: 100,
          direction: "credit"
        )

        expect(ach_transfer).to be_a(Hash)
        expect(ach_transfer["id"]).to be_a(String)
        expect(ach_transfer["account_id"]).to eq("sandbox_account_kkcjd5zbximtpjn980tu")
        expect(ach_transfer["statement_descriptor"]).to eq("test ach transfer")
        expect(ach_transfer["amount"]).to eq(100)
      end
    end

    it 'should create an ach debit transfer' do
      VCR.use_cassette('create_ach_transfer-debit') do
        ach_transfer = client.create_ach_transfer(
          account_number: "5574354847",
          routing_number: "074920909",
          account_id: "sandbox_account_kkcjd5zbximtpjn980tu",
          statement_descriptor: "test ach transfer",
          amount: 100,
          direction: "debit"
        )
  
        expect(ach_transfer).to be_a(Hash)
        expect(ach_transfer["id"]).to be_a(String)
        expect(ach_transfer["account_id"]).to eq("sandbox_account_kkcjd5zbximtpjn980tu")
        expect(ach_transfer["statement_descriptor"]).to eq("test ach transfer")
        expect(ach_transfer["amount"]).to eq(-100)
      end
    end

    it 'should list ach transfers' do
      VCR.use_cassette('list_ach_transfers') do
        ach_transfers = client.get_all_ach_transfers

        expect(ach_transfers).to be_a(Hash)
        expect(ach_transfers["data"][0]).to include(
          "id",
          "account_id",
          "amount",
          "statement_descriptor",
          "created_at"
        )
      end
    end
  end
end
