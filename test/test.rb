require 'test/unit'
require_relative '../src/services/product_service'
require_relative '../src/services/auth_service'

class ProductsTest < Test::Unit::TestCase


  @product_service
  
  def setup
    
    @product_service = ProductService.instance
    
  end

  def test_process_product_should_not_add_product_immediately

    product = {"id" => 5, "name" => "Fridge" }

    storage = []

    @product_service.process_product(product, storage)

    assert(storage.length == 0, "storage has item")

  end


  def test_process_product_should_add_product_after_wait


    product = {"id" => 5, "name" => "Fridge" }

    storage = []

    @product_service.process_product(product, storage)

    sleep(6)

    assert(storage.length == 1, "storage has no item")

  end

  def test_should_be_valid_product

    product = {"id" => 5, "name" => "Fridge" }

    message = @product_service.validate_product(product)

    assert(message.empty? , "message not empty")
    
  end

  def test_should_be_invalid_product

    product = {"id" => nil, "name" => nil }

    message = @product_service.validate_product(product)
    
    assert(message == "Id must be a number. Name must be a not empty String." , "message not empty")
    
  end

  
end


class AuthTest < Test::Unit::TestCase


  @auth_service
  
  def setup
    
    @auth_service = AuthService.instance
    
  end

  def test_should_be_valid_account

    account = {"user" => "Ruby", "password" => "rubyrocks" }

    message = @auth_service.validate_account(account)

    assert(message.empty? , "message not empty")
    
  end

  def test_should_be_invalid_account

    account = {"user" => nil, "password" => "ruby" }

    message = @auth_service.validate_account(account)

    assert(message == "User must be a not empty String. Password must at least eight characters long." , "message not empty")
    
  end


end
