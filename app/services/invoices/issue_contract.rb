module Invoices
  class IssueContract < ApplicationService
    def initialize = @errors = {}
    def error!(error) = @errors.merge!(error)

    def call(user:, invoice:)
      @user, @invoice = user, invoice
      @errors = {}

      validate_number
      validate_date
      validate_customer_name
      validate_total_amount_due
      validate_emails

      unless @errors.any?
        { ok: { user:, invoice: {
          number: @invoice[:number],
          date: @parsed_date,
          customer_name: @invoice[:customer_name],
          customer_notes: @invoice[:customer_notes],
          total_amount_due_cents: @total_amount_due_cents,
          emails: @emails
        } } }
      else
        { error: @errors }
      end
    end

    private

    def validate_number
      if Invoice.where(user: @user, number: @invoice[:number]).count > 0
        error!(number: :already_in_use)
      end
    end

    def validate_date
      parsed = Date.parse(@invoice[:date])
    rescue Date::Error
      error!(date: :invalid_format)
    else
      @parsed_date = parsed
    end

    def validate_customer_name
      if @invoice[:customer_name].empty?
        error!(customer_name: :empty)
      end
    end

    def validate_total_amount_due
      total = Float(@invoice[:total_amount_due])
    rescue ArgumentError
      error!(total_amount_due: :invalid_format)
    else
      @total_amount_due_cents = total * 100
    end

    def validate_emails
      @emails = @invoice[:emails].split(/[ ,;]/).reject(&:empty?)
      @emails.each do |email|
        unless email in URI::MailTo::EMAIL_REGEXP
          error!(emails: { invalid_format: [] }) unless @errors[:emails]
          @errors[:emails][:invalid_format] << email
        end
      end
    end
  end
end
