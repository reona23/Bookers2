class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      ##本のタイトル
      t.string :title

      ##本の感想
      t.text :body

      ##ユーザーの識別のためにカラム
      t.integer :user_id

      t.timestamps
    end
  end
end
