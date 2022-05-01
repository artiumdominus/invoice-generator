require 'rails_helper'

RSpec.describe Tokens::Create do
  describe "::[]" do
    let!(:user) { create :user }
    let(:result) { described_class[user:] }

    context "when success" do
      it { expect(result).to match({ ok: { token: Token } }) }
      it { expect { result }.to change(Token, :count).by(1) }
    end

    context "when failure" do
      before { ActiveRecord::Base.remove_connection }
      after { ActiveRecord::Base.establish_connection }

      it { expect(result).to match({ error: :failure_in_token_creation }) }
    end
  end
end
