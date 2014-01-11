$(function() {
  $('#avaliable_usage_modes, #selected_usage_modes').sortable({
    connectWith: '.connectedSortable',
    dropOnEmpty: true
  });
  
  $('#usage-mode-container').disableSelection();
  
  $('#avaliable_usage_modes').on('sortreceive', function(e, ui){
    $(ui.item).first('input').attr('name', 'service[avaliable_usage_modes][]');
  });
  
  $('#selected_usage_modes').on('sortreceive', function(e, ui){
    $(ui.item).first('input').attr('name', 'service[selected_usage_modes][]');
  });
});