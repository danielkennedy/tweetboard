$(document).ready(function() { 
  console.log('Doc is ready');
  $('#modalSignitButton').click(function () {
    $('#signupForm').ajaxSubmit({
      beforeSubmit: showRequest,
      success: showResponse,
      type: 'put',
      url: '/api/signatures'
    }); 

    // !!! Important !!! 
    // always return false to prevent standard browser submit and page navigation 
    return false; 
  });

  var viewModel = new function () {
    var self = this;
    self.signed = ko.observable(false);
    self.signatures = ko.observableArray([]);
    self.loadSignatures = function (signatures) {
      var i;
      $('#signatures').fadeOut(300, function () {
        self.signatures.removeAll();
        self.signatures(signatures);
        $('#signatures').fadeIn(300);
      });
    };
  };

  $.ajax({
    type: 'GET',
    dataType: 'json',
    url: '/api/signatures'
  }).success(function (data, textStatus, jqXHR) {
    console.log('API returned:', data);
    var index = 0;
    var max = 3;
    var end = max;
    function loadSigs() {
      end = index + max;
      var sigs = data.slice(index, end);
      index = end;
      if (data.length >= max && sigs.length < max) {
        // reached the end. wrap around.
        index = end = (max - sigs.length);
        sigs = sigs.concat(data.slice(0, end));
      }
      viewModel.loadSignatures(sigs);
    }
    window.setInterval(loadSigs, 10000);
    loadSigs();
    ko.applyBindings(viewModel);
  });

  // pre-submit callback 
  function showRequest(formData, jqForm, options) { 
    var queryString = $.param(formData); 
    console.log('About to submit: \n\n' + queryString); 
    $('#modalSignitButton').button('loading');
    return true; 
  } 
 
  // post-submit callback 
  function showResponse(responseText, statusText, xhr, $form)  { 
    console.log('status: ' + statusText + '\n\nresponseText: \n' + responseText); 
    $('#modalSignitButton').button('reset');
    viewModel.signed(true);
    // - disable the main page's sign it button
    $('#mainSignitButton').prop("disabled", true);
    // - close the signit modal
    $('#signitModal').modal('hide');
    // - open the shareit modal
    $('#shareitModal').modal('show');
  } 
}); 

