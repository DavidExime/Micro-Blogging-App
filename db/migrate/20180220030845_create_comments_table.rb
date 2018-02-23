
class CreateCommentsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :comments do |b|
  		b.string :message
  		b.integer :user_id
  		b.integer :blog_id
  	end	
  end
end
