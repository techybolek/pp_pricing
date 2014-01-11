var lastHoverCell = null;
var shadowDets = null;
var shadowRes = null;
var imageString1 = '<i class="hover ui-icon ui-icon-arrowthick-2-n-s" style="display:inline-block" data-role="move-rate" title="Move rate"></i>';
var imageString2 = '<i class="icon-trash hover right-justify" data-role="remove-rate" title="Remove from list"></i>';


function doSwap(src, dst) {
  var ct = $(src).text();
  var cd = $(src).data('rateid');

  $(src).find('span').text($(dst).text());
  $(src).data('rateid', $(dst).data('rateid'));

  $(dst).find('span').text(ct);
  $(dst).data('rateid', cd);

  $(dst).focus();
}


function updateAvailableList() {
  shadowDets.html(shadowDets.data('options'));
  shadowRes.html(shadowRes.data('options'));

  $('#determinants-table li').each(function(index, li) {
    var rateId = $(li).data('rateid');
    $('#available-determinants').val(rateId); //select
    $('#available-determinants option:selected').remove(); //hide selected
  });

  $('#results-table li').each(function(index, li) {
    var rateId = $(li).data('rateid');
    $('#available-results').val(rateId); //select
    $('#available-results option:selected').remove(); //hide selected
  });
}

function cancelAll() {
  var container = $('#usage-template-container');
  var url = container.data('loadurl');
  $('#rates-loading').show();
  $.ajax({
    type : 'GET',
    url : url,
    data : {
      'ajax' : 'true'
    }
  }).done(function(data) {
    container.empty();
    container.html(data);
    templateInit();
  }).fail(function(data, status, error) {
    var msg = '<p class="text-error">Sorry but there was an error: ';
    container.prepend(msg + ' ' + error + '</p>');
  }).always(function() {
    $('#rates-loading').hide();
  });
}


function cancelCreate() {
  var container = $('#usage-template-container');
  var url = container.data('loadurl');
  $('#rates-loading').show();
  $.ajax({
    type : 'GET',
    url : url,
    data : {
      'ajax' : 'true'
    }
  }).always(function() {
    $('#rates-loading').hide();
  });
}


function approve() {
  var container = $('#usage-template-container');
  var url = container.data('approveurl');
  $('#rates-loading').show();
  $.ajax({
    type : 'POST',
    url : url,
    data : {
      'ajax' : 'true'
    }
  }).done(function(data) {
    container.empty();
    container.html(data);
    templateInit();
  }).fail(function(data, status, error) {
    var msg = '<p class="text-error">Sorry but there was an error: ';
    container.prepend(msg + ' ' + error + '</p>');
  }).always(function() {
    $('#rates-loading').hide();
  });
}

function saveAll() {
  var rates = [];
  var rateId = '';
  
  $('#determinants-table li').each(function() {
    rateId = $(this).data('rateid');
    rates.push(rateId);
  });
  $('#results-table li').each(function() {
    rateId = $(this).data('rateid');
    rates.push(rateId);
  });

  var container = $('#usage-template-container');

  var template = {};
  template['template_name'] = $.trim($('#template_name').text());
  template['template_code'] = $('#template_code').text().replace(/\n+|\t+| +/g, '');
  template['effective_date'] = $('#effective_date').text().replace(/\n+|\t+| +/g, '');
  //template['effective_date'] = template['effective_date'] + ' 00:00:00';

  $('#rates-loading').show();
  $.ajax({
    type : 'POST',
    url : container.data('url'),
    data : {
      'ajax' : 'true',
      'rate_ids' : rates,
      'template' : template
    }
  }).done(function(data) {
    container.empty();
    container.html(data);
    templateInit();
  }).fail(function(data, status, error) {
    var msg = '<p class="text-error">Sorry but there was an error: ';
    container.prepend(msg + ' ' + error + '</p>');
  }).always(function() {
    $('#rates-loading').hide();
  });
}

