function displayZone(target) {
  $('table[data-type="zonal-component"]').addClass('hide');
  $('#' + target).removeClass('hide');
}

$(function() {
  $('#tariff-zones > tbody > tr').on('click', function() {
    var row = $(this);
    if(row.attr('class') !== 'info') {
      row.parent().children('tr').removeClass('info');
      row.addClass('info');
      displayZone(row.data('target'));
    }
  });
});