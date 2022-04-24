module Tokens::UseCases
  class Generate < ApplicationService
    is Tokens::GenerateContract >>
       Users::FindOrCreate >>
       Tokens::Create >>
       Tokens::PublishActivationEmail
  end
end
