class StatementsController < ApplicationController
  before_filter :load_unfinished_user

  def create
    unless @unfinished_user
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
    @statement      = Statement.new
    @statement.user = @unfinished_user

    statements = @unfinished_user ? @unfinished_user.statements : []

    # Figure out what type of statement we're creating
    @new_statement_type = if statements.present?
      # If the user has statements but they're all truths, the next statement
      # should be a lie. If at least one statement is a lie, let the user do
      # either type.
      statements.all? {|s| s.truth? } ? :lie : :either
    else
      # If there's no user or the user has no statements, the first statement
      # should be truth.
      :truth
    end

    # Set the statement's truth value if we know already
    unless @new_statement_type == :either
      @statement.truth = (@new_statement_type == :truth)
    end
  end

  private

  def statement_params
    params.require(:statement).permit(:text, :truth)
  end

  def load_unfinished_user
    if session[:unfinished_user_id].present?
      @unfinished_user = User.find(session[:unfinished_user_id])
    end
  end
end
