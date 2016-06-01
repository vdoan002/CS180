<?php
	session_start();
	if($user = $_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] = "POST") //Added an if to keep the page secured
	{
		include 'serverconnect.php';
		$receiver = mysqli_real_escape_string($conn,$_POST['receiver']);
		$query = mysqli_query($conn, "SELECT * FROM users WHERE username='$receiver'");
		$rowcount = mysqli_num_rows($query);
		if($rowcount == 0){
			Print'<script> alert("invalid username entered")
			window.location="http://practicemakesperfect.co.nf/messenger.php"</script>;
			';
			exit();
		}
		else if($receiver == $user){
			Print'<script> alert("you can\'t message yourself")
			window.location="http://practicemakesperfect.co.nf/messenger.php"</script>;
			';
			exit();
		}
		else{
			$redirect = "location: message.php?username=".$receiver;
			header($redirect);
			exit();
		}
	}
?>