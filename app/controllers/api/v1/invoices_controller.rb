module Api::V1
  class InvoicesController < Api::ApplicationController
    before_action :authenticate!
    # TODO: document API rswag

    def index
      render json: Invoices::List[user: current_user]
    end
    # TODO: implement filters & pagination

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
        {
          number: params[:number],
          date: params[:date],
          customer_name: params[:customer_name],
          customer_notes: params[:customer_notes],
          total_amount_due: params[:total_amount_due],
          emails: params[:emails]
        }
      end

      def emails = params[:emails]
  end
end
