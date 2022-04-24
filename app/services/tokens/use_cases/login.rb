module Tokens::UseCases
  class Login < ApplicationService
    is Tokens::Authenticate >>
       Tokens::SetLastLogin
  end
end
