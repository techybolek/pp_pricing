function disableRateDet() {
   $('#rate_determinant_group_code').attr('disabled', 'true');
   $('#rate_determinant_group_code').attr('enabled', 'false');
   $('#rate_determinant_group_code').val('');

   $('#rate_determinant_data_type').removeAttr('disabled');
  //$('#rate_determinant_group_code').hide();
  //$('#group_code_label').hide();
}
function disableRateRes() {
   $('#rate_result_group_code').attr('disabled', 'true');
   $('#rate_result_group_code').attr('enabled', 'false');
   $('#rate_result_group_code').val('');

   $('#rate_result_data_type').removeAttr('disabled');
   $('#rate_result_precision').removeAttr('disabled');
  //$('#rate_result_group_code').hide();
  //$('#group_code_label').hide();
}
function enableRateDet() {
   $('#rate_determinant_group_code').removeAttr('disabled');
   $('#rate_determinant_group_code').val(1);

   $('#rate_determinant_data_type').attr('disabled', 'true');
   $('#rate_determinant_data_type').attr('enabled', 'false');
  //$('#rate_determinant_group_code').show();
  //$('#group_code_label').show();
}
function enableRateRes() {
   $('#rate_result_group_code').removeAttr('disabled');
   $('#rate_result_group_code').val(1);

   $('#rate_result_data_type').attr('disabled', 'true');
   $('#rate_result_data_type').attr('enabled', 'false');
   $('#rate_result_precision').attr('disabled', 'true');
   $('#rate_result_precision').attr('enabled', 'false');
  //$('#rate_result_group_code').show();
  //$('#group_code_label').show();
}

function setCategory() {

  var n = $('#select_input_type').val();
  switch(n) {
    case '1':
     disableRateDet();
    disableRateRes();
      break;
    case '2':
     enableRateDet();
    enableRateRes();
       break;
    default:
       break;
  }
}


$(function() {

  var n = $('#rate_determinant_group_code').val();
  if(n) {
    $('#select_input_type').val(2);
    //enableRateDet();
  } else {
    $('#select_input_type').val(1);
    disableRateDet();
    //$('#rate_determinant_group_code').attr('disabled', 'true');
    //$('#rate_determinant_group_code').attr('enabled', 'false');
    //$('#rate_determinant_group_code').hide();
    //$('#group_code_label').hide();
  }

  n = $('#rate_result_group_code').val();
  if(n) {
    $('#select_input_type').val(2);
  } else {
    disableRateRes();
    //$('#rate_result_group_code').attr('disabled', 'true');
    //$('#rate_result_group_code').attr('enabled', 'false');
    //$('#rate_result_group_code').attr('enabled', 'false');
    //$('#rate_result_group_code').hide();
   //$('#group_code_label').hide();
  }

  $('#select_input_type').change(function() {
     setCategory();
  });
  
  $('#rate_determinant_data_type').change(function() {
    var dataType = $('#rate_determinant_data_type').val();
    var rttiPath = $('#rate_determinant_rtti_path').val();
    if(rttiPath.match(/String|Boolean|Decimal|Integer|DateTime\.rate1/)) {
      $('#rate_determinant_rtti_path').val(dataType + '.rate1');
    }
  });

  $('#rate_result_data_type').change(function() {
    var dataType = $('#rate_result_data_type').val();
    var rttiPath = $('#rate_result_rtti_path').val();
    if(rttiPath.match(/String|Boolean|Decimal|Integer|DateTime\.rate1/)) {
      $('#rate_result_rtti_path').val(dataType + '.rate1');
    }
  });
});
