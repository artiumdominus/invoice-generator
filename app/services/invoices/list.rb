module Invoices
  class List < ApplicationService
    def call(user:, filters:)
      Invoice
        .where(user:)
        .to_a
    end
  end
end
