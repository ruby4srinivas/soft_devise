class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks

  def soft_user?

    self.email.empty?
  end
  def needs_engagement?

    tasks = Task.where(soft_token: self.soft_token)
    self.soft_user? && tasks.count >= 2

  end
end