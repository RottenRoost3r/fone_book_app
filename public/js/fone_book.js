function searchfunk() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("searchinput");
  filter = input.value.toUpperCase();
  table = document.getElementById("table");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}

function modalstuff(contact_id){
  var modal = document.getElementById('myModal');
 var buttons = document.getElementsByName('myBtn');
  var span = document.getElementsByClassName("close")[0];
  var x = contact_id.value;
  var y = document.getElementById("add_content_value");
  x = x.split(',');
  console.log(x);
  for (var i = 0; i < y.children.length; i++){
    if (y.children[i].tagName == "INPUT"){
        if (y.children[i].type == "text"){
            y.children[i].value = x[i];
        }else if (y.children[i].type == "hidden"){
          y.children[i].value = x[i];
        }
        
    }
}


modal.style.display = "block";
  
  span.onclick = function() {
    modal.style.display = "none";
  }
  window.onclick = function(event){
    if (event.target == modal) {
        modal.style.display = "none";
        }  
      }
}

function deeleet(){
var z = document.getElementById("myform");
z.action = "/delete";
z.submit();
}

function edit(){
var m = document.getElementById("myform");
m.action = "/update";
m.submit();
}