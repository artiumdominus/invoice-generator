module Tokens
  class SetLastLogin < ApplicationService
    def call(user:, token:)
      if token.update(last_login: DateTime.current)
        { ok: { user:, token: } }
      else
        { error: :failure_in_token_update }
      end
    end
  end
end