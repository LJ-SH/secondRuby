module AdminUserHelper
	def translated_role(user)
		I18n.t "role.#{user.role}"
	end	
end