function create() {
  var rates = [];
  var rateId = '';

  $('#determinants-table li').each(function() {
    rateId = $(this).data('rateid');
    rates.push(rateId);
  });
  $('#results-table li').each(function() {
    rateId = $(this).data('rateid');
    rates.push(rateId);
  });


  var container = $('#usage-template-container');

  var template = {};
  template['template_name'] = $.trim($('#template_name').text());
  template['template_code'] = $('#template_code').text().replace(/\n+|\t+| +|Empty/g, '');
  template['effective_date'] = $('#effective_date').text().replace(/\n+|\t+| +/g, '');
  //template['effective_date'] = template['effective_date'] + ' 00:00:00';

  container.find('[class="text-error"]').empty();
  var error = false;
  if(!template['template_name']) {
    container.prepend('<p class="text-error">Template name cannot be empty</p>');
    error = true;
  }
  if(!template['template_code']) {
    container.prepend('<p class="text-error">Template code cannot be empty</p>');
    error = true;
  }
  if(template['template_name'] && template['template_name'].length > 20) {
    container.prepend('<p class="text-error">Template name is too long (maximum is 20 characters)</p>');
    error = true;
  }
  if(template['template_code'] && template['template_code'].length > 10) {
    container.prepend('<p class="text-error">Template code is too long (maximum is 10 characters)</p>');
    error = true;
  }

  if(error) {
    return;
  }

  $('#rates-loading').show();
  $.ajax({
    type : 'POST',
    url : container.data('url'),
    data : {
      'ajax' : 'true',
      'rate_ids' : rates,
      'template' : template
    }
  }).fail(function(data, status, error) {
    var msg = '<p class="text-error">Sorry but there was an error: ';
    container.prepend(msg + ' ' + error + '</p>');
  }).always(function() {
    $('#rates-loading').hide();
  });
}


function addColumn(target, stringName, rateid, theClass, offset) {

  var max = offset;
  $('li', target).each(function() {
    var ti = $(this).attr('tabindex');
    var val = parseInt(ti, 10);
    if(max < val) {
      max = val;
    }
  });

  max++;


  $(target).append(
    '<li data-rateid="' + rateid + '" class="' + theClass + ' rate-cell"' +
    ' tabindex="' + max + '"' + '>' +
       imageString1 +
       '<span>' + stringName + '</span>' +
       imageString2 +
       '</li>');
}

function findDetInfo(rateId) {
  var dlist = jsDeterminants[0];
  for(var i=0; i<dlist.length; i++) {
    if(dlist[i]['rate_id'] === rateId) {
      var el = dlist[i];
      var tstring = el['title'] + ', ' + el['data_type'] + ', ';
      if(el['group_code']) {
        tstring = tstring + el['group_code'];
      } else {
        tstring = tstring + 'Free form';
      }
      return tstring;
    }
  }
  return null;
}

function findResInfo(rateId) {
  var dlist = jsResults[0];
  for(var i=0; i<dlist.length; i++) {
    if(dlist[i]['rate_id'] === rateId) {
      var el = dlist[i];
      var tstring = el['title'] + ', ' + el['data_type'] + ', ';
      if(el['group_code']) {
        tstring = tstring + el['group_code'];
      } else {
        tstring = tstring + 'Free form';
      }
      tstring = tstring + ', Precision ' + el['precision'];
      return tstring;
    }
  }
  return null;
}

function findRateInfo(rateId, tableId) {
  if(tableId === 'available-determinants') {
    return findDetInfo(rateId);
  } else {
    return findResInfo(rateId);
  }
}

function tUnbind() {
  $('[data-role="remove-rate"]').unbind();
  $('.rate-det-cell').unbind();
  $('.rate-res-cell').unbind();
  $('.rate-box').unbind();
  $('.add-rate-btn').unbind();
  $('#rate_prompt').unbind();
  $('#save-rates').unbind();
  $('#cancel-rates').unbind();
  $('#approve-rates').unbind();
  $('#template-create').unbind();
  $('#template-back').unbind();
  $('#usage-template-container li').unbind();
}

