class RenameBirthdateToBirthDateInUsers < ActiveRecord::Migration[6.0] # or the version you are using
  def change
    rename_column :users, :birthdate, :birth_date
  end
end