<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] = "POST"){
		include 'serverconnect.php';
		$review = mysqli_real_escape_string($conn,$_POST['review']);
		$rating = $_POST['rating'];
		$reviewer = $_POST['reviewer'];
		$user_id = $_POST['user_id'];
		$user_profile = $_POST['user_profile'];
		
		$query = mysqli_query($conn, "SELECT * from users WHERE id='$user_id'");
		//get rating review to update it
		while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
			$num_reviews = $row['num_reviews'];
			$total_rating = $row['total_rating'];
		}
		$total_rating += $rating;
		$num_reviews++;
		//update rating value
		mysqli_query($conn, "UPDATE users SET num_reviews='$num_reviews', total_rating='$total_rating' WHERE id='$user_id'");
		//add review
		mysqli_query($conn,"INSERT INTO reviews (user_id, review, reviewer,rating) VALUES ('$user_id','$review','$reviewer','$rating')");
		//go back to review page
		$redirect = "location: profile.php?user_profile=".$user_profile;
		header($redirect);
		exit();
	}
?>