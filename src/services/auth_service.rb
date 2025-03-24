require 'digest'
require 'singleton'

class AuthService

  include Singleton

  @@cookie_storage = {}
  SALT = "!@3$%^&*"
  @@auth_storage = {}
  
  def initialize

    @@auth_storage["fudo"] = "73f6be7fda82b31e15c93b18b610878e4e62ed7a0c8d8cf6b766019c95a320aa" 

  end

  def generate_cookie

    current_time = Time.new
    
    cookie = Digest::SHA256.hexdigest(current_time.to_i.to_s)

    cookie_expiration = (Time.new + (60 * 60 * 24 )).httpdate

    @@cookie_storage[cookie] = current_time.to_i

    "name=" + cookie + "; Expires=" + cookie_expiration + "; HttpOnly"
        
  end

  def signin(account)

    validation_message = validate_account(account) ;

    unless validation_message.empty? ; return validation_message end

    @@auth_storage[account["user"]]= Digest::SHA256.hexdigest(account["password"] + SALT)

    return ""

  end

  def validate_account(account)

    error_message = ""

    user = account["user"]
    password = account["password"]

    
    if !user.is_a?(String) || user.empty? ; error_message += "User must be a not empty String. " end
    if !password.is_a?(String) || password.empty? ; error_message += "Password must be a not empty String. " end
    if password.is_a?(String) && password.length < 8 ; error_message += "Password must at least eight characters long. " end

    error_message

  end

  def login(user, password)

    # puts user
    # puts password

    # puts @@auth_storage[user]
    # puts Digest::SHA256.hexdigest(password + SALT)

    check = @@auth_storage[user] == Digest::SHA256.hexdigest(password + SALT)

    unless check ; return nil end

    generate_cookie()

  end

  def is_cookie_valid(cookies)

    @@cookie_storage[cookies["name"]] != nil and !is_cookie_expired(@@cookie_storage[cookies["name"]]) 

  end


  def is_cookie_expired(date)

    Time.new.to_i - date > 24 * 60 * 60
        
  end


  
end
