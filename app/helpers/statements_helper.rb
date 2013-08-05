module StatementsHelper
  def new_statement_form_record
    defined?(@unfinished_user) ? [@unfinished_user, @statement] : @statement
  end
end
