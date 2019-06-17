module UsersHelper
  def get_roles
    User.roles
  end

  def get_role_key user
    get_roles[user.role]
  end
end
