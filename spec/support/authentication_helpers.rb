module AuthenticationHelpers
  def log_in_as(user, password: 'Password123!')
    post session_path, params: {
      email_address: user.email_address,
      password: password
    }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end
