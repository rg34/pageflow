module Pageflow
  module Admin
    class EntryUserBadgeList < ViewComponent
      builder_method :entry_user_badge_list

      def build(entry)
        ul class: 'badge_list' do
          entry.memberships.each do |membership|
            build_badge(membership)
          end
        end
      end

      private

      def build_badge(membership)
        li do
          span(user_initials(membership.user), class: 'abbreviation')
          div class: 'tooltip' do
            role_string =
              " (#{I18n.t(membership.role, scope: 'activerecord.values.pageflow/membership.role')})"
            if authorized?(:read, membership.user)
              link_to(membership.user.full_name, send("admin_#{Pageflow.config.user_class.underscore}_path", membership.user)) + role_string
            else
              span class: 'name' do
                membership.user.full_name + role_string
              end
            end
          end
        end
      end

      def user_initials(user)
        user.first_name[0] + user.last_name[0]
      end
    end
  end
end
