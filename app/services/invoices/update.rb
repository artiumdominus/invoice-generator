module Invoices
  class Update < ApplicationService
    def call(invoice:, emails:)
      new_emails = emails - invoice.emails

      if invoice.update(emails: invoice.emails | emails)
        { ok: { invoice:, emails: new_emails } }
      else
        { error: :failure_in_invoice_update }
      end
    end
  end
end
