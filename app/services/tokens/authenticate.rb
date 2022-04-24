module Tokens
  class Authenticate < ApplicationService
    def call(code:)
      token = Token.find_by(id: code, active: true)
      
      if !token.nil?
        { ok: { user: token.user, token: token } }
      else
        { error: :token_not_found }
      end
    end
  end
end