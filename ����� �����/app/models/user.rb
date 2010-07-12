class User < ActiveRecord::Base
		has_many :forums
		has_many :topics
		has_many :messages
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  validates_presence_of :name, :email, :password, :password_confirmation
  
  validates_format_of :email, :with => %r{([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,4}$)}i,
										:message => 'Wrong email'  
  validates_length_of :password, :in => 4..20, :message => 'Password must be from 4 to 20 symbols'

  
  devise :registerable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validateable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation
  protected
  def validate
	errors.add(:password_confirmation, "Password not confirmed") if !(password.eql?(password_confirmation))
	errors.add(:name, "This name is exists") if !(User.find(:first, :conditions=> ['name= ?', name]).nil?)
	errors.add(:email, "This email is exists") if !(User.find(:first, :conditions=> ['email= ?', email]).nil?)
  end

end
