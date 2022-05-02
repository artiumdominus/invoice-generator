require 'rails_helper'

RSpec.describe Invoices::SendToMoreEmails::Contract do
  describe "::[]" do
    let(:user) { create :user }
    let(:id) { (create :token).id }
    let(:result) { described_class[user:, id:, emails:] }

    context "when valid emails" do
      let(:emails) { (1..3).map { Faker::Internet.email }.join(', ') }

      it { expect(result).to match({ ok: { user:, id:, emails: Array } }) }
    end

    context "when milling emails" do
      let(:emails) { nil }

      it { expect(result).to match({ error: { emails: :required } }) }
    end

    context "when one invalid email" do
      let(:emails) { "joao@mail.com asd-fgh! maria@mail.com" }

      it { expect(result).to match({ error: { emails: { invalid_format: ["asd-fgh!"] } } }) }
    end

    context "when multiple invalid emails" do
      let(:emails) { "joao_mail.com, maria@mail.com; jose#mail.com" }

      it { expect(result).to match({ error: { emails: { invalid_format: ["joao_mail.com", "jose#mail.com"] } } }) }
    end
  end
end
