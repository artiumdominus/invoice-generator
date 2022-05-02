require 'rails_helper'

RSpec.describe Invoices::Find do
  describe "::[]" do
    let(:id) { invoice.id }
    let(:result) { described_class[id:] }

    context "when valid id" do
      let(:invoice) { create :invoice }

      it { expect(result).to match({ ok: { invoice: Invoice } }) }
      it { expect(result.dig(:ok, :invoice)).to eq(invoice) }
    end

    context "when invoice does not exist" do
      let(:invoice) { (create :invoice).tap { |i| i.destroy } }

      it { expect(result).to match({ error: :invoice_not_found }) }
    end
  end
end
