module Tokens
  class Activate < ApplicationService
    def call(token:)
      if
        token.update(
          active: true,
          activated_at: DateTime.current,
          last_login: DateTime.current
        )
      then
        { ok: { token: } }
      else
        { error: :failure_in_token_update }
      end
    end
  end
end
