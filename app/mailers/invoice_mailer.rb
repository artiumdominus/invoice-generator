class InvoiceMailer < ApplicationMailer
  def created
    @invoice = params[:invoice]

    emails = @invoice.emails

    mail(to: emails, subject: "Invoice #{@invoice.id}")
  end
end
