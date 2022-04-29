require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "#total_amount_due" do
    invoice = FactoryBot.build :invoice, total_amount_due_cents: 15_396_72

    it { expect(invoice.total_amount_due).to eq("15396.72") }
  end
end
