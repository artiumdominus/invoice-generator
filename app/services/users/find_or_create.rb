module Users
  class FindOrCreate < ApplicationService
    def call(email:)
      user = User.find_or_create_by(email:)

      if user.persisted?
        { ok: { user: } }
      else
        { error: :failure_in_user_creation }
      end
    end
  end
end
