require 'spec_helper'

describe DomainsRetriever do
  let(:retriever) { described_class.new }
  let(:body) do
    {
      data: [
        {
          domain_id: 1234,
          hostname: "vimtricks.com",
          port: 443,
        }
      ]
    }.to_json
  end
  let(:response) { double(:response, body: body) }

  subject { retriever.call }

  it "saves domains retrieved from trackssl" do
    expect(retriever).to receive(:response).and_return(response)
    expect { subject }.to change { Domain.count }.by(1)
  end

end
