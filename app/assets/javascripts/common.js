$(function() {

  // Enable datepickers
  $('input[data-role="datepicker"]').bdatepicker({
    autoclose: true
  });

  // Button to clear form inputs
  $('[data-role="clear-form"]').click(function(){
    var form = $(this).closest('form');
    form.find('input').val('');
    form.find('select').each(function() {
      $(this)[0].selectedIndex = 0;
    });
    $(form).submit();
  });
  
  // Change amount of items for pagination
  $('select[data-role="pagination-amount"]').change(function(){
    $(this).closest('form').submit();
  });
  
  // Multi Select Widget
  $('select[multiple]').select2();
  
  // Hide parent button
  $('button[data-role="hide-parent"]').click(function(){
    $(this).parent().hide();
  });
  
  // Checkall checkbox
  $('input[type="checkbox"][data-role="checkall"]').click(function(){
    var name = $(this).data('check-name');
    $('input[type="checkbox"][name="' + name + '"]').filter(':visible').prop('checked', this.checked);
  });
  
  // Adds better functionality to select elements (select2)
  $('select[data-role="select2"]').select2({
    minimumResultsForSearch: 10,
    allowClear: true
  });
  
  // Shows popover box on hover
  $('i[data-role="show-popover"]').hover(function() {
    $(this).popover('show');
  }, function() {
    $(this).popover('hide');
  });
  
  // Shows popover box when enter key pressed
  $('i[data-role="show-popover"]').keyup(function(e) {
    var button = $(this);
    var keyCode = (e.keyCode ? e.keyCode : e.which);
    
    if(button.next('div.popover').size() === 1 && (keyCode === 13 || keyCode === 27)) { // Popover is currently visible and either enter or escape has been pressed
      button.popover('hide');
    } else if(button.next('div.popover').size() === 0 && keyCode === 13) { // Popover is not currently visible and the enter key has been pressed
      button.popover('show');
    }
  });
  
  // Hides popover box when focus is lost
  $('i[data-role="show-popover"]').focusout(function() {
    var button = $(this);
    if(button.next('div.popover').size() === 1) {
      button.popover('hide');
    }
  });
  
   // Shows modal when button is clicked
  $('button[data-role="show-modal"]').click(function() {
    $(this).next().modal('show');
  });
  
    // Makes collapsible elements dynamic
  $('body').on('click.collapse-next.data-api', '[data-toggle=collapse-next]', function() {
    var target = $(this).parent().next();
    target.collapse('toggle');
  });
  
  // Change to collapsed Hide/Show icon
  $('body').on('hide', 'div.collapse', function(e) {
    var button = $(this).prev().children();
    button.removeClass('icon-collapse').addClass('icon-expand');
    e.stopPropagation();
  });
  
  // Change to expanded Hide/Show icon
  $('body').on('show', 'div.collapse', function(e) {
    var button = $(this).prev().children();
    button.removeClass('icon-expand').addClass('icon-collapse');
    e.stopPropagation();
  });
  
  // Descriptions for select inputs
  $('select[data-description-target]').on('change', function() {
    var target = $(this).data('description-target');
    var description = $(this).children('option[data-description]:selected').first().data('description');
    $(target).popover('destroy');
    $(target).popover({content: description});
    //$(target).data('content', description);
  });
});

// Preforms simple ajax GET with some error handling
/* exported loadRemote */
function loadRemote(url, container, loading, callback){
  container.empty();
  if(loading !== null && loading !== undefined){
    loading.show();
  }
  container.load(url, function(response, status, xhr){
    if(loading !== null && loading !== undefined){
      loading.hide();
    }
    if(status === 'error'){
      var msg = '<p class="text-error">Sorry but there was an error: ';
      container.html(msg + xhr.status + ' ' + xhr.statusText + '</p>');
    }
    else if(callback !== null) {
      callback();
    }
  });
}

/*
 * unsavedChanges(bool = true)
 *
 * Either sets or removes listeners to warn the user if an action will
 * lose any unsaved changes.
 *
 * true : warn users
 * false : don't warn users
 */
/* exported unsavedChanges */
function unsavedChanges(warn){
  warn = typeof warn !== 'undefined' ? warn : true; // Default to warn
  if(warn){
    window.onbeforeunload = function() {
      return 'Leaving this page will lose any unsaved changes.';
    };
  } else{
    window.onbeforeunload = null;
  }
}

/* exported showSuccess */
function showSuccess(message){
  $('#script-success > [data-role="message"]').html(message);
  $('#script-success').show();
}

/* exported showNotice */
function showNotice(message){
  $('#script-notice > [data-role="message"]').html(message);
  $('#script-notice').show();
}

/* exported showAlert */
function showAlert(message){
  $('#script-alert > [data-role="message"]').html(message);
  $('#script-alert').show();
}

/* exported showError */
function showError(message){
  $('#script-error > [data-role="message"]').html(message);
  $('#script-error').show();
}

$(function() {
  if(!Modernizr.input.placeholder){
    // For browsers that don't support placeholder
    $('[placeholder]').focus(function() {
      var input = $(this);
      if (input.val() === input.attr('placeholder')) {
        input.val('');
        input.removeClass('placeholder');
      }
    }).blur(function() {
      var input = $(this);
      if (input.val() === '' || input.val() === input.attr('placeholder')) {
        input.addClass('placeholder');
        input.val(input.attr('placeholder'));
      }
    }).blur();
    $('[placeholder]').parents('form').submit(function() {
      $(this).find('[placeholder]').each(function() {
      var input = $(this);
      if (input.val() === input.attr('placeholder')) {
        input.val('');
      }
      });
    });
  }
});
