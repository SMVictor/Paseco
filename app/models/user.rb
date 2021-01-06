class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum role: [:"admin", :"supervisor", :"employee", :"human_resources", :"sup_hr", :"psychologist"]

  has_and_belongs_to_many :stalls, join_table: :stalls_users

end
