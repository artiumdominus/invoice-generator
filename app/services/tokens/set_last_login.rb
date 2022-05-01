module Tokens
  class SetLastLogin < ApplicationService
    def call(token:)
      token.update(last_login: DateTime.current)
      
      { ok: { token: } }
    rescue ActiveRecord::ActiveRecordError
      { error: :failure_in_token_update }
    end
  end
end
