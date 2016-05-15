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
	</head>
	<body>
		<?php
			include 'navbar.php';
			include 'serverconnect.php'; //server connection code
			$query = mysqli_query($conn, "SELECT * FROM posts WHERE post_id='$post_id'"); // SQL Query
			$count = mysqli_num_rows($query);
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

					Print 'Seller: '.$seller.'<br/>
					<h1>'.$title.' $'.$price.'</h1><br/>
					Category: '.$category.' Posted on '.$postdate.' at '.$posttime.'<br/>
					Description:<br/>'.$description.'<br/>';

					if($numpics = $row['post_photos']){
						$picstartloc = $row['post_photo_id'];
						$picloc = $picstartloc - $numpics+1;
						Print '<table width="70%">';
						for($x = 0; $x < $numpics; $x++){
							if(!($x%2)){ //create new row every 2 pics
								Print '<tr>';
							}
							$piclocnew = $picloc + $x;
							Print'<td align="center"><img src=getimages.php?post_id='.$piclocnew."></td></br>";
							if(!($x%2)){
								Print '</tr>';
							}
						}
						Print '</table>';
					}
					
				}
			}
		?>
	</body>
</html>