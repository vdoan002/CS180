<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	include 'navbar.php';
?>
<html lang="en-US">
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html">
  <title>UCR Craigslist</title>
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="/profile.css" rel="stylesheet">
  <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
  <script>
	  	function toggleHidden(divID){
		var item = document.getElementById(divID);
		if(item && item.className === 'hidden')
			item.className = 'visible';
		else if(item && item.className ==='visible')
			item.className = 'hidden';
		}
  </script>
  
</head>

<body>
	<div class="wrapper">
	<?php
		$user = $_SESSION['user'];
		$user_profile = $_GET['user_profile'];

		include 'serverconnect.php'; //server connection code

		//list current rating and number of reviews
		$query = mysqli_query($conn, "SELECT * FROM users WHERE username='$user_profile'");
		while($row = mysqli_fetch_array($query,MYSQLI_ASSOC))
		{
			$user_id = $row['id'];
			$num_reviews = $row['num_reviews'];
			$total_rating = $row['total_rating'];
			if($num_reviews > 0)
				$current_rating = $total_rating / $num_reviews;
			else
				$current_rating = 0;
			
			if($current_rating <= 2.0)
			{
				Print '<div class="panel panel-danger">';
			}
			else if($current_rating > 2.0 && $current_rating < 4.0)
			{
				Print '<div class="panel panel-warning">';
			}
			else if($current_rating >= 4.0)
			{
				Print '<div class="panel panel-success">';
			}
			Print '<div class="panel-heading"><h3>'.$user_profile.'</h3></div>
					<div class="panel-body">';
			Print $user_profile."'s rating: " . round($current_rating,1) . '/5<br>
			Total reviews: '.$num_reviews.'<br>';
			if($user != $user_profile){
			Print '<a class="btn btn-success" href="http://practicemakesperfect.co.nf/message.php?username='.$user_profile.'">Contact User</a>';
			}
			Print'
			</div>
			</div>
			';
			
		}

		Print '<hr><h3> Current Reviews </h3></div>';

		//find and display any reviews for profile
		if($num_reviews > 0){
			Print '<div class="wrapper2"><div class="panel-group">';
			$query = mysqli_query($conn, "SELECT * FROM reviews WHERE user_id='$user_id'");
			while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
				Print'
				<div class="panel panel-default">
				<div class="panel-heading">
				Reviewer: <a href="profile.php?user_profile='. $row['reviewer'] .'"> '. $row['reviewer'] . ' </a> 
				</div>
				<div class="panel-body">
				<strong>Rating: '.$row['rating'].'</strong><br/>
				Review: <p> '. $row['review']. '</p><br/>
				</div>
				</div>
				';
			}

		}

		else{
			Print '<p align="center"> This user has not been rated </p>';
		}
		
					Print '</div>';
		//review submission code
		if($user != $user_profile){ //user can't review himself
			$query = mysqli_query($conn, "SELECT * FROM reviews WHERE reviewer='$user' AND user_id='$user_id'"); // SQL Query
			$count = mysqli_num_rows($query);
			if($count  == 0){ //if they havent reviewed this user
				Print'

				<section id="user_review">
								<div class="wrapper">
					<form action="sendreview.php" method="POST" enctype="multipart/form-data">
						<label for="review">Leave a review</label>
						<textarea class="form-control" id="review" rows="4" cols="50" name="review" required></textarea><br/>
						Rating:
						<select name="rating">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
						<input type="hidden" name="reviewer" value="'.$user.'"/>
						<input type="hidden" name="user_id" value="'.$user_id.'"/>
						<input type="hidden" name="user_profile" value="'.$user_profile.'"/>
						<input type="submit" value="Submit Review"/>
					</form>
					</div>
				</section>
				';
			}
			else{ //edit existing review
				while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
					$rating = $row['rating'];
					$review = $row['review'];
					$review_id = $row['review_id'];
				}
				Print'
				You\'ve already reviewed this user<br/>
				<button type="button" onclick="toggleHidden(\'editReview\')" class="visible" id="restart">Edit Review</button>
				<div class="hidden" id="editReview">
					<form action="editreview.php" method="POST" enctype="multipart/form-data">
						<label for="edit">Edit review</label>
						<textarea class="form-control" id="edit" rows="4" cols="50" name="review" required>'.$review.'</textarea><br/>
						Rating:
						<select name="rating">
							<option value="'.$rating.'">'.$rating.'</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
						<input type="hidden" name="review_id" value="'.$review_id.'"/>
						<input type="hidden" name="user_id" value="'.$user_id.'"/>
						<input type="hidden" name="old_rating" value="'.$rating.'"/>
						<input type="hidden" name="user_profile" value="'.$user_profile.'"/>
						<input type="submit" value="Update Review"/>
				</form>
				</div>
				';

			}
		}
	?>
	</div>
</body>
</html>