class AddLocaleToUsers < ActiveRecord::Migration
  def change
    table = Pageflow.config.user_class.underscore.pluralize.to_sym
    add_column table, :locale, :string
  end
end
