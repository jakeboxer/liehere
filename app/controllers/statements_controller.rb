class StatementsController < ApplicationController
  def new
    @statement = Statement.new
  end
end
