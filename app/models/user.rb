class User < ActiveRecord::Base
  has_many :statements
end
