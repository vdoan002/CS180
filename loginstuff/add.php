<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
	}
	if($_SERVER['REQUEST_METHOD'] = "POST") //Added an if to keep the page secured
	{
		$servername = "fdb14.biz.nf";
		$serverusername = "2104912_db1";
	    $serverpassword = "data5base";
		$conn = mysqli_connect($servername, $serverusername, $serverpassword) or die(mysqli_connect_error()); //Connect to server
	    mysqli_select_db($conn,"2104912_db1") or die("Cannot connect to database");//Connect to database
	    $details = mysqli_real_escape_string($conn,$_POST['details']);
		$time = strftime("%X");//time
		$date = strftime("%B %d, %Y");//date
		$decision ="no";
		foreach($_POST['public'] as $each_check) //gets the data from the checkbox
 		{
 			if($each_check !=null ){ //checks if the checkbox is checked
 				$decision = "yes"; //sets teh value
 			}
 		}
		
		mysqli_query($conn,"INSERT INTO list (details, date_posted, time_posted, public) VALUES ('$details','$date','$time','$decision')"); //SQL query
		header("location: home.php");
	}
	else
	{
		header("location:home.php"); //redirects back to hom
	}
?>