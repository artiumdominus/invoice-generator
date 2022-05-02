require 'rails_helper'

RSpec.describe Invoices::Changeset do
  describe "::[]" do
    context "when no param is passed" do
      let(:result) { described_class[] }

      it { expect(result.id).to be_nil }
      it { expect(result.number).to be_nil }
      it { expect(result.date).to be_nil }
      it { expect(result.customer_name).to be_nil }
      it { expect(result.customer_notes).to be_nil }
      it { expect(result.total_amount_due_cents).to be_nil }
      it { expect(result.total_amount_due).to eq("") }
      it { expect(result.emails).to eq([]) }
      it { expect(result.user).to be_nil }
    end

    context "when params are passed" do
      let(:result) { described_class[invoice: attributes] }
      let(:user) { create :user }
      let(:attributes) do
        (attributes_for :invoice)
          .merge(
            {
              total_amount_due: "105.99",
              user_id: user.id
            }
          )
      end

      it { expect(result.id).to be_nil }
      it { expect(result.number).to eq(attributes[:number].to_s) }
      it { expect(result.date).to eq(attributes[:date]) }
      it { expect(result.customer_name).to eq(attributes[:customer_name]) }
      it { expect(result.total_amount_due_cents).to eq(10599) }
      it { expect(result.total_amount_due).to eq("105.99") }
      it { expect(result.emails).to eq(attributes[:emails]) }
      it { expect(result.user).to eq(user) }
    end
  end
end
