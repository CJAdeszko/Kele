require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post('/sessions', body: {
        email: email,
        password: password
    })

    if response && response['auth_token']
      @auth_token = response['auth_token']
      puts "#{email} was successfully logged in."
    else
      puts "Invalid email/password."
    end
  end


end
