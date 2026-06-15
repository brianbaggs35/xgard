require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'GET /session/new' do
    it 'returns a successful response' do
      get new_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /session' do
    context 'with valid credentials' do
      let(:user) { create(:user) }

      it 'redirects to the root path after login' do
        log_in_as(user)
        expect(response).to redirect_to(root_path)
      end

      it 'creates a session record in the database' do
        expect { log_in_as(user) }.to change(Session, :count).by(1)
      end
    end

    context 'with an invalid password' do
      let(:user) { create(:user) }

      it 'redirects back to the login page' do
        log_in_as(user, password: 'wrongpassword')
        expect(response).to redirect_to(new_session_path)
      end

      it 'does not create a session record' do
        expect { log_in_as(user, password: 'wrongpassword') }.not_to change(Session, :count)
      end
    end

    context 'with a non-existent email address' do
      it 'redirects back to the login page' do
        post session_path, params: {
          email_address: 'nobody@example.com',
          password: 'Password123!'
        }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'DELETE /session' do
    let(:user) { create(:user) }

    before { log_in_as(user) }

    it 'redirects to the login page after logout' do
      delete session_path
      expect(response).to redirect_to(new_session_path)
    end

    it 'removes the session record from the database' do
      expect { delete session_path }.to change(Session, :count).by(-1)
    end
  end
end
