module StoresHelper
  def get_statues_store
    Store.statuses.keys
  end

  def get_avatar_url image_name, user_id
    if image_name.nil?
      Settings.default_user_avatar_path
    else
      setting_url = Settings.user_avatar_path
      image_url = setting_url + user_id.to_s + "/" + image_name
    end
  end
end
