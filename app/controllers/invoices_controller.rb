class InvoicesController < ApplicationController
  before_action :authenticate!, except: :show

  before_action :set_invoice, only: %i[ edit update destroy ]

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

  def new = @invoice = Invoice::Changeset[]
  def edit; end

  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end

    # @invoice = Invoices::UseCases::Issue[user: current_user, invoice:]
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end

    #Invoices::UseCases::SendToMoreEmails[user: current_user, invoice:, emails:]
  end

  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def logout
    session.delete(:current_user_token)

    redirect_to(root_path)
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:number, :date, :customer_name, :customer_notes, :total_amount_due, :emails)
    end

    def id = params[:id]
    def filters = {}
end
