require 'rails_helper'

RSpec.describe Invoices::UseCases::Issue do
  def unparse(attributes)
    attributes.merge(
      {
        number: attributes[:number].to_s,
        date: attributes[:date].to_s,
        total_amount_due: (attributes[:total_amount_due_cents] / 100.0).to_s,
        emails: attributes[:emails].join(' ')
      }
    )
    .except(:total_amount_due_cents)
  end

  describe "::[]" do
    let(:result) { described_class[user:, invoice:] }

    context "when happy path" do
      let(:user) { create :user }
      let(:invoice) { unparse attributes_for :invoice }

      it { expect(result).to match({ ok: { invoice: Invoice } }) }
      it { expect { result }.to change(Invoice, :count).by(1) }
      it { expect { result }.to have_enqueued_job(SendInvoiceEmailJob) }

      it "validates the invoice attributes" do
        allow(Invoices::Issue::Contract)
          .to receive(:[]).and_return({ ok: { user:, invoice: attributes_for(:invoice) } })

        expect(Invoices::Issue::Contract).to receive(:[]).once

        result
      end

      it "creates the invoice" do
        allow(Invoices::Create)
          .to receive(:[]).and_return({ ok: { invoice: create(:invoice) } })

        expect(Invoices::Create).to receive(:[]).once

        result
      end

      it "sends the invoice to the responsible for payment" do
        allow(Invoices::PublishIssueEmail)
          .to receive(:[]).and_return({ ok: { invoice: create(:invoice) } })
        
        expect(Invoices::PublishIssueEmail).to receive(:[]).once

        result
      end
    end
  end
end
