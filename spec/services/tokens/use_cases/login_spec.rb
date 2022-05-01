require 'rails_helper'

RSpec.describe Tokens::UseCases::Login do
  describe "::[]" do
    let(:code) { token.id }
    let(:result) { described_class[code:] }

    context "when happy path" do
      let(:token) { create :token, active: true }
      let(:user) { token.user }

      it { expect(result).to match({ ok: { user: User, token: Token } }) }
      
      it "register a new login" do
        login_attempt_datetime = DateTime.current
        expect(result.dig(:ok, :token).last_login).to be > login_attempt_datetime
      end

      it "authenticates the token" do
        allow(Tokens::Authenticate)
          .to receive(:[]).and_return({ ok: { user:, token: } })
        
        expect(Tokens::Authenticate).to receive(:[]).once

        result
      end

      it "sets the last login" do
        allow(Tokens::SetLastLogin)
          .to receive(:[]).and_return({ ok: { token: } })
        
        expect(Tokens::SetLastLogin).to receive(:[]).once

        result
      end
    end
  end
end
