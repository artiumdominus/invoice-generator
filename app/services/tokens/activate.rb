module Tokens
  class Activate < ApplicationService
    def call(token:)
      token.update(
        active: true,
        activated_at: DateTime.current,
        last_login: DateTime.current
      )

      { ok: { token: } }
    rescue ActiveRecord::ActiveRecordError 
      { error: :failure_in_token_activation }
    end
  end
end
