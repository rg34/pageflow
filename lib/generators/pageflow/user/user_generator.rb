require 'rails/generators'

module Pageflow
  module Generators
    class UserGenerator < Rails::Generators::Base
      desc "Injects the Pageflow::User mixin into the specified user class."
      argument :user_type, :type => :string, :default => "User"

      def include_mixin
        inject_into_file "app/models/#{file_name}.rb", after: /ActiveRecord::Base$/ do
          "\n  include Pageflow::UserMixin\n"
        end
      end

      private
      def file_name
        user_type.underscore
      end
    end
  end
end
