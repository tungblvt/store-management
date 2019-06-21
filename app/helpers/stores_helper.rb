module StoresHelper
  def get_statues_store
    Store.statuses.keys
  end

  def get_status_key_store store
    store.status
  end
end
