module Api::V1
  class InvoicesController < ActionController::API
    def index
      render json: [{ data: "test" }]
    end

    def show
      render json: { data: "test" }
    end

    def create
      render json: { data: "test" }
    end

    def update
      render json: { data: "test" }
    end

    def destroy
      render json: { data: "test" }
    end
  end
end