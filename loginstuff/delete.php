<?php
	session_start(); //starts the session
	if($_SESSION['user']){ //checks if user is logged in
	}
	else{
		header("location:index.php"); // redirects if user is not logged in
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] == "GET")
	{
		include 'serverconnect.php'; //server connection code
		$post_id = $_GET['post_id'];
		mysqli_query($conn,"DELETE FROM posts WHERE post_id='$post_id'"); //clear post
		mysqli_query($conn,"DELETE FROM images WHERE image_post_id='$post_id'"); //clear images
		header("location: postitem.php");
		exit();
	}
?>