class Api::V1::BooksController < ApplicationController
  authorize_resource

  def show
    book = Book.find(params[:id])
    render json: { data: book }
  end
end
