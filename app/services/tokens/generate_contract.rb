module Tokens
  class GenerateContract < ApplicationService
    def call(email:)
      if (email in String) && email in URI::MailTo::EMAIL_REGEXP
        { ok: { email: } }
      else
        { error: :email_invalid_format }
      end
    end
  end
end
