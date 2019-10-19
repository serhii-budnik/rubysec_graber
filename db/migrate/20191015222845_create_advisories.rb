class CreateAdvisories < ActiveRecord::Migration[6.0]
  def change
    create_table :advisories do |t|
      enable_extension 'hstore'

      t.string :identifier, unique: true, index: true
      t.string :gem
      t.string :cve
      t.string :osvdb
      t.string :cvss_v2
      t.string :cvss_v3
      t.string :url
      t.string :title
      t.date :date
      t.text :description
      t.hstore :related, :default => {}
      t.text :unaffected_versions, array: true, default: []
      t.text :patched_versions, array: true, default: []
      t.timestamps null: false
    end
  end
end
