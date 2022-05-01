require 'rails_helper'

RSpec.describe Users::FindOrCreate do
  describe "::[]" do
    let(:email) { "user@example.com" }
    let(:result) { described_class[email:] }

    context "when success" do
      it { expect(result).to match({ ok: { user: User } }) }

      context "when user does not exist" do
        it { expect { result }.to change(User, :count).by(1) }
      end

      context "when user already exist" do
        let!(:user) { create :user, email: }
        
        it { expect(result.dig(:ok, :user)).to eq(user) }
        it { expect { result }.to change(User, :count).by(0) }
      end
    end

    context "when failure" do
      before { ActiveRecord::Base.remove_connection }
      after { ActiveRecord::Base.establish_connection }

      it { expect(result).to match({ error: :failure_in_user_creation }) }
    end
  end
end
