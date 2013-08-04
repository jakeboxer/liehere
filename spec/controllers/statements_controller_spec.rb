require 'spec_helper'

describe StatementsController do
  describe 'GET #new' do
    it 'responds successfully' do
      get :new
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context "when there's no user" do
      it "redirects to the new statement form" do
        post :create, :statement => {:text => 'irrelevant'}

        new_unfinished_user = User.last

        expect(response).to redirect_to(new_user_statement_url(new_unfinished_user))
      end

      it "creates a new user" do
        expect do
          post :create, :statement => {:text => 'irrelevant'}
        end.to change { User.count }.by(1)
      end

      it "creates a new statement" do
        expect do
          post :create, :statement => {:text => 'irrelevant'}
        end.to change { Statement.count }.by(1)
      end
    end
  end
end
