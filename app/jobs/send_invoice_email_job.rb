class SendInvoiceEmailJob < ApplicationJob
  queue_as :default

  def perform(invoice:, emails: [])
    InvoiceMailer.with(invoice:, emails:).created.deliver_now
  end
end
