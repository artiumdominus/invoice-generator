class Invoice < ApplicationRecord
  belongs_to :user

  # after_save do
  #   InvoiceMailer.with(invoice: self).created.deliver_now
  # end

  # TODO: convert correctly.
  def total_amount_due =
    total_amount_due_cents ?
      "%d.%02d" % [total_amount_due_cents / 100, total_amount_due_cents % 100] : ""
end
