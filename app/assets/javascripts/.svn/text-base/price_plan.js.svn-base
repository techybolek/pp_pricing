$(function() {
  $('#price-plan-selection-rule-set-tree').jstree({
    'plugins' : [ 'themes', 'html_data' ]
  });
  $('#price-plan-selection-rule-set-tree').jstree('open_all');
  $('#price-plan-selection-rule-set-tree').jstree('hide_icons');
  
  $('#price-plan-tree').jstree({
    'plugins' : [ 'themes', 'html_data' ]
  });
  $('#price-plan-tree').jstree('open_all');
  $('#price-plan-tree').jstree('hide_icons');
  
  $('a[data-role="tree-display"]').click(function(){
    $($(this).data('target')).children().hide();
    var query = '[id="' + $(this).data('source') + '"]';
    $(query).first().show();
    $('.jstree a[data-role="tree-display"].jstree-clicked').removeClass('jstree-clicked');
    $('.jstree a[data-role="tree-display"][data-source="' + $(this).data('source') + '"]').addClass('jstree-clicked');
  });
  
  $('#tree-container').resizable({ handles: 'e'} );
});