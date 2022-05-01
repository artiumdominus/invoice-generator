require 'rails_helper'

RSpec.describe Invoices::Issue::Contract do
  def unparse(attributes)
    attributes.merge(
      {
        number: attributes[:number].to_s,
        date: attributes[:date].to_s,
        total_amount_due: (attributes[:total_amount_due_cents] / 100.0).to_s,
        emails: attributes[:emails].join(' ')
      }
    )
    .except(:total_amount_due_cents)
  end

  describe ":[]" do
    let(:result) { described_class[user:, invoice:] }
    let(:user) { create :user }
    let(:attributes) { unparse attributes_for :invoice }
    
    context "when valid invoice" do
      let(:invoice) { attributes }

      it { expect(result).to match({ ok: { user: User, invoice: Hash } }) }
      it { expect(result.dig(:ok, :invoice, :date)).to eq(Date.parse(invoice[:date])) }
      it { expect(result.dig(:ok, :invoice, :total_amount_due_cents)).to eq(invoice[:total_amount_due].to_f * 100) }
      it { expect(result.dig(:ok, :invoice, :emails)).to eq(invoice[:emails].split(' ')) }
    end

    context "when number missing" do
      let(:invoice) { attributes.except(:number) }
        
      it { expect(result).to match({ error: { number: :required } }) }
    end

    context "when number already used" do
      let!(:previous_invoice) { create :invoice, number: 3, user: }
      let(:invoice) { attributes.merge(number: "3") }

      it { expect(result).to match({ error: { number: :already_in_use } }) }
    end

    context "when date missing" do
      let(:invoice) { attributes.except(:date) }

      it { expect(result).to match({ error: { date: :required } }) }
    end

    context "when invalid date" do
      let(:invoice) { attributes.merge(date: "asd-fgh!") }

      it { expect(result).to match({ error: { date: :invalid_format } }) }
    end

    context "when customer name missing" do
      let(:invoice) { attributes.except(:customer_name) }

      it { expect(result).to match({ error: { customer_name: :required } }) }
    end

    context "when total amount due missing" do
      let(:invoice) { attributes.except(:total_amount_due) }

      it { expect(result).to match({ error: { total_amount_due: :required } }) }
    end

    context "when invalid total amount due" do
      let(:invoice) { attributes.merge(total_amount_due: "asd-fgh!") }

      it { expect(result).to match({ error: { total_amount_due: :invalid_format } }) }
    end

    context "when emails missing" do
      let(:invoice) { attributes.except(:emails) }

      it { expect(result).to match({ error: { emails: :required } }) }
    end

    context "when one invalid email" do
      let(:invoice) { attributes.merge(emails: "joao@mail.com asd-fgh! maria@mail.com") }

      it { expect(result).to match({ error: { emails: { invalid_format: ["asd-fgh!"] } } }) }
    end

    context "when multiple invalid emails" do
      let(:invoice) { attributes.merge(emails: "joao_mail.com, maria@mail.com; jose#mail.com") }

      it { expect(result).to match({ error: { emails: { invalid_format: ["joao_mail.com", "jose#mail.com"] } } }) }
    end

    context "when multiple invalid attributes" do
      let(:invoice) {
        attributes.merge(
          {
            number: nil,
            date: "asd-fgh!",
            customer_name: nil,
            total_amount_due: "asd-fgh!",
            emails: "joao_mail.com, maria@mail.com; jose#mail.com"
          }
        )
      }

      it "returns multiple errors" do
        expect(result).to match(
          {
            error: {
              number: :required,
              date: :invalid_format,
              customer_name: :required,
              total_amount_due: :invalid_format,
              emails: { invalid_format: ["joao_mail.com", "jose#mail.com"] }
            }
          }
        )
      end
    end
  end
end
