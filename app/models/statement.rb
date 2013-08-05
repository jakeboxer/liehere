class Statement < ActiveRecord::Base
  belongs_to :user

  validates :text, :presence => true
  validates :truth, :inclusion => { :in => [true, false] }

  # Public: Whether or not the statement is the truth.
  #
  # Returns a boolean.
  def truth?
    truth
  end
end
