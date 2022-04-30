module Tokens::UseCases
  class Activate < ApplicationService
    is Tokens::Activate::Contract >>
       Tokens::Activate >>
       Tokens::DeactivatePrevious
  end
end
