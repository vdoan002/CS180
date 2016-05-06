<?php
	session_start();
	if($user = $_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}

	Print'
	<div id="navbar">
		<p>Hello '.$user.'!</p>
		<a href="home.php">HOME</a><br/>
		<a href="logout.php">LOGOUT</a><br/>
		<a href="postitem.php">MAKE/EDIT POST</a><br/>
		<a href="map.php">MAP</a><br/><br/>
	</div>
	'
?>