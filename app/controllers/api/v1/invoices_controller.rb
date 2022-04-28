module Api::V1
  class InvoicesController < ActionController::API
    # TODO: API auth
    # TODO: document API

    def index
      render json: Invoices::List[user: current_user, filters:]
    end
    # TODO: implement filters

    def show
      render json: Invoices::Find[id:]
    end

    def create
      render json: Invoices::UseCases::Issue[user: current_user, invoice:]
    end

    def update
      render json: Invoices::UseCases::SendToMoreEmails[user: current_user, id:, emails:]
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

      def emails = params[:emails]
  end
end
