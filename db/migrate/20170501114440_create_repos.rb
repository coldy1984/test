class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.string :token
      t.string :name
      t.string :author

      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
