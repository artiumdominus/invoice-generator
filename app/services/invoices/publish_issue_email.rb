module Invoices
  class PublishIssueEmail < ApplicationService
    def call(invoice:)
      SendInvoiceEmailJob.perform_later(invoice:)

      { ok: { invoice: } }
    end
  end
end
