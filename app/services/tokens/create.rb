module Tokens
  class Create < ApplicationService
    def call(user:)
      token = Token.create(user:)

      if token.persisted?
        { ok: { token: } }
      else
        { error: :failure_in_token_creation }
      end
    end
  end
end