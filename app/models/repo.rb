class Repo < ActiveRecord::Base
  belongs_to :user

  validates :token, :author, :name, :user, presence: true

  def full_name
    "#{author}/#{name}"
  end
end
