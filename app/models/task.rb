class Task < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title
  default_scope { order('completed ASC, created_at DESC')  } 
end
