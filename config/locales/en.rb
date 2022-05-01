{
  en: {
    invoices: {
      create: {
        emails: {
          dynamic: -> key, options {
            case
            when options[:errors].key?(:invalid_format) then
              "Invalid format: #{options[:errors][:invalid_format].join(', ')}"
            end
          }
        }
      },
      update: {
        emails: {
          dynamic: -> key, options {
            case
            when options[:errors].key?(:invalid_format) then
              "Invalid format: #{options[:errors][:invalid_format].join(', ')}"
            end
          }
        }
      }
    }
  }
}