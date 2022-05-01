module Tokens
  class Create < ApplicationService
    def call(user:)
      token = Token.create(user:)

      { ok: { token: } }
    rescue ActiveRecord::ActiveRecordError 
      { error: :failure_in_token_creation }
    end
  end
end
