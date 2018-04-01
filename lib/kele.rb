require 'httparty'
require 'json'
require_relative './roadmap.rb'

class Kele
  include HTTParty
  include Roadmap

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


  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end


  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

end
