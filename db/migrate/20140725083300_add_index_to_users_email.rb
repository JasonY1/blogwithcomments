## =>                                                             ##
# Index created to enforce uniqueness at database level in case of #
# duplication emails or multiple entries                           #
## =>                                                             ##  
class AddIndexToUsersEmail < ActiveRecord::Migration
  
  def change
    add_index :users, :email, unique: true      #testing uniqueness of user/emails
  end
end
