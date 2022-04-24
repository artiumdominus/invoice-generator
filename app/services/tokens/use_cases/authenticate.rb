module Tokens::UseCases
  class Authenticate < ApplicationService
    def call(code:)
      token = Token.find_by(id: code, active: true)
      
      if !token.nil?
        { ok: { user: token.user }}
      else
        { error: :token_not_fonud }
      end
    end
  end
end