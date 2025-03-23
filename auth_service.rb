require 'digest'
require 'singleton'

class AuthService

  include Singleton


  @cookie_storage
  
  def initialize()
    @cookie_storage = {}

  end

  def generate_cookie()

    current_time = Time.new
    
    cookie = Digest::SHA256.hexdigest(current_time.to_i.to_s)

    cookie_expiration = (Time.new + (60 * 60 * 24 )).httpdate

    @cookie_storage[cookie] = current_time.to_i

    "name=" + cookie + "; Expires=" + cookie_expiration + "; HttpOnly"
        
  end

  def is_cookie_valid(cookies)

    @cookie_storage[cookies["name"]] != nil and !is_cookie_expired(@cookie_storage[cookies["name"]]) 

  end


  def is_cookie_expired(date)

    Time.new.to_i - date > 24 * 60 * 60
        
  end


  
end
