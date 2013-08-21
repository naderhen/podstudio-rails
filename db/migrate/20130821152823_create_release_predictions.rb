class CreateReleasePredictions < ActiveRecord::Migration
  def change
    create_table :release_predictions do |t|
      t.integer :podcast_id
      t.string :day
      t.integer :count
      t.float :percent

      t.timestamps
    end
  end
end
