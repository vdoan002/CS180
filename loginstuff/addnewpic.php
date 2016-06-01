<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] = "POST") //Added an if to keep the page secured
	{
		$post_id = $_POST['post_id'];
		$numpics = $_POST['numpics'];
		$numpics++;

		$image_name = $_FILES['newimage']['name'];
		$file = $_FILES['newimage']['tmp_name'];
		$image = addslashes(file_get_contents($_FILES['newimage']['tmp_name']));
		if(file_exists($file) && getimagesize($file)){ //make sure uploads aren't empty & is a pic
			include 'serverconnect.php'; //server connection code
			mysqli_query($conn, "INSERT INTO images (image_post_id, image_name, image_pic) VALUES ('$post_id', '$image_name', '$image')");
			mysqli_query($conn, "UPDATE posts SET post_photos='$numpics' WHERE post_id='$post_id'");
		}

		header("location: edit.php?post_id=".$post_id);
		exit();
	}

?>