require 'rails_helper'

RSpec.describe Tokens::UseCases::Activate do
  describe "::[]" do
    let(:code) { token.id }
    let(:result) { described_class[code:] }

    context "when happy path" do
      let(:token) { create :token }

      it { expect(result).to match({ ok: { token: Token } }) }
      it { expect(result.dig(:ok, :token).active).to be true }

      {
        Tokens::Activate::Contract => "validates the token code",
        Tokens::Activate => "activates the token",
        Tokens::DeactivatePrevious => "deactivates previous tokens"
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
