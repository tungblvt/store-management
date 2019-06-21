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

$(document).on('click', '.rating .fa-star', function(){
  let rate = $(this).attr('data-rate');
  let star_dom = $('.rating .fa-star')
  star_dom.removeClass('active');
  for (let i = 0; i < rate; i++ ) {
    star_dom.eq(i).addClass('active');
  }

  $(this).parent().find('#comment_rate').val(rate);
});
