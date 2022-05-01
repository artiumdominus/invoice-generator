require 'rails_helper'

RSpec.describe Tokens::SetLastLogin do
  describe "::[]" do
    let!(:token) { create :token }
    let(:result) { described_class[token:] }

    context "when success" do
      it { expect(result).to match({ ok: { token: Token } }) }
      it { expect { result }.to change { token.reload.last_login } }
    end

    context "when failure" do
      before { ActiveRecord::Base.remove_connection }
      after { ActiveRecord::Base.establish_connection }

      it { expect(result).to match({ error: :failure_in_token_update }) }
    end
  end
end
