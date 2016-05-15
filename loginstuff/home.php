<?php
	session_start(); //starts the session
	if($_SESSION['user']){ //checks if user is logged in
	}
	else{
		header("location:index.php"); // redirects if user is not logged in
		Print "Please log in";
		exit();
	}
	include 'navbar.php';
?>
<html>
	<head>
		<title>UCR Craigslist</title>
	</head>
	<body>
		<h2>Home Page</h2>
		<h2>Browse By Category</h2>
		<ul>
			<li><a href="category.php?category=books">Books</a></li>
			<li><a href="category.php?category=clothing">Clothing</a></li>
			<li><a href="category.php?category=electronics">Electronics</a></li>
			<li><a href="category.php?category=furniture">Furniture</a></li>
			<li><a href="category.php?category=household">Household</a></li>
			<li><a href="category.php?category=leases">Leases</a></li>
			<li><a href="category.php?category=music">Music</a></li>
			<li><a href="category.php?category=pets">Pets</a></li>
			<li><a href="category.php?category=services">Services</a></li>
			<li><a href="category.php?category=tickets">Tickets</a></li>
			<li><a href="category.php?category=vehicles">Vehicles</a></li>
			<li><a href="category.php?category=other">Other</a></li>
		</ul>

		<h2 align="center">All Posts</h2>
		<table border="1px" width="100%">
			<tr>
				<th>Title</th>
				<th>Seller</th>
				<th>Price</th>
				<th>Category</th>
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
						Print '<td align="center"><a href="specificpost.php?post_id='.$id.'">'. $row['post_title'] . "</a></td>";
						Print '<td align="center"><a href="profile.php?user_profile='. $row['post_username'] .'">'.$row['post_username']."</a></td>";
						Print '<td align="center">$'. $row['post_price'] . "</td>";
						Print '<td align="center">'. $row['post_category'] . "</td>";
						Print '<td align="center">'. $row['post_date']. " - ". $row['post_time']."</td>";
						if($numpics = $row['post_photos']){
							Print '<td align="center">'.$numpics.' available</td>';
						}
						else
							Print '<td align="center"> none </td>';
					Print "</tr>";
				}
			?>
		</table>
	</body>
</html>