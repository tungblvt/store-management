module UsersHelper
  def get_roles
    User.roles.keys
  end

  def get_role_key user
    user.role
  end
end
