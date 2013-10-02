require_relative './collection'
require_relative './user_notification'

module Trubl
  class UserNotifications < Collection

  	def klass_name
  		"user_notifications"
  	end
  end

end