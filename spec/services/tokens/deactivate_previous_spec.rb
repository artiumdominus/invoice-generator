require 'rails_helper'

RSpec.describe Tokens::DeactivatePrevious do
  describe "::[]" do
    let!(:user) { create :user }
    let!(:previous_lost_token) { create :token, user:, active: true, created_at: Date.current - 2.days }
    let!(:previous_token) { create :token, user:, active: true, created_at: Date.current - 1.day }
    let!(:token) { create :token, user: }
    
    let(:result) { described_class[token:] }

    context "when success" do
      it { expect(result).to match({ ok: { token: Token } }) }

      it "deactivate previous token" do
        expect { result }.to change { previous_token.reload.active }
          .from(true).to(false)
      end

      it "deactivate lost previous token" do
        expect { result }.to change { previous_lost_token.reload.active }
          .from(true).to(false)
      end
    end
  end
end
