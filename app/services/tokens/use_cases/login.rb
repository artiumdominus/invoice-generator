module Tokens::UseCases
  class Login < ApplicationService
    is Tokens::Authenticate >>
      -> user:, token: do
        case Tokens::SetLastLogin[token:]
        in { ok: { token: } }
          { ok: { user:, token: } }
        in { error: }
          { error: } 
        end
      end
  end
end
