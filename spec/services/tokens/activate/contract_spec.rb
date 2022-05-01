require 'rails_helper'

RSpec.describe Tokens::Activate::Contract do
  describe "::[]" do
    let(:code) { token.id }
    let(:result) { described_class[code:] }

    context "when valid token" do
      let(:token) { create :token }

      it { expect(result).to match({ ok: { token: Token } }) }
    end

    context "when expired token" do
      let(:token) { create :token, created_at: Date.current - 2.days }

      it { expect(result).to match({ error: :token_expired_to_activate }) }
    end

    context "when token does not exist" do
      let(:token) { (create :token).tap { |t| t.destroy } }

      it { expect(result).to match({ error: :token_not_found }) }
    end
  end
end
