module Pageflow
  module QuotaHelper
    def quota_state_description(name, account)
      description = Pageflow.config.quotas.get(Pageflow.config.user_class.underscore.pluralize.to_sym, @user.account).state_description

      if description
        content_tag(:p, description, :class => 'quota_state')
      end
    end
  end
end
