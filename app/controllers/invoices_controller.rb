class InvoicesController < ApplicationController
  before_action :authenticate!, except: :show
  before_action :authenticate, only: :show

  def index = @invoices = Invoices::List[user: current_user, filters:]
  # TODO: implement filters

  def show
    case Invoices::Find[id:]
    in { ok: { invoice: } }
      @invoice = invoice
    in { error: :invoice_not_found }
      # TODO: deal :invoice_not_found -> redirect 404
    end
  end

  def new = @invoice = Invoices::Changeset[]

  def create
    # @invoice = Invoices::UseCases::Issue[user: current_user, invoice:]
    case Invoices::UseCases::Issue[user: current_user, invoice:]
    in { ok: { invoice: } }
      redirect_to invoice_url(invoice), notice: "Invoice was successfully issued."
    in { error: }
      # TODO: deal errors
    end

    # @invoice = Invoice.new(invoice_params)

    # respond_to do |format|
    #   if @invoice.save
    #     format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
    #     format.json { render :show, status: :created, location: @invoice }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @invoice.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def edit
    case Invoices::Find[id:]
    in { ok: { invoice: } }
      @invoice = invoice
    in { error: :invoice_not_found }
      # TODO: deal :invoice_not_found -> redirect 404
    end
  end

  def update
    #Invoices::UseCases::SendToMoreEmails[user: current_user, invoice:, emails:]

    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    case Invoices::Find[id:]
    in { ok: { invoice: } }
      @invoice = invoice

      render pdf: "Invoice No. #{@invoice.id}",
        page_size: 'A4',
        # template: "invoices/download.html.erb",
        layout: "pdf",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
    in { error: }
      # TODO: deal error
    end
  end

  private

    def id = params[:id]
    def filters = {}

    def invoice
      params
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
end
