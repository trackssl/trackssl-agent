class AddDomains < ActiveRecord::Migration[7.1]
  def change
    create_table :domains do |t|
      t.bigint :domain_id, null: false
      t.string :hostname, null: false
      t.string :port, null: false, default: '443'
      t.text :certificate
      t.timestamps
    end
  end
end
