require 'rails_helper'

RSpec.describe Invoices::Update do
  describe "::[]" do
    let!(:invoice) { create :invoice }
    let(:emails) { (1..3).map { Faker::Internet.email } }
    let(:result) { described_class[invoice:, emails:] }

    context "when success" do
      it { expect(result).to match({ ok: { invoice: Invoice, emails: Array } }) }
      it { expect { result }.to change { invoice.reload.emails.length }.by(emails.length) }
      it { expect(result.dig(:ok, :emails)).to eq(emails) }

      context "when repeated emails" do
        let(:invoice) { create :invoice, emails: ["joao@email.com", "maria@email.com", "jose@email.com"] }
        let(:emails) { ["maria@email.com", "joao@email.com", "joaquina@email.com"] }
        let(:expected_emails) { ["joao@email.com", "maria@email.com", "jose@email.com", "joaquina@email.com"] }

        it { expect { result }.to change { invoice.reload.emails.length }.from(3).to(4) }
        it { expect(result.dig(:ok, :emails)).to eq(["joaquina@email.com"]) }
        it { expect(result.dig(:ok, :invoice).emails).to eq(expected_emails) }
      end
    end

    context "when failure" do
      before { ActiveRecord::Base.remove_connection }
      after { ActiveRecord::Base.establish_connection }

      it { expect(result).to match({ error: :failure_in_invoice_update }) }
    end
  end
end
