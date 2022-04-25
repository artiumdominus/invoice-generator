module Invoices
  class PublishIssueEmail < ApplicationService
    def call(invoice:)
      InvoiceMailer.with(invoice:).created.deliver_later

      { ok: { success: true } }
    end
  end
end
