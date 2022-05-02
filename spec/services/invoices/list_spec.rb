require 'rails_helper'

RSpec.describe Invoices::List do
  describe "::[]" do
    let(:user) { create :user }
    let!(:user_invoices) { create_list :invoice, 5, user: }
    let!(:other_invoices) { create_list :invoice, 10 }
    let(:result) { described_class[user:] }

    it { expect(result.length).to be(user_invoices.length) }
    it { expect(result).to match_array(user_invoices) }
  end
end
