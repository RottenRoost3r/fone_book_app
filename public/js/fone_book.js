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

function deleteRows(){

	isTable = document.getElementById('contacts_table');
	nBoxes = document.getElementsByName('delbox');
	for (i=nBoxes.length-1; i>=0; i--);
		{if (nBoxes[i].checked == true){isTable.deleteRow(i+1);}}
}	

function delbutton(){
  var chkboxes = document.getElementById(delbox);

}