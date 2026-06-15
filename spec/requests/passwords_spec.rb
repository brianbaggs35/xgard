require 'rails_helper'

RSpec.describe PasswordsController, type: :request do
  describe 'GET /passwords/new' do
    it 'returns a successful response' do
      get new_password_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /passwords' do
    context 'when the email address exists' do
      let(:user) { create(:user) }

      it 'redirects to the login page' do
        post passwords_path, params: { email_address: user.email_address }
        expect(response).to redirect_to(new_session_path)
      end

      it 'queues a password reset email' do
        expect {
          post passwords_path, params: { email_address: user.email_address }
        }.to have_enqueued_mail(PasswordsMailer, :reset)
      end
    end

    context 'when the email address does not exist' do
      it 'still redirects to the login page' do
        post passwords_path, params: { email_address: 'nobody@example.com' }
        expect(response).to redirect_to(new_session_path)
      end

      it 'does not queue an email' do
        expect {
          post passwords_path, params: { email_address: 'nobody@example.com' }
        }.not_to have_enqueued_mail(PasswordsMailer, :reset)
      end
    end
  end

  describe 'GET /passwords/:token/edit' do
    context 'with a valid reset token' do
      let(:user) { create(:user) }

      it 'returns a successful response' do
        get edit_password_path(user.password_reset_token)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid token' do
      it 'redirects to the forgot password page' do
        get edit_password_path('invalidtoken')
        expect(response).to redirect_to(new_password_path)
      end
    end
  end

  describe 'PATCH /passwords/:token' do
    let(:user) { create(:user) }

    context 'when passwords match' do
      it 'redirects to the login page' do
        patch password_path(user.password_reset_token), params: {
          password: 'NewPassword123!',
          password_confirmation: 'NewPassword123!'
        }
        expect(response).to redirect_to(new_session_path)
      end

      it 'destroys all existing sessions for that user' do
        create(:session, user: user)
        patch password_path(user.password_reset_token), params: {
          password: 'NewPassword123!',
          password_confirmation: 'NewPassword123!'
        }
        expect(user.sessions.count).to eq(0)
      end
    end

context 'when passwords do not match' do
  it 'redirects back to the reset form' do
    token = user.password_reset_token

    patch password_path(token), params: {
      password: 'NewPassword123!',
      password_confirmation: 'WrongPassword!'
    }

    expect(response).to redirect_to(edit_password_path(token))
      end
    end
  end
end
