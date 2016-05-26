<?php
	include 'serverconnect.php'; //server connection code
	$query = mysqli_query($conn,"Select * from users");
	if($_SERVER["REQUEST_METHOD"] == "POST"){
		$email = mysqli_real_escape_string($conn, $_POST['email']);
		$username = mysqli_real_escape_string($conn, $_POST['username']);
		$password = mysqli_real_escape_string($conn, $_POST['password']);
	}
	mysqli_query($conn,"INSERT INTO users (email, username, password) VALUES('$email','$username','$password')");
?>