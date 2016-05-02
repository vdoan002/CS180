<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
	}
	if($_SERVER['REQUEST_METHOD'] = "POST") //Added an if to keep the page secured
	{
		include 'serverconnect.php'; //server connection code
		$username = $_SESSION['user'];
		$category = $_POST['category'];
		$title = $_POST['title'];
		$price = $_POST['price'];

	    $description = mysqli_real_escape_string($conn,$_POST['description']);
	    date_default_timezone_set("America/Los_Angeles");
		$time = date('h:i:s');//strftime("%X");//time
		$date = date('m/d/Y');//strftime("%B %d, %Y");//date

		//get images
		$photobit = 0;
		$imagenames = $_FILES['itemimages']['tmp_name'];
		if(!empty(imagenames)){
		//if(file_exists($imagenames[0]) && is_uploaded_file($imagenames[0])){
			foreach($imagenames as $file){
				if(file_exists($file) && getimagesize($file)){ //make sure uploads aren't empty & is a pic
					$photobit += 1;
				}
			}
		}

		/*
		//get single image
		$imagename=$_FILES['itemimage']['tmp_name'];
		if(file_exists($imagename) && is_uploaded_file($imagename)){ //checks if file was uploaded
			if(getimagesize($_FILES['itemimage']['tmp_name'])){ //checks that file is an image
				$image=addslashes(file_get_contents($_FILES['itemimage']['tmp_name']));
				$image_name = addslashes($_FILES['itemimage']['name']);
				$photobit = 1;
			}
		}
		*/
		//add post
		mysqli_query($conn,"INSERT INTO posts (post_title, post_username, post_price, post_category, post_description, post_date, post_time, post_photos) VALUES ('$title','$username','$price','$category','$description', '$date','$time', '$photobit')"); //SQL query
		//add photo for post, if it exists
		if($photobit > 0){
			$curiteration = 0;
			$newid = mysqli_insert_id($conn);
			$filenmarray = array();
			foreach($_FILES['itemimages']['name'] as $filenm){
				array_push($filenmarray, $filenm);
			}
			$ct = 0;
			foreach($imagenames as $file){
				if(file_exists($file) && getimagesize($file)){
					$image = addslashes(file_get_contents($file));
					$image_name = $filenmarray[$ct];
					mysqli_query($conn, "INSERT INTO images (image_post_id, image_name, image_pic) VALUES ('$newid', '$image_name', '$image')");
				}
				$curiteration += 1;
				$ct += 1;
			}
			$newid2 = mysqli_insert_id($conn); //set location of photo in images table
			mysqli_query($conn, "UPDATE posts SET post_photo_id='$newid2' WHERE post_id='$newid'");
		}
		header("location: home.php");
	}
	else
	{
		header("location: home.php"); //redirects back to home
	}
?>