class AddCacheCounters < ActiveRecord::Migration
  def self.up
    table = Pageflow.config.user_class.underscore.pluralize.to_sym

    add_column :pageflow_accounts, "#{table}_count".to_sym, :integer, default: 0, null: false
    add_column :pageflow_accounts, :entries_count, :integer, default: 0, null: false

    execute(<<-SQL)
      UPDATE pageflow_accounts SET #{table}_count = (
        SELECT COUNT(*)
        FROM #{table}
        WHERE #{table}.account_id = pageflow_accounts.id
      ), entries_count = (
        SELECT COUNT(*)
        FROM pageflow_entries
        WHERE pageflow_entries.account_id = pageflow_accounts.id
      );
    SQL
  end

  def self.down
    remove_column :pageflow_accounts, "#{table}"
    remove_column :pageflow_accounts, :entries_count
  end
end
