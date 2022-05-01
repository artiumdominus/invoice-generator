require 'rails_helper'

RSpec.describe Tokens::UseCases::Activate do
  describe "::[]" do
    let(:code) { token.id }
    let(:result) { described_class[code:] }

    context "when happy path" do
      let(:token) { create :token }

      it { expect(result).to match({ ok: { token: Token } }) }
      it { expect(result.dig(:ok, :token).active).to be true }

      it "validates the token code" do
        allow(Tokens::Activate::Contract)
          .to receive(:[]).and_return({ ok: { token: } })

        expect(Tokens::Activate::Contract).to receive(:[]).once

        result
      end

      it "activates the token" do
        allow(Tokens::Activate)
          .to receive(:[]).and_return({ ok: { token: } })
        
        expect(Tokens::Activate).to receive(:[]).once

        result
      end

      it "deactivates previous tokens" do
        allow(Tokens::DeactivatePrevious)
          .to receive(:[]).and_return({ ok: { token: } })
        
        expect(Tokens::DeactivatePrevious).to receive(:[]).once

        result
      end
    end
  end
end
