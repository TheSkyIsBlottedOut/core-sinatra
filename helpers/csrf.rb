helpers do
  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end

  # Return the anti-CSRF token
  def csrf_token
    Rack::Csrf.csrf_token(env)
  end

  # Return the field name which will be looked for in the requests.
  def csrf_field
    Rack::Csrf.csrf_field
  end
end