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
	<?php
		$user = $_SESSION['user']; //assigns user value
		$id_exists = false;
	?>
	<body>
		<h2 align="center">Currently Selected</h2>
		<table border="1px" width="100%">
			<tr>
				<th>Title</th>
				<th>Seller</th>
				<th>Price</th>
				<th>Category</th>
				<th>Date / Time</th>
				<th>Delete</th>
			</tr>
			<?php
				if(!empty($_GET['post_id']))
				{
					$id = $_GET['post_id'];
					$_SESSION['post_id'] = $id;
					$id_exists = true;
					
					include 'serverconnect.php'; //server connection code
					$query = mysqli_query($conn, "SELECT * FROM posts WHERE post_id='$id'"); // SQL Query
					$count = mysqli_num_rows($query);
					if($count > 0)
					{
						//print current post details
						while($row = mysqli_fetch_array($query,MYSQLI_ASSOC))
						{
							$title = $row['post_title'];
							$price = $row['post_price'];
							$category = $row['post_category'];
							$description = $row['post_description'];
							$id = $row['post_id'];
							$numpics = $row['post_photos'];
							$picid = $row['post_photo_id'];
							Print "<tr>";
							Print '<td align="center"><a href="specificpost.php?post_id='.$id.'">'. $row['post_title'] . "</a></td>";
							Print '<td align="center"><a href="profile.php?user_profile='. $row['post_username'] .'">'.$row['post_username']."</a></td>";
							Print '<td align="center">$'. $price . "</td>";
							Print '<td align="center">'. $category . "</td>";
							Print '<td align="center">'. $row['post_date']. " - ". $row['post_time']."</td>";
							Print '<td align="center"><a href="#" onclick="myFunction('.$id.')">delete</a> </td>';
							Print "</tr>";
						}
						//photos for post
						Print'<div> Photos: <br>';
						$query = mysqli_query($conn, "SELECT * FROM images WHERE image_post_id='$id'");
						while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
							$image_id = $row['image_id'];
							Print'<img src=getimages.php?post_id='.$image_id."></br>";
						}
						Print'</div>';
					}
					else
					{
						$id_exists = false;
					}
				}
			?>
		</table>
		<br/>
		<?php
		if($id_exists)
		{
			$query = mysqli_query($conn, "SELECT * from images WHERE image_post_id='$id'");
			$tempcategory = ucfirst($category);
			Print '
			<form action="editupdate.php" method="POST" enctype="multipart/form-data">
				Category:
				<select name="category">
				  <option value="' . $category . '">' . $tempcategory . '</option>
				  <option value="books">Books</option>
				  <option value="clothing">Clothing</option>
				  <option value="electronics">Electronics</option>
				  <option value="furniture">Furniture</option>
				  <option value="household">Household</option>
				  <option value="leases">Leases</option>
				  <option value="music">Music</option>
				  <option value="pets">Pets</option>
				  <option value="services">Services</option>
				  <option value="tickets">Tickets</option>
				  <option value="vehicles">Vehicles</option>

			  	  <option value="other">Other</option>
				</select> <br/>
				Title: <input type="text" maxlength="100" name="title" value="' . $title . '" required/> 
				Price: $<input type="number" min="1" name="price" value="' . $price . '"/ required><br/>
				Description: <br/>
				<textarea rows="4" cols="50" name="description" required>' . $description . '</textarea><br/>
				';
				if($numpics > 0){
					$ct = 0;
					while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
						$image_id = $row['image_id'];
				        $image_name = $row['image_name'];
						++$ct;
						Print'Image File '. $ct .', Currently "'.$image_name.'"<br/>
						<a href="deletepic.php?image_id='.$image_id.'&post_id='.$_GET['post_id'].'&numpics='.$numpics.'"> click to delete '.$image_name.' </a><br/><br/>';
				    }
				}
				Print
				'
				<input type="hidden" name="photoid" value="'.$picid.'"/>
				<input type="hidden" name="numpics" value="'.$numpics.'"/>
				<input type="hidden" name="post_id" value="' . $id . '"/>
				<input type="submit" value="Update Post"/>
			</form>
			';
			if($numpics < 4){
				Print '
				<form action="addnewpic.php" method="POST" enctype="multipart/form-data">
				Add another image: <br/>
				<input type="file" name="newimage" required/><br/>
				<input type="hidden" name="post_id" value="' . $id . '"/>
				<input type="hidden" name="numpics" value="'.$numpics.'"/>
				<input type="submit" value="Add Image"/>
				</form>
				';

			}
		}
		else
		{
			Print '<h2 align="center">There is no data to be edited.</h2>';
		}
		?>
			<script>
			function myFunction(id)
			{
			var r=confirm("Are you sure you want to delete this record?");
			if (r==true)
			  {
			  	window.location.assign("delete.php?post_id=" + id);
			  }
			}
		</script>
	</body>
</html>