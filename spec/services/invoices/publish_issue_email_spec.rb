require 'rails_helper'

RSpec.describe Invoices::PublishIssueEmail do
  describe "::[]" do
    let!(:invoice) { create :invoice }
    let(:result) { described_class[invoice:] }

    context "when success" do
      it { expect(result).to match({ ok: { invoice: } }) }
      it { expect { result }.to have_enqueued_job(SendInvoiceEmailJob) }
    end
  end
end
