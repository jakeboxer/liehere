require 'spec_helper'

describe StatementsController do
  describe 'GET #new' do
    it 'responds successfully' do
      get :new
      expect(response).to be_success
    end
  end
end
