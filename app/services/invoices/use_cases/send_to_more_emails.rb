module Invoices::UseCases
  class SendToMoreEmails < ApplicationService
    is Invoices::SendToMoreEmailsContract >>
      -> user:, id:, emails: do
        case Invoices::FindOfUser[user:, id:]
        in { ok: { invoice: } }
          (Invoices::Update >>
           Invoices::PublishIssueEmail)[invoice:, emails:]
        in { error: }
          { error: }
        end
      end
  end
end
