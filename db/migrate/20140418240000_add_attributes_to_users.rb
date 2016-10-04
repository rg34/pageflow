class AddAttributesToUsers < ActiveRecord::Migration

  def up
    table = Pageflow.config.user_class.underscore.pluralize.to_sym

    add_column table, :failed_attempts, :integer, default: 0 unless ActiveRecord::Base.connection.column_exists?(table, :failed_attempts)
    add_column table, :locked_at, :datetime unless ActiveRecord::Base.connection.column_exists?(table, :locked_at)

    add_column table, :first_name, :string unless ActiveRecord::Base.connection.column_exists?(table, :first_name)
    add_column table, :last_name, :string unless ActiveRecord::Base.connection.column_exists?(table, :last_name)
    add_column table, :suspended_at, :datetime
    add_column table, :account_id, :integer
    add_column table, :role, :string, default: "editor", null: false

    add_index table, [:account_id], name: "index_pageflow_#{table}_on_account_id", using: :btree
    add_index table, [:email], name: "index_pageflow_#{table}_on_email", unique: true, using: :btree
  end
  
  def down
    table = Pageflow.config.user_class.underscore.pluralize.to_sym

    remove_column table, :failed_attempts, :integer if ActiveRecord::Base.connection.column_exists?(table, :failed_attempts)
    remove_column table, :locked_at, :datetime if ActiveRecord::Base.connection.column_exists?(table, :datetime)
    remove_column table, :first_name, :string if ActiveRecord::Base.connection.column_exists?(table, :first_name)
    remove_column table, :last_name, :string if ActiveRecord::Base.connection.column_exists?(table, :last_name)
    remove_column table, :account_id, :integer
    remove_column table, :role, :string, default: "editor", null: false

    remove_index table, name: "index_pageflow_#{table}_on_account_id"
    remove_index table, name: "index_pageflow_#{table}_on_email"
  end
end
