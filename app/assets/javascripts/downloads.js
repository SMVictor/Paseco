function download_file(type){
  
  var role_from = $( "#role_from option:selected" ).val();
  var role_to   = $( "#role_to option:selected" ).val();
  var ids = [0];

  var roles = document.querySelector('#download_inscaja_button').dataset.roles.replace('[','').replace(']','').split(",");

  for (var i = 0; i < roles.length; i++) {

    if ( parseInt(roles[i]) >= parseInt(role_from) && parseInt(roles[i]) <= parseInt(role_to)) {

      ids.push(roles[i]);
        
    }
  }
  if (type == 'xls') {
    window.location = document.URL + '/inscaja.xls?ids='+ids;
  }
  else if (type == 'csv'){
    window.location = document.URL + '/inscaja.csv?ids='+ids;
  }
  else{
    window.location = document.URL + '/inscaja?ids='+ids+'&txt=true';
  }
}

function download_payrole_file(type){
  
  var role_from = $( "#role_from1 option:selected" ).val();
  var role_to   = $( "#role_to1 option:selected" ).val();
  var ids = [0];

  var roles = document.querySelector('#download_inscaja_button').dataset.roles.replace('[','').replace(']','').split(",");

  for (var i = 0; i < roles.length; i++) {

    if ( parseInt(roles[i]) >= parseInt(role_from) && parseInt(roles[i]) <= parseInt(role_to)) {

      ids.push(roles[i]);
        
    }
  }
  if (type == 'xls') {
    window.location = document.URL + '/payroles.xls?ids='+ids;
  }
  else if (type == 'csv'){
    window.location = document.URL + '/payroles.csv?ids='+ids;
  }
  else{
    window.location = document.URL + '/payroles?ids='+ids+'&txt=true';
  }
}

function download_breakdown_file(type){
  
  var role_from = $( "#role_from2 option:selected" ).val();
  var role_to   = $( "#role_to2 option:selected" ).val();
  var ids = [0];

  var roles = document.querySelector('#download_inscaja_button').dataset.roles.replace('[','').replace(']','').split(",");

  for (var i = 0; i < roles.length; i++) {

    if ( parseInt(roles[i]) >= parseInt(role_from) && parseInt(roles[i]) <= parseInt(role_to)) {

      ids.push(roles[i]);
        
    }
  }
  window.location = document.URL + '/breakdown.csv?ids='+ids;
}

function download_entity_file(type){
  
  var entity  = $( "#entity option:selected" ).val();
  var status  = $( "#status option:selected" ).val();

  if (type == 'xls') {
    window.location = document.URL + '/entity.xls?entity='+entity+'&status='+status;
  }
  else{
    window.location = document.URL + '/entity.csv?ids='+entity+'&status='+status;
  }
}
