module Invoices::UseCases
  class Issue < ApplicationService
    is Invoices::Issue::Contract >>
       Invoices::Create >>
       Invoices::PublishIssueEmail
  end
end
