class InvoiceMailer < ApplicationMailer
  def created
    @invoice = params[:invoice]
    emails = params[:emails].empty? ? @invoice.emails : params[:emails]

    attachments[@invoice.pdf_title] = WickedPdf.new.pdf_from_string(
      render_to_string(
        template: 'invoices/download',
        layout: 'pdf',
        locals: { invoice: @invoice },
        page_size: 'A4',
        orientation: 'Landscape',
        lowquality: true,
        zoom: 1,
        dpi: 75
      )
    )

    mail(to: emails, subject: "Invoice #{@invoice.id}")
  end
end
