$(document).on('keyup change', '#explore-search-form input', _.debounce(function(event) {
  var form = event.target.form;
  $(form).trigger('submit');
}, 200));