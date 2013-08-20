class AddLastBuildDateToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :last_build_date, :datetime
  end
end
