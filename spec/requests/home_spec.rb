require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    context 'when not logged in' do
      it 'redirects to the login page' do
        get root_path
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when logged in' do
      let(:user) { create(:user) }

      before { log_in_as(user) }

      it 'returns a successful response' do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
