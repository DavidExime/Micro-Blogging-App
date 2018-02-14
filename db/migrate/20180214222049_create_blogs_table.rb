class CreateBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :blogs do |b|
  		b.string :title
  		b.string :content
  		b.integer :user_id
  	end
  end
end
