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

      {
        Invoices::Issue::Contract => "validates the invoice attributes",
        Invoices::Create => "creates the invoice",
        Invoices::PublishIssueEmail => "sends the invoice to the responsible for payment"
      }.each do |step, description|
        it description do
          allow(step).to receive(:[]).and_call_original
          expect(step).to receive(:[]).once

          result
        end
      end
    end
  end
end
