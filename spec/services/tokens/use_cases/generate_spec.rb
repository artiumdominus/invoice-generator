require 'rails_helper'

RSpec.describe Tokens::UseCases::Generate do
  describe "::[]" do
    let(:result) { described_class[email:] }

    context "when happy path" do
      let(:email) { "user@example.com" }
      let(:user) { create :user, email: }
      let(:token) { create :token, user: }

      it { expect(result).to match({ ok: { success: true } }) }

      it "validates the email" do
        allow(Tokens::Generate::Contract)
          .to receive(:[]).and_return({ ok: { email: } })

        expect(Tokens::Generate::Contract).to receive(:[]).once

        result
      end

      it "find or creates an user" do
        allow(Users::FindOrCreate)
          .to receive(:[]).and_return({ ok: { user: } })

        expect(Users::FindOrCreate).to receive(:[]).once

        result
      end

      it "creates a token" do
        allow(Tokens::Create)
          .to receive(:[]).and_return({ ok: { token: } })
        
        expect(Tokens::Create).to receive(:[]).once

        result
      end

      it "sends token activation email" do
        allow(Tokens::PublishActivationEmail)
          .to receive(:[]).and_return({ ok: { success: true } })

        expect(Tokens::PublishActivationEmail).to receive(:[]).once

        result
      end
    end
  end
end
