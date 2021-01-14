module OmniAuthSupport
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] =
    OmniAuth::AuthHash.new({
                             provider: 'google_oauth2',
                             uid: '000000',
                             info: { email: 'test@example.com' },
                             credentials: { token: 'google_oauth2_test' }
                           })
end
