require 'rails_helper'

RSpec.describe Invoices::Create do
  describe "::[]" do
    let!(:user) { create :user }
    let(:invoice) { attributes_for :invoice }
    let(:result) { described_class[user:, invoice:] }

    context "when success" do
      it { expect(result).to match({ ok: { invoice: Invoice } }) }
      it { expect { result }.to change(Invoice, :count).by(1) }
    end

    context "when failure" do
      before { ActiveRecord::Base.remove_connection }
      after { ActiveRecord::Base.establish_connection }

      it { expect(result).to match({ error: :failure_in_invoice_creation }) }
    end
  end
end
