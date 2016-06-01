<?php
		session_start(); //starts the session
		if($_SESSION['user']){ //checks if user is logged in
		}
		else{
			header("location:index.php"); // redirects if user is not logged in
			Print "Please log in";
			exit();
		}
		if(!empty($_GET['post_id'])){
			$post_id = $_GET['post_id'];
			$image_id = $_GET['image_id'];
			$numpics = $_GET['numpics'];
			$numpics--;
			include 'serverconnect.php'; //server connection code
			mysqli_query($conn,"DELETE FROM images WHERE image_id='$image_id'"); //clear images
			mysqli_query($conn, "UPDATE posts SET post_photos='$numpics' WHERE post_id='$post_id'");

			header("location: edit.php?post_id=".$post_id);
			exit();
		}
?>