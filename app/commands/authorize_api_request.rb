# frozen_string_literal: true

class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    # console.log("decode",@decoded_auth_token)
  end

  def http_auth_header
    if headers['Authorization'].present?
      # console.log("header",headers['Authorization'])
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end

    nil
  end
end
