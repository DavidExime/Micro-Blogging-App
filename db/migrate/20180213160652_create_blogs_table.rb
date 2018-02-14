class CreateBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :blogs do |t|
  		t.string :title
  		t.string :category
  		t.string :content
  
  	end
  end
end
