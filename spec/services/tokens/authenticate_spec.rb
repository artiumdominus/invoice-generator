require 'rails_helper'

RSpec.describe Tokens::Authenticate do
  describe "::[]" do
    let(:code) { token.id }
    let(:result) { described_class[code:] }
    
    context "when token is active" do
      let(:token) { create :token, active: true }

      it { expect(result).to match({ ok: { user: User, token: Token } }) }
      it { expect(result.dig(:ok, :user)).to eq(result.dig(:ok, :token).user) }
    end

    context "when token is not active" do
      let(:token) { create :token }
      
      it { expect(result).to match({ error: :token_not_found }) }
    end

    context "when token does not exist" do
      let(:token) { (create :token).tap { |t| t.destroy } }

      it { expect(result).to match({ error: :token_not_found }) }
    end

    context "when failure" do
      let!(:token) { create :token, active: true }

      before { ActiveRecord::Base.remove_connection }
      after { ActiveRecord::Base.establish_connection }

      it { expect(result).to match({ error: :failure_in_token_authentication }) }
    end
  end 
end
