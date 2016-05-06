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
		$title = $_POST['title'];
		$price = $_POST['price'];
		$id = $_POST['post_id'];
		$photoid = $_POST['photoid'];
		$numpics = $_POST['numpics'];

		//check for new photo upload
		$photobit = 0;
		$imagenames = $_FILES['itemimages']['tmp_name'];
		if(!empty(imagenames)){
			foreach($imagenames as $file){
				if(file_exists($file) && getimagesize($file)){ //make sure uploads aren't empty & is a pic
					$photobit += 1;
				}
			}
		}

		mysqli_query($conn, "UPDATE posts SET post_title='$title', post_price='$price', post_category='$category', post_description='$description' WHERE post_id='$id'");
		if($photobit > 0){
			$curiteration = 0;
			$newid = mysqli_insert_id($conn);
			$filenmarray = array();
			foreach($_FILES['itemimages']['name'] as $filenm){
				array_push($filenmarray, $filenm);
			}
			$updatebase = ($photoid - $numpics) + 1;
			foreach($imagenames as $file){
				$updateloc = $updatebase + $curiteration;
				if(file_exists($file) && getimagesize($file)){
					$image = addslashes(file_get_contents($file));
					$image_name = $filenmarray[$curiteration];
					mysqli_query($conn, "UPDATE images SET image_name='$image_name', image_pic='$image' WHERE image_id='$updateloc'");
				}
				$curiteration += 1;
			}
		}
		header("location: home.php");
		exit();
	}
?>