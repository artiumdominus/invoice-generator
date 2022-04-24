class Invoice < ApplicationRecord
  belongs_to :user

  # after_save do
  #   InvoiceMailer.with(invoice: self).created.deliver_now
  # end
end
