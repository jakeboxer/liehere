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
      flash.now[:error]   = "something wrong with that statement"
      @new_statement_type = next_statement_type_for(@statement.user)

      render :new
    end
  end

  def new
    @new_statement_type = next_statement_type_for(@unfinished_user)

    @statement       = Statement.new
    @statement.user  = @unfinished_user
    @statement.truth = statement_truth_for(@new_statement_type)
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

  # Internal: Get next statement type for the specified user.
  #
  # user - User to get the statement type for. Should be either a User or nil.
  #
  # Returns a Symbol (:truth, :lie, or :either).
  def next_statement_type_for(user)
    statements = user ? user.statements : []

    # Figure out what type of statement we're creating
    type = if statements.present?
      # If the user has statements but they're all truths, the next statement
      # should be a lie. If at least one statement is a lie, let the user do
      # either type.
      statements.all? {|s| s.truth? } ? :lie : :either
    else
      # If there's no user or the user has no statements, the first statement
      # should be truth.
      :truth
    end

    type
  end

  # Internal: Get the truth value for the specified statement type.
  #
  # type - Statement type to get the truth value for. This should always be
  #        :truth, :lie, or :either
  #
  # Returns a boolean.
  def statement_truth_for(type)
    [:truth, :either].include?(type)
  end
end
