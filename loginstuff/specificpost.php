<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] == "GET"){
		$post_id = $_GET['post_id'];
		$user = $_SESSION['user'];
	}
	else{
		header("location: home.php"); //redirects back to home
		exit();
	}
?>
<html>
	<head>
		<title>UCR Craigslist</title>
		<link href="/specificpost.css" rel="stylesheet">
	</head>
	<body>
		
		<?php
			include 'navbar.php';
			include 'serverconnect.php'; //server connection code
			$query = mysqli_query($conn, "SELECT * FROM posts WHERE post_id='$post_id'"); // SQL Query
			$count = mysqli_num_rows($query);
			$counter = 0;
			if($count > 0)
			{
				while($row = mysqli_fetch_array($query,MYSQLI_ASSOC))
				{
					$title = $row['post_title'];
					$price = $row['post_price'];
					$category = $row['post_category'];
					$description = $row['post_description'];
					$numpics = $row['post_photos'];
					$picid = $row['post_photo_id'];
					$seller = $row['post_username'];
					$postdate = $row['post_date'];
					$posttime = $row['post_time'];

					Print '<div class="container">
					<h1>'.$title.' $'.$price.'</h1>
					 Posted on '.$postdate.' at '.$posttime.'
					 <br>
					 Seller: <a href="http://practicemakesperfect.co.nf/profile.php?user_profile='.$seller.'">'.$seller.'</a>';
				
				}
				
				Print '<div class="wrapper">
					<br>
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators hidden" style="list-style: none">';
						
				if($numpics > 0){
					$query = mysqli_query($conn, "SELECT * FROM images WHERE image_post_id='$post_id'");
					
					while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
						if($counter == 0){
							Print '<li data-target="myCarousel" data-slide-to="'.$counter.'" class="active"></li>';
						}
						else{
						Print '<li data-target="myCarousel" data-slide-to="'.$counter.'"></li>';
						}
						$counter++;
				    }
					Print '</ol>';
				}		
					
				$counter = 0;
				Print '<div class="carousel-inner" role="listbox">';
					
				if($numpics > 0){
					$query = mysqli_query($conn, "SELECT * FROM images WHERE image_post_id='$post_id'");
					while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
				        $image_id = $row['image_id'];
						if($counter == 0){
						Print'<div class="item active">
								<img src=getimages.php?post_id='.$image_id.">
							   </div>";
						}
						else{
						Print'<div class="item">
								<img src=getimages.php?post_id='.$image_id.">
							   </div>";
						}
						$counter++;
						}
				    }
					
				Print '<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					  <span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
					  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					  <span class="sr-only">Next</span>
					</a>
					</div>
					</div>
					</div>';
				}
				Print '<h5>Category: '.$category.'</h5>
					<strong>Description:</strong><p>'.$description.'</p>';
				if($seller != $user)
					Print'<a class="btn btn-success" href="http://practicemakesperfect.co.nf/message.php?username='.$seller.'">Contact Seller</a>';
	
		?>
		</div>
	</body>
</html>