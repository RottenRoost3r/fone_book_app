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

function modalstuff(){
  var modal = document.getElementById('myModal');
  var buttons = document.getElementsByName('myBtn');
  var span = document.getElementsByClassName("close")[0];
  
  
  for (var i = 0; i < buttons.length; i++) { 
    // console.log(buttons[i]);
    buttons[i].onclick = function() {
      modal.style.display = "block";
      console.log("it's clicked")
  }
  }
  
  span.onclick = function() {
      modal.style.display = "none";
  }
  window.onclick = function(event){
    if (event.target == modal) {
        modal.style.display = "none";
        }  
      }
}