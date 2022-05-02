require 'rails_helper'

RSpec.describe Invoices::FindOfUser do
  describe "::[]" do
    let(:id) { invoice.id }
    let(:user) { invoice.user }
    let(:result) { described_class[user:, id:] }

    context "when valid params" do
      let(:invoice) { create :invoice }

      it { expect(result).to match({ ok: { invoice: Invoice } }) }
      it { expect(result.dig(:ok, :invoice)).to eq(invoice) }
    end

    context "when invoice does not exist" do
      let(:invoice) { (create :invoice).tap { |i| i.destroy } }

      it { expect(result).to match({ error: :invoice_of_user_not_found }) }
    end

    context "when wrong user" do
      let(:invoice) { create :invoice }
      let(:user) { create :user }

      it { expect(result).to match({ error: :invoice_of_user_not_found }) }
    end
  end
end
