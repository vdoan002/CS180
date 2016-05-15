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
  <link rel="stylesheet" type="text/css" media="all" href="css/styles.css">
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
	<?php
		$user = $_SESSION['user'];
		$user_profile = $_GET['user_profile'];
		Print '<h1>'.$user_profile.'</h1>';
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
			Print $user_profile."'s rating: " . $current_rating . '/5<br>
			Total reviews: '.$num_reviews.'<br>';
		}

		Print '<h2> Current Reviews </h2>';
		//find and display any reviews for profile
		if($num_reviews > 0){
			$query = mysqli_query($conn, "SELECT * FROM reviews WHERE user_id='$user_id'");
			while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
				Print'
				Reviewer: '. $row['reviewer'] . ' Rating: '.$row['rating'].'<br/>
				Review: <p> '. $row['review']. '</p><br/><br/>
				';
			}
		}
		else{
			Print '<p> This user has not been rated </p>';
		}
		//review submission code
		if($user != $user_profile){ //user can't review himself
			$query = mysqli_query($conn, "SELECT * FROM reviews WHERE reviewer='$user' AND user_id='$user_id'"); // SQL Query
			$count = mysqli_num_rows($query);
			if($count  == 0){ //if they havent reviewed this user
				Print'
				<section id="user_review">
				  	<div class="leavereview">
				  	<h2>Leave a review</h2>
					<form action="sendreview.php" method="POST" enctype="multipart/form-data">
						<textarea rows="4" cols="50" name="review" required></textarea><br/>
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
					<h2>Edit Review</h2>
					<form action="editreview.php" method="POST" enctype="multipart/form-data">
						<textarea rows="4" cols="50" name="review" required>'.$review.'</textarea><br/>
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
</body>
</html>