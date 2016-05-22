<?php
	session_start();
	if($_SERVER['REQUEST_METHOD'] = "POST"){
		include 'serverconnect.php';
		$content = mysqli_real_escape_string($conn,$_POST['content']);
		$sender = mysqli_real_escape_string($conn,$_POST['sender']);
		$receiver = mysqli_real_escape_string($conn,$_POST['receiver']);
		mysqli_real_escape_string($conn,$_POST['receiver']);
		date_default_timezone_set("America/Los_Angeles");
		$time = date('h:i:s');//strftime("%X");//time
		$date = date('m/d/Y');//strftime("%B %d, %Y");//date
		$seen = 0;
		mysqli_query($conn,"INSERT INTO messages (message_sender, message_receiver, message_content, message_timesent, message_date, message_seen) VALUES ('$sender','$receiver','$content','$time','$date', '$seen')");
		
	}
	$redirect = "location: message.php?username=".$receiver;
	//Print'<script>window.location="http://practicemakesperfect.co.nf/messenger.php"</script>;';
	header($redirect);
	exit();
?>