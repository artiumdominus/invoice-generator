module Invoices::UseCases
  class Issue < ApplicationService
    is Invoices::IssueContract >>
       Invoices::Create >>
       Invoices::PublishIssueEmail
  end
end