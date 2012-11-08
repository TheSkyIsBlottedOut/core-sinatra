class String
  
  def camelcase
    self.capitalize.gsub(/_(\w)/) {|s| s[1].upcase}
  end
  
  def snake_case!
    self.gsub(/::/, '/').
          gsub(/([^_A-Z])([A-Z])/, '\1_\2').downcase
  end
  
  def snake_case
    self.clone.snake_case!
  end
end