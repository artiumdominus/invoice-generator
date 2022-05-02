require 'rails_helper'

RSpec.describe Invoices::UseCases::SendToMoreEmails do
  describe "::[]" do
    let(:result) { described_class[user:, id:, emails:] }

    context "when happy path" do
      let(:invoice) { create :invoice }
      let(:user) { invoice.user }
      let(:id) { invoice.id }
      let(:emails) { parsed_emails.join(', ') }
      let(:parsed_emails) { (1..3).map { Faker::Internet.email } }

      it { expect(result).to match({ ok: { invoice: Invoice } }) }
      it { expect { result }.to change { invoice.reload.emails.length } }
      it { expect { result }.to have_enqueued_job(SendInvoiceEmailJob) }

      {
        Invoices::SendToMoreEmails::Contract => "validates the new email addresses",
        Invoices::FindOfUser => "retrieves the invoice",
        Invoices::Update => "includes the new emails in the invoice",
        Invoices::PublishIssueEmail => "send the invoice to the new emails"
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
