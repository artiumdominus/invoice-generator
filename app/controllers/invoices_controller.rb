class InvoicesController < ApplicationController
  before_action :authenticate!, except: %i(show not_found)
  before_action :authenticate, only: :show

  def index = @invoices = Invoices::List[user: current_user]
  # TODO: implement filters & pagination

  def show
    case Invoices::Find[id:]
    in { ok: { invoice: } }
      @invoice = invoice
    in { error: :invoice_not_found }
      redirect_to not_found_invoices_path
    end
  end

  def new = @invoice = Invoices::Changeset[]

  def create
    case Invoices::UseCases::Issue[user: current_user, invoice:]
    in { ok: { invoice: } }
      redirect_to invoice_url(invoice), notice: "Invoice was successfully issued."
    in { error: errors }
      @invoice = Invoices::Changeset[invoice: @invoice]
      @errors = errors
      render :new, status: :unprocessable_entity
    end
  end
  # TODO: deal deeper errors

  def edit
    case Invoices::FindOfUser[user: current_user, id:]
    in { ok: { invoice: } }
      @invoice = invoice
    in { error: :invoice_not_found }
      redirect_to not_found_invoices_path
    end
  end

  def update
    case Invoices::UseCases::SendToMoreEmails[user: current_user, id:, emails:]
    in { ok: }
      redirect_to edit_invoice_path, { notice: "Invoice sent to the new emails" }
    in { error: :invoice_of_user_not_found }
      redirect_to not_found_invoices_path
    in { error: errors }
      case Invoices::FindOfUser[user: current_user, id:]
      in { ok: { invoice: } }
        @invoice = invoice
        @emails = emails
        @errors = errors
        render :edit, status: :unprocessable_entity
      in { error: :invoice_not_found } 
        redirect_to not_found_invoices_path
      end
    end
  end
  # TODO: deal deeper errors

  def download
    case Invoices::Find[id:]
    in { ok: { invoice: } }
      @invoice = invoice

      render pdf: @invoice.pdf_title,
        page_size: 'A4',
        layout: "pdf",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
    in { error: }
      # TODO: deal error
    end
  end

  def not_found; end

  private

    def id = params[:id]
    def filters = {}

    def invoice
      @invoice ||= params
        .require(:invoice)
        .permit(
          :number,
          :date,
          :customer_name,
          :customer_notes,
          :total_amount_due,
          :emails
        )
    end

    def emails = params[:emails]
end
