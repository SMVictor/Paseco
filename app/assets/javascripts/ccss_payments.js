function download_file(xls){
  
  var role_from = $( "#role_from option:selected" ).val();
  var role_to   = $( "#role_to option:selected" ).val();
  var ids = [0];

  var roles = document.querySelector('#download_button').dataset.roles.replace('[','').replace(']','').split(",");

  for (var i = 0; i < roles.length; i++) {

    if ( parseInt(roles[i]) >= parseInt(role_from) && parseInt(roles[i]) <= parseInt(role_to)) {

      ids.push(roles[i]);
        
    }
  }
  if (xls) {
    window.location = document.URL + '/1.xls?ids='+ids;
  }
  else{
    window.location = document.URL + '/1?ids='+ids;
  }
}
function wait(ms){
   var start = new Date().getTime();
   var end = start;
   while(end < start + ms) {
     end = new Date().getTime();
  }
}