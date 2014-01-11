var jqXHRTMEs = null;
var jqXHRCalculations = null;

function loadCalculationOptions(){
  var url = $('#calculation_tab').data('load-url');
  $('#calculation_tab').html('<div class="loading"></div>');
  
  if(jqXHRCalculations !== null){
    jqXHRCalculations.abort();
  }
  
  jqXHRCalculations = $.post( url , $( '#tma-form' ).serialize() )
    .done(function( data ) {
      $( '#calculation_tab' ).html( data );
      $( '#calculation_tab a[data-role="editable"]' ).editable({
        send: 'never'
      });
    })
    .fail(function(jqXHR){
      if(jqXHR.status !== 0){
        showError(jqXHR.status + ': ' + jqXHR.statusText);
      }
    })
    .always(function(){
      jqXHRCalculations = null;
    });
}

function loadTMEs(){
  var url = $('#tmes_tab').data('load-url');
  $('#tmes_tab').html('<div class="loading"></div>');
  
  if(jqXHRTMEs !== null){
    jqXHRTMEs.abort();
  }
  
  jqXHRTMEs = $.post( url , $( '#tma-form' ).serialize() )
    .done(function( data ) {
      $( '#tmes_tab' ).html( data );
      $( '#tmes_tab a[data-role="editable"]' ).editable({
        send: 'never'
      });
      // 'Save' events don't bubble up the DOM
      $('#tmes_tab a[data-role="editable"]').on('save', function(e, params) {
        $(this).closest('td').data('override', params.newValue);
      });
    })
    .fail(function(jqXHR){
      if(jqXHR.status !== 0){
        showError(jqXHR.status + ': ' + jqXHR.statusText);
      }
    })
    .always(function(){
      jqXHRTMEs = null;
    });
}

function gatherCalculationOptions(){
  var options = [];
  $('#calculation_tab a[data-role="editable"]').each(function(){
    options.push( {  'name': $(this).data('name'),
                    'value': $(this).editable('getValue', true)} );
  });
  return options;
}

function gatherTMEs(){
  var tmes = [];
  var tmeObjects = $('#tmes_tab table').tableToJSON({
    ignoreHiddenRows: false
  });
  
  $.each(tmeObjects, function(){
    tmes.push({  'name': 'tmes[]',
                'value': JSON.stringify(this) });
  });
  
  return tmes;
}

function saveTMA(httpVerb, savePath, onSuccess){
  $('#tma-loading').show();
  
  if(jqXHRTMEs !== null || jqXHRCalculations !== null){
    setTimeout(function() {
      saveTMA(httpVerb, savePath, onSuccess);
    }, 500);
    return;
  }
  
  var tma = $( '#tma-form' ).serializeArray();
  var calculationOptions = gatherCalculationOptions();
  var tmes = gatherTMEs();
  
  var allParams = $.merge(tma, calculationOptions, tmes);
  allParams = $.merge(allParams, tmes);
  
  $.ajax({
    type: httpVerb,
    url: savePath,
    data: allParams,
  }).done(onSuccess)
    .fail(function(jqXHR){
      var msg = '';
      if(jqXHR.status === 422){
        $.each($.parseJSON(jqXHR.responseText), function(k, v) { msg += k+': '+v+'<br />'; });
      } else if(jqXHR.status === 0) {
        return;
      } else {
        msg = showError(jqXHR.status + ': ' + jqXHR.statusText);
      }
      showError(msg);
      alertify.log('Save failed, see error(s) above', 'error');
    })
    .always(function(){
      $('#tma-loading').hide();
    });
}

$(function() {
  $('#tariff_model_area_calculation_id').change(function(){
    // If the calculation changes, it affects both calculation tab and TME tab
    loadCalculationOptions();
    loadTMEs();
  });
  
  $('#sensitivities_tab select').change(function(){
    loadTMEs();
  });
  
  $('#tariff_model_area_rate_table_id').change(function(){
    if($(this).val() && $(this).val() !== ''){
      $('#sensitivities_tab select').not(this).each(function(){
        $(this).select2('val', '');
        $(this).prop( 'disabled', true );
      });
    } else {
      $('#sensitivities_tab select').not(this).prop( 'disabled', false );
    }
    loadTMEs();
  });
  
  $('#save-tma').click(function(){
    saveTMA('PUT', $(this).data('save-url'), function(){
      // On Successful save, reloaded partials and let user know all is well
      alertify.log('Save successful', 'success', '2000');
      loadCalculationOptions();
      loadTMEs();
    });
  });
  
  $('#create-tma').click(function(){
    saveTMA('POST', $(this).data('save-url'), function(data){
      // On Successful save, redirect to the 'edit' page of the new TMA
      window.location.replace = data.editUrl;
      window.location.href = data.editUrl;
    });
  });
  
  $('#cancel-tma').click(function(){
    window.location.reload(true);
  });
  
  
  // 'Save' events don't bubble up the DOM
  $('#tmes_tab a[data-role="editable"]').on('save', function(e, params) {
    $(this).closest('td').data('override', params.newValue);
  });
});