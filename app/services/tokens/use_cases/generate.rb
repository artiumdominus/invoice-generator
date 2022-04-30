module Tokens::UseCases
  class Generate < ApplicationService
    is Tokens::Generate::Contract >>
       Users::FindOrCreate >>
       Tokens::Create >>
       Tokens::PublishActivationEmail
  end
end
