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

      it do
        allow(Invoices::SendToMoreEmails::Contract)
          .to receive(:[]).and_return({ ok: { user:, id:, emails: parsed_emails } })
        
        expect(Invoices::SendToMoreEmails::Contract).to receive(:[]).once

        result
      end

      it do
        allow(Invoices::FindOfUser)
          .to receive(:[]).and_return({ ok: { invoice: } })

        expect(Invoices::FindOfUser).to receive(:[]).once

        result
      end

      it do
        allow(Invoices::Update)
          .to receive(:[]).and_return({ ok: { invoice:, emails: } })

        expect(Invoices::Update).to receive(:[]).once

        result
      end

      it do
        allow(Invoices::PublishIssueEmail)
          .to receive(:[]).and_return({ ok: { invoice: } })

        expect(Invoices::PublishIssueEmail).to receive(:[]).once

        result
      end
    end
  end
end
