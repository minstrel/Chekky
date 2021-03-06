$(document).on('ready page:load', function (){
  $('.tabular.menu .item')
    .tab({
      context: 'parent',
      auto : true,
      alwaysRefresh : true,
      evaluateScripts : true,
      parseScripts : true,
      ignoreFirstLoad: false,
      cache: false,
      path : '/checklists/',
      debug: false
    })
  ;
  $('.tabular.menu .item').tab('change tab', 'not_completed');
  $( '.ui.tab.segment' ).on( 'click', 'i.complete', function() {
    // Get the item's id number from the data-itemid attribute
    var id = $(this).attr('data-itemid');
    // Toggle the complete status of the item
    $('input[data-checkboxid=' + id + ']').click();
    // Submit the form corresponding to the checklist's data-itemid attribute
    $('form#edit_checklist_' + id).submit();
    // Handle removing the row in the .js callback from the update method
    });
  $( '.ui.tab.segment' ).on( 'click', 'i.vickie', function() {
    // Get the item's id number from the data-itemid attribute
    var id = $(this).attr('data-itemid');
    // Toggle the vickie status of the item
    $('input[data-vickieid=' + id + ']').click();
    // Submit the form corresponding to the checklist's data-itemid attribute
    $('form#edit_checklist_' + id).submit();
    });
})

