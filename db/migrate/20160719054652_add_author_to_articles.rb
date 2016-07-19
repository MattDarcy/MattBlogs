class AddAuthorToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :author_id, :fixnum
  end
end
