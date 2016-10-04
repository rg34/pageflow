module Pageflow
  module Admin
    module AdminUsersHelper
      def collection_for_admin_user_roles
        AdminUser.roles_accessible_by(current_ability).index_by { |role| t(role, :scope => 'pageflow.admin.admin_users.roles') }
      end

      def delete_own_user_section
        user_deletion_permission = Pageflow.config.authorize_user_deletion.call(current_pageflow_user)
        if user_deletion_permission == true
          render('pageflow/admin/admin_users/may_delete')
        else
          render('pageflow/admin/admin_users/cannot_delete', reason: user_deletion_permission)
        end
      end

      def current_pageflow_user
        send("current_#{Pageflow.config.user_class.underscore}") || NullUser.new
      end
    end
  end
end