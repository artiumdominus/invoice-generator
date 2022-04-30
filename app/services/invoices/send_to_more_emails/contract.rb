module Invoices::SendToMoreEmails
  class Contract < ApplicationService
    def initialize = @errors = {}
    def error!(error) = @errors.merge!(error)

    def call(user:, id:, emails:)
      @emails = emails

      validate_emails

      unless @errors.any?
        { ok: { user:, id:, emails: @parsed_emails } }
      else
        { error: @errors }
      end
    end

    def validate_emails
      if @emails.blank?
        error!(emails: :required)
      else
        @parsed_emails = @emails.split(/[ ,;]/).reject(&:empty?)
        @parsed_emails.each do |email|
          unless email in URI::MailTo::EMAIL_REGEXP
            error!(emails: { invalid_format: [] }) unless @errors[:emails]
            @errors[:emails][:invalid_format] << email
          end
        end
      end
    end
  end
end
