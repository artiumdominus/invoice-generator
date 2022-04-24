module Tokens::UseCases
  class Generate < ApplicationService
    is Users::FindOrCreate >>
       Tokens::Create >>
       Tokens::EnqueueActivationEmail
  end
end
