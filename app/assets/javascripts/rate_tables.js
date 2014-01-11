var newRows = 0;
var deleteRows = [];
var maxTabIndex = 0;

function deleteRateRow(row){
  if(row.data('row') !== 'new'){
    // Row is saved, append ID to array of delete rows to push to server
    deleteRows.push(row.data('row'));
    row.addClass('deleted_row');
    row.find('a[data-name]').editable('destroy');
  } else {
    row.remove();
  }
}

$(function() {
  maxTabIndex = $('[tabindex]').length;
  
  $('#rate-table').filterable({
    ignoreColumns: [0]
  });
  
  $('select[data-type="select2"]').select2();
  $('a[data-role="editable"]').editable({
    send: 'never'
  });
  
  // Enter Key on editable field opens edit
  $('#full-content').on('keypress','a[data-role="editable"]', function(e){
    var code = (e.keyCode ? e.keyCode : e.which);
    if(code === 13) { //Enter keycode
      $(this).editable('toggle');
    }
  });
  
  // Force focus on element on x-editable close to allow tabbing through
  $('#rate-table').on('hidden', 'a[data-role="editable"]', function(){
    $(this).focus();
  });
  
  // Save the rate table when Ctrl+S is pressed
  $('#rate-table').on('keydown', function(e){
    var code = (e.keyCode ? e.keyCode : e.which);
    if(code === 83 && e.ctrlKey) { //Ctrl + S
      e.preventDefault();
      $('#save-rate-table').click();// Save changes
    }
  });
  
  // Reset the rate table when Ctrl+Z is pressed
  $('#rate-table').on('keydown', function(e){
    var code = (e.keyCode ? e.keyCode : e.which);
    if(code === 90 && e.ctrlKey) { //Ctrl + Z
      e.preventDefault();
      $('[data-role="reset-rate-table"]').click();// Reset changes
    }
  });
  
  // Add New Row Button
  $('button[data-role="add-row"]').click(function(){
    var newRow = $('#rate-table > tbody > tr:last').clone();
    newRows++;
    $(newRow).find('a[data-name]').each(function(index, ele){
      
      $(ele).addClass('editable-unsaved');
      
      //Fix tabindex
      maxTabIndex++;
      $(ele).attr('tabindex', maxTabIndex);
      
      //Clear 'Empty' values
      if($.trim($(ele).text()) === 'Empty'){
        $(ele).text('');
      }
      
      //Set input names of new row
      var newName = 'new_rows[' + newRows + ']' + $(ele).data('name');
      $(ele).attr('data-name', newName);
      $(ele).data('name', newName);
    });
    newRow.removeClass('hidden');
    newRow.data('row', 'new');
    newRow.attr('data-row', 'new');
    newRow.insertBefore('#rate-table > tbody > tr:last');
    $(newRow).find('a[data-role="editable"]').editable({
      send: 'never'
    });
  });
  
  // Save Button
  $('#save-rate-table').click(function(){
    var url = $(this).data('url');
    $('#rates-loading').show();
    $('a.editable-unsaved[data-role="editable"]').editable('submit',{
      url: url,
      ajaxOptions: {
        dataType: 'json' //assuming json response
      },
      data: {'delete_rows': deleteRows},
      success: function(data) {
        $('#rates-loading').hide();
        $(this).removeClass('editable-unsaved');
        // Set the IDs on the row rows to the new IDs
        $.each(data.newIds, function(k, v) {
          $('a[data-name^="new_rows['+ k + ']"]').each(function(index, ele){
            $(ele).closest('tr').data('row', v);
            $(ele).closest('tr').attr('data-row', v);
            var newName = $(ele).data('name');
            newName = newName.replace('new_rows['+ k + ']', 'existing_rows[' + v + ']');
            $(ele).attr('data-name', newName);
            $(ele).data('name', newName);
            $(ele).editable('option', 'name', newName);
          });
        });
        
        $('#script-error, #script-notice, #script-alert').hide();
        
        $('a[data-role="editable"]').each(function(index, ele){
          var newValue = $(ele).editable('getValue');
          newValue = newValue[$(ele).data('name')];
          $(ele).attr('data-saved-value', newValue);
          $(ele).data('saved-value', newValue);
        });
        
        // Remove the deleted rows
        $('.deleted_row[data-row]').remove();
        deleteRows = [];
        alertify.log('Save successful', 'success', '2000');
      },
      error: function(errors) {
        $('#rates-loading').hide();
        var msg = '';
        if(errors.status !== 500){
          $.each($.parseJSON(errors.responseText), function(k, v) { msg += k+': '+v+'<br />'; });
        } else {
          msg = errors.statusText;// There was a server error, we can't trust the return data
        }
        showError(msg);
        alertify.log('Save failed, see error(s) above', 'error');
      }
    });
  });
  
  // Delete Row
  $('#rate-table').on('click','[data-role="delete-rate-row"]', function(){
    var row = $(this).closest('tr');
    deleteRateRow(row);
  });
  
  // Delete Selected Row
  $('button[data-role="delete-selected-rates"]').click(function(){
    var checked = $('input[type="checkbox"][name="rows[]"]').filter(':checked').filter(':visible').closest('tr');
    checked.each(function(checkIndex, checkedRow){
      deleteRateRow($(checkedRow));
    });
  });
  
  // Copy Row
  $('#rate-table').on('click','[data-role="copy-rate-row"]', function(){
    var row = $(this).closest('tr').clone();
    $(row).data('row', 'new');
    $(row).attr('data-row', 'new');
    newRows++;
    
    $(row).find('a[data-name]').each(function(index, ele){
      $(ele).addClass('editable-unsaved');
      
      //Fix tabindex
      maxTabIndex++;
      $(ele).attr('tabindex', maxTabIndex);
      
      //Clear 'Empty' values
      var value = $.trim($(ele).text());
      if(value === 'Empty'){
        $(ele).text('');
      }
      
      //Set input names of new row
      var name = $(ele).data('name');
      name = 'new_rows[' + newRows + ']' + name.substring(name.lastIndexOf('['), name.length);
      $(ele).attr('data-name', name);
      $(ele).data('name', name);
    });
    
    $(this).closest('tr').after(row);
    
    $(row).find('a[data-role="editable"]').editable({
      send: 'never'
    });
  });
  
  // Cancel Changes
  $('[data-role="reset-rate-table"]').click(function(){
    // Remove New Rows
    $('[data-row="new"]').remove();
    
    // Reset Values
    $('.editable-unsaved').each(function(index, ele){
      var oldValue = $(ele).data('saved-value');
      if($(ele).data('type') === 'date'){
        oldValue = new Date(oldValue);
      }
      $(ele).editable('setValue', oldValue );
      $(ele).removeClass('editable-unsaved');
      if(oldValue === '' || oldValue === null || oldValue === undefined ){
        $(ele).addClass('editable-empty');
      }
    });
    
    // Add back deleted rows
    $('.deleted_row').each(function(index, ele){
      $(ele).removeClass('deleted_row');
      $(ele).find('a[data-role="editable"]').editable({
        send: 'never'
      });
    });
    deleteRows = [];
  });
  
  // Edit Selected rows
  $('button[data-role="edit-selected-rates"]').click(function(){
    var editables = $('#edit-rate-rows').find('a[data-role="editable"]');
    editables.removeClass('editable-unsaved');
    editables.editable('setValue', '');
    $('#edit-rate-rows').modal();
  });
  
  // Make mass-edit changes
  $('#save-selected-changes').click(function(){
    var checked = $('input[type="checkbox"][name="rows[]"]').filter(':checked').filter(':visible').closest('tr');
    var newValues = $('#edit-rate-rows').find('a.editable-unsaved[data-role="editable"]');
    var newValue = '';
    var oldElement;
    newValues.each(function(valuesIndex, newElement){
      newValue = $(newElement).editable('getValue');
      newValue = newValue[$(newElement).data('name')];
      checked.each(function(checkIndex, checkedRow){
        oldElement = $(checkedRow).find('a[data-name$="' + $(newElement).data('name') + '"]');
        oldElement.editable('setValue', newValue);
        oldElement.addClass('editable-unsaved');
      });
    });
    
    $('#edit-rate-rows').modal('hide');
  });
});
