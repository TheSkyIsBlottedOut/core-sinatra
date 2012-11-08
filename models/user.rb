class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email,       type: String
  field :username,    type: String
end