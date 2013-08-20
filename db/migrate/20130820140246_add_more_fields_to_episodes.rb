class AddMoreFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :duration, :string
    add_column :episodes, :explicit, :boolean
    add_column :episodes, :subtitle, :text
  end
end
