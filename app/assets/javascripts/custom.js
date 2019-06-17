function changeLockStore(eventClass, classAdd, classRemove, url) {
  $(document).on('click', eventClass, function(){
    storeId = $(this).attr('data');
    $(this).removeClass(classRemove);
    $(this).addClass(classAdd);
    $.ajax({
      url: url,
      type: "POST",
      dataType: "script",
      data: {"id": storeId},
    });
  });
}
changeLockStore('.lock-store', 'unlock-store fa-unlock store-close',
  'lock-store fa-lock store-open', '/admin/unlock-store');
changeLockStore('.unlock-store', 'lock-store fa-lock store-open',
  'unlock-store fa-unlock store-close', '/admin/lock-store');
