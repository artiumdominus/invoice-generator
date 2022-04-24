module Tokens
  class GenerateContract < ApplicationService
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    def call(email:)
      if (email in String) && email in VALID_EMAIL_REGEX
        { ok: { email: } }
      else
        { error: :email_invalid_format }
      end
    end
  end
end