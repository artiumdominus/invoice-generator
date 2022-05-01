module Tokens
  class Activate::Contract < ApplicationService
    def call(code:)
      token = Token.find(code)

      if !expired_to_activate?(token)
        { ok: { token: } }
      else
        { error: :token_expired_to_activate }
      end
    rescue ActiveRecord::RecordNotFound
      { error: :token_not_found }
    end

    private

    def expired_to_activate?(token)
      (DateTime.current.in_time_zone - token.created_at) / 1.hour > 24
    end
  end
end
