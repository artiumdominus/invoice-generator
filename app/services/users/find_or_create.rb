module Users
  class FindOrCreate < ApplicationService
    def call(email:)
      user = User.find_or_create_by(email:)

      { ok: { user: } }
    rescue ActiveRecord::ActiveRecordError
      { error: :failure_in_user_creation }
    end
  end
end
