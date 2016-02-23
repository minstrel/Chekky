$(document).on('ready page:load', function (){
  // $('input[type="checkbox"]').change(function() {
  //   // console.log($(this).parents(["form"]));
  //   console.log("checkbox changed");
  // });
  // $("#Test").click(function() {
  //   console.log("Test clicked!");
  // });
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

