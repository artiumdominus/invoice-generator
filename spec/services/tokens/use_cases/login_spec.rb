require 'rails_helper'

RSpec.describe Tokens::UseCases::Login do
  describe "::[]" do
    let(:code) { token.id }
    let(:result) { described_class[code:] }

    context "when happy path" do
      let(:token) { create :token, :active }

      it { expect(result).to match({ ok: { user: User, token: Token } }) }
      
      it "register a new login" do
        login_attempt_datetime = DateTime.current
        expect(result.dig(:ok, :token).last_login).to be > login_attempt_datetime
      end

      {
        Tokens::Authenticate => "authenticates the token",
        Tokens::SetLastLogin => "sets the last login"
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
