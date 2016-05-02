<?php
	session_start(); //starts the session
?>
<html>
	<head>
		<title>UCR Craigslist</title>
	</head>
	<?php
	if($_SESSION['user']){ //checks if user is logged in
	}
	else{
		header("location:index.php"); // redirects if user is not logged in
	}
	$user = $_SESSION['user']; //assigns user value
	?>
	<body>
		<h2>Home Page</h2>
		<p>Hello <?php Print "$user"?>!</p> <!--Displays user's name-->
		<a href="logout.php">Click here to logout</a><br/>
		<a href="postitem.php">Click here to make/edit a post</a><br/>
		<a href="map.html">Click here for map of meeting location</a><br/><br/>
		<h2 align="center">All Posts</h2>
		<table border="1px" width="100%">
			<tr>
				<th>Id</th>
				<th>Title</th>
				<th>Seller</th>
				<th>Price</th>
				<th>Category</th>
				<th>Description</th>
				<th>Date / Time</th>
				<th>Pictures</th>
			</tr>
			<?php
				include 'serverconnect.php'; //server connection code
			    
				$query = mysqli_query($conn, "SELECT * from posts"); // SQL Query
				while($row = mysqli_fetch_array($query,MYSQLI_ASSOC))
				{
					Print "<tr>";
						$id = $row['post_id'];
						Print '<td align="center">'. $id . "</td>";
						Print '<td align="center">'. $row['post_title'] . "</td>";
						Print '<td align="center">'. $row['post_username'] . "</td>";
						Print '<td align="center">$'. $row['post_price'] . "</td>";
						Print '<td align="center">'. $row['post_category'] . "</td>";
						Print '<td align="center">'. $row['post_description'] . "</td>";
						Print '<td align="center">'. $row['post_date']. " - ". $row['post_time']."</td>";
						if($numpics = $row['post_photos']){
							$picstartloc = $row['post_photo_id'];
							$picloc = $picstartloc - $numpics+1;
							Print '<td align="center">';
							for($x = 0; $x < $numpics; $x++){
								$piclocnew = $picloc + $x;
								Print'<img src=getimages.php?post_id='.$piclocnew."></br>";
							}
							Print '</td>';
						}
						else
							Print '<td align="center"> none </td>';
					Print "</tr>";
				}
			?>
		</table>
	</body>
</html>