module Invoices
  class PublishIssueEmail < ApplicationService
    def call(invoice:, emails: [])
      SendInvoiceEmailJob.perform_later(invoice:, emails:)

      { ok: { invoice: } }
    end
  end
end
