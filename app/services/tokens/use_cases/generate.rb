module Tokens::UseCases
  class Generate < ApplicationService
    is Users::FindOrCreate >>
       Tokens::Create >>
       Tokens::PublishActivationEmail
  end
end
# TODO: Contract to email validation
