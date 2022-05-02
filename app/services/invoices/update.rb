module Invoices
  class Update < ApplicationService
    def call(invoice:, emails:)
      new_emails = emails - invoice.emails
      invoice.update(emails: invoice.emails | emails)

      { ok: { invoice:, emails: new_emails } }
    rescue ActiveRecord::ActiveRecordError
      { error: :failure_in_invoice_update }
    end
  end
end
