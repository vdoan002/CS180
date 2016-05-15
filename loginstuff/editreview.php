<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] == "POST"){
		include 'serverconnect.php';
		$review = mysqli_real_escape_string($conn,$_POST['review']);
		$rating = $_POST['rating'];
		$review_id = $_POST['review_id'];
		$user_id = $_POST['user_id'];
		$old_rating = $_POST['old_rating'];
		$user_profile = $_POST['user_profile'];
		if($old_rating != $rating){ //if they changed rating, you must update users total rating
			$query = mysqli_query($conn, "SELECT * FROM users WHERE id='$user_id'");
			//get rating review to update it
			while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
				$total_rating = $row['total_rating'];
			}
			$rating_difference = $old_rating - $rating;
			$total_rating -= $rating_difference;
			mysqli_query($conn, "UPDATE users SET total_rating='$total_rating' WHERE id='$user_id'");
		}
		//update all other info
		mysqli_query($conn, "UPDATE reviews SET review='$review', rating='$rating' WHERE review_id='$review_id'");
		//redirect back to page
		$redirect = "location: profile.php?user_profile=".$user_profile;
		header($redirect);
	}
?>