module Pageflow
  ActiveAdmin.register Membership, :as => 'Membership' do
    menu false

    actions :new, :create, :destroy

    form :partial => 'form'

    controller do
      belongs_to :entry, :parent_class => Pageflow::Entry, :polymorphic => true
      belongs_to :user, :parent_class => Pageflow.config.user_class, :polymorphic => true, class_name: Pageflow.config.user_class

      helper Pageflow::Admin::MembershipsHelper
      helper Pageflow::Admin::FormHelper

      def permitted_params
        params.permit(:membership => [:user_id, :entry_id])
      end
    end
  end
end
