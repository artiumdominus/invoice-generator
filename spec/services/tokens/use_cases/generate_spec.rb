require 'rails_helper'

RSpec.describe Tokens::UseCases::Generate do
  describe "::[]" do
    let(:result) { described_class[email:] }

    context "when happy path" do
      let(:email) { "user@example.com" }

      it { expect(result).to match({ ok: { success: true } }) }

      {
        Tokens::Generate::Contract => "validates the email",
        Users::FindOrCreate => "find or creates an user",
        Tokens::Create => "creates a token",
        Tokens::PublishActivationEmail => "sends token activation email"
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
