$(document).on('change', '#new_trip select', _.debounce(function(event) {
  var form = event.target.form;
  var elements = form.elements;

  // Grab current values from form
  var check_in_date = [
    elements['trip_check_in_date_1i'].value,
    elements['trip_check_in_date_2i'].value,
    elements['trip_check_in_date_3i'].value
  ].join('-');

  var check_out_date = [
    elements['trip_check_out_date_1i'].value,
    elements['trip_check_out_date_2i'].value,
    elements['trip_check_out_date_3i'].value
  ].join('-');

  var guest_count = elements['trip_guest_count'].value;

  // Make query string with values
  var query = jQuery.param({
    check_in: check_in_date,
    check_out: check_out_date,
    guests: guest_count 
  });
  var path = location.pathname + '?' + query;
  
  // Load new form using listings/show.js.erb
  $.get({
    url: path,
    dataType: 'script'
  })
  .then(function() {
    // Update browser URL
    history.replaceState({}, '', path)
  });
}, 200));