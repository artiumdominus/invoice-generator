require 'rails_helper'

RSpec.describe Tokens::Generate::Contract do
  describe "::[]" do
    let(:result) { described_class[email:] }

    context "when valid email" do
      let(:email) { "user@example.com" }

      it { expect(result).to match({ ok: { email: } }) }
    end

    context "when invalid email" do
      let(:email) { "user_example.com" }

      it { expect(result).to match({ error: :email_invalid_format }) }
    end

    context "when nil" do
      let(:email) { nil }

      it { expect(result).to match({ error: :email_invalid_format }) }
    end
  end
end
