# name.string
# password_digest:string
#
# password:string virtual
# password_confirmation:string virtual

class User < ApplicationRecord
  has_secure_password
  has_one :finanzwerte
  validates :name, presence: true
end
