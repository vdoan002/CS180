<?php
  session_start(); //starts the session
  if($_SESSION['user']){ //checks if user is logged in
  }
  else{
    header("location:index.php"); // redirects if user is not logged in
    Print "Please log in";
    exit();
  }
?>
<html>
  <head>
    <style>
      #map {
        width: 500px;
        height: 400px;
      }
    </style>
    <script>
    	function updateMap(){
    		var loc = document.getElementById('locinfo').value;
        if(loc){
      		var output = 
      		'<iframe width="600" height="450" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAXuuDhTJljm3Glal3QQwpPUFPO7BAK7tw &q=' + loc + '" allowfullscreen> </iframe>';
  			   document.getElementById("maplocation").innerHTML = output;
        }
    	}
    </script>
  </head>
  <body>
    <?php
      include 'navbar.php';
    ?>
    <form onsubmit="return false">
  	  Meeting Location: <input type="text" id="locinfo" placeholder="Coffee Bean UCR" required />
  	  <input type="submit" value="Navigate" onclick="updateMap()" /><br><br>
    </form>
  	<div id="maplocation">
		<iframe
		  width="600"
		  height="450"
		  frameborder="0" style="border:0"
		  src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAXuuDhTJljm3Glal3QQwpPUFPO7BAK7tw &q=Coffee+Bean+UCR,Riverside+CA" allowfullscreen>
		</iframe>
	</div>
  </body>
</html>
