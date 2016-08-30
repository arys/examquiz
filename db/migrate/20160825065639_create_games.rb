class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string   :creater
      t.string   :opponent
      t.integer  :questions
      t.integer  :creater_scores
      t.integer  :opponent_scores
      t.boolean  :status

      t.timestamps null: false
    end
  end
end
