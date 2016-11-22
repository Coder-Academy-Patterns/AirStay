$(document).on('change', '#new_trip select', _.debounce(function(event) {
  var form = event.target.form;
  console.log($(form).serialize())
  
  var elements = form.elements;

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

  var query = jQuery.param({
    check_in: check_in_date,
    check_out: check_out_date,
    guests: guest_count 
  })
  console.log(query)

  //Turbolinks.visit(location.pathname + '?' + query + '#' + form.id, { action: 'replace' });
  var path = location.pathname + '?' + query;
  $.get({
    url: path,
    dataType: 'script'
  })
  .then(function() {
    history.replaceState({}, '', path)
  });

  //$(form).trigger('submit');
}, 200));