class StatementsController < ApplicationController
  def create
    if session[:unfinished_user_id].present?
      @unfinished_user = User.find(session[:unfinished_user_id])
    else
      @unfinished_user = User.create!
      session[:unfinished_user_id] = @unfinished_user.id
    end

    @statement = Statement.new(statement_params)
    @statement.user = @unfinished_user

    if @statement.save
      flash[:notice] = "cool story"
      redirect_to new_user_statement_path(@unfinished_user)
    else
      flash.now[:error] = "something wrong with that statement"
      render :new
    end
  end

  def new
    @statement = Statement.new
  end

  private

  def statement_params
    params.require(:statement).permit(:text)
  end
end