function tBind() {
  var templateStatus = $('#effective_status').text();
  if (templateStatus === 'DRAFT') {

    $('.sortable').sortable({
      handle : '[data-role="move-rate"]'
    });
    $('.sortable li').focus(function() {
      $(this).addClass('ui-selecting');
    });
    $('.sortable li').focusout(function() {
      $(this).removeClass('ui-selecting');
    });

    $('.sortable li').bind('keydown', function(event) {

      var index = $(this).index();
      var ul = $(this).parent('ul');
      var len = $(ul).find('li').length;
      var dst;

      switch(event.which) {
        case 38: //up
          if(index > 0) {
            dst = $(ul).find('li').eq(index-1);
            doSwap(this, dst);
          }
          break;
        case 40: //down
          if(index < len-1) {
            dst = $(ul).find('li').eq(index+1);
            doSwap(this, dst);
          }
          break;
        case 46: //delete
          $(this).remove();
          updateAvailableList();
          tRebind();
      }
    });


    $('.add-rate-btn').click(function() {
      var listName = $(this).data('source');
      var tableName = $(this).data('target');
      var className = $(this).data('class');
      var offset = $(this).data('offset');
      var table = document.getElementById(tableName);
      var list = document.getElementById(listName);
      var n = $(list).val();
      if (n) {
        var t = $(list).find(':selected').text();
        addColumn(table, t, n, className, offset);
        updateAvailableList();
        tRebind();
      }
    });

    $('[data-role="remove-rate"]').click(function() {
      var li = $(this).parent('li');
      $(li).remove();
      updateAvailableList();
      tRebind();
    });

    $('.rate-box').change(function() {
        //curr = $('#available-determinants option:selected');
        var curr = $('option:selected', $(this));
        var rateId = $(curr).val();
        var el = findRateInfo(rateId, $(this).attr('id'));

        var pos = $(this).position();
        var index = this.selectedIndex;
        index = index - (this.scrollTop / 17);
        var unitSize = $(this).height()/6;
        var top = pos.top + unitSize * index;
        //var top = pos.top + unitSize * index - unitSize/2;
        var left = pos.left;
        var width = $(this).width()*97/100;

        $('#rate_prompt').html(el);
        $('#rate_prompt').css({'top':top, 'left': left+width}).show();
    });

    $('.rate-box').focusout(function() {
      $('#rate_prompt').hide();
    });

     $('#rate_prompt').mouseleave(function(e){
        var elt = e.toElement || e.relatedTarget;
        if (elt!==lastHoverCell) {
          $(this).hide();
          lastHoverCell = null;
        }
     });

     $('#save-rates').click(function() {
         saveAll();
     });

     $('#cancel-rates').click(function() {
         cancelAll();
     });

     $('#approve-rates').click(function() {
         tUnbind();
         tBind();
         approve();
     });

     $('#template-create').click(function() {
         create();
     });

     $('#template-back').click(function() {
         cancelCreate();
     });
  }
}

function tRebind() {
  tUnbind();
  tBind();
}

function templateInit() {
  tRebind();
  updateAvailableList();
  var templateStatus = $('#effective_status').text();
  if (templateStatus === 'DRAFT') {
    $('a[data-role="editable"]').editable();
  } else {
    $('#save-rates').attr('disabled', 'disabled');
    $('#cancel-rates').attr('disabled', 'disabled');
    $('#approve-rates').attr('disabled', 'disabled');
    $('#add-rate-result').attr('disabled', 'disabled');
    $('#add-rate-determinant').attr('disabled', 'disabled');
  }
}

$(function() {
    shadowDets = $('#available-determinants');
    shadowDets.data('options', $('option', shadowDets));
    shadowRes = $('#available-results');
    shadowRes.data('options', $('option', shadowRes));
    templateInit();
    $('#dprompt').hide();
    $('#rprompt').hide();
});
