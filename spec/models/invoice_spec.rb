require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:invoice) do
    build :invoice,
      number: 15,
      date: Date.new(2022, 3, 30),
      total_amount_due_cents: 15_396_72
  end

  describe "#total_amount_due" do
    it { expect(invoice.total_amount_due).to eq("15396.72") }
  end

  describe "#pdf_title" do
    it { expect(invoice.pdf_title).to eq("invoice_20220330_15.pdf") }
  end
end
