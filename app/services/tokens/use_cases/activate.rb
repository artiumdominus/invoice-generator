module Tokens::UseCases
  class Activate < ApplicationService
    is Tokens::ActivateContract >>
       Tokens::Activate >>
       Tokens::DeactivatePrevious
  end
end