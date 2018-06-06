class Change < ActiveRecord::Migration[5.1]
  def change
    change_column :blocks, :start_date, :date
    change_column :blocks, :end_date, :date
    change_column :shifts, :date, :date
    change_column :vac_reqs, :end_date, :date
    change_column :vac_reqs, :start_date, :date
  end
end
