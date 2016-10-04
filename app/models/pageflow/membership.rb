module Pageflow
  class Membership < ActiveRecord::Base
    belongs_to :user, class_name: Pageflow.config.user_class, foreign_key: :user_id
    belongs_to :entry

    validates :user, :entry, :presence => true
    validates :entry_id, :uniqueness => { :scope => :user_id }
  end
end
