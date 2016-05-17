<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] == "POST")
	{
		include 'serverconnect.php'; //server connection code
		$description = mysqli_real_escape_string($conn,$_POST['description']);
		$category = $_POST['category'];
		$title = mysqli_real_escape_string($conn,$_POST['title']);
		$price = $_POST['price'];
		$id = $_POST['post_id'];
		$photoid = $_POST['photoid'];
		$numpics = $_POST['numpics'];

		mysqli_query($conn, "UPDATE posts SET post_title='$title', post_price='$price', post_category='$category', post_description='$description' WHERE post_id='$id'");
		header("location: home.php");
		exit();
	}
?>