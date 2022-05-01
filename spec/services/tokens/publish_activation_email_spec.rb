require 'rails_helper'

RSpec.describe Tokens::PublishActivationEmail do
  describe "::[]" do
    let!(:token) { create :token }
    let(:result) { described_class[token:] }

    context "when success" do
      it { expect(result).to match({ ok: { success: true } }) }
      it { expect { result }.to have_enqueued_job(ActionMailer::MailDeliveryJob) }
    end
  end
end
