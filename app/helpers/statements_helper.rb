module StatementsHelper
  def new_statement_form_record
    @statement.user.present? ? [@statement.user, @statement] : @statement
  end
end
