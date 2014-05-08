require "spec_helper"

describe PagSeguro::Notification do
  let(:code) { '766B9C-AD4B044B04DA-77742F5FA653-E1AB24' }
  let(:type) { 'transaction' }

  let(:notification) { PagSeguro::Notification.new(code, type) }
  subject { notification  }

  it { should respond_to(:transaction) }

  before do
    PagSeguro.email = 'mail'
    PagSeguro.token = 'token'
  end

  describe "#transaction" do
    subject { notification.transaction  }
    before do
      stub_request(:post, "https://ws.pagseguro.uol.com.br/v2/transactions/notifications/766B9C-AD4B044B04DA-77742F5FA653-E1AB24").
         with(body: "email=mail&token=token").to_return(status: 200)
    end

    it { should be_a_kind_of(PagSeguro::Transaction) }
  end
end