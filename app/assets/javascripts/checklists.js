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
})

