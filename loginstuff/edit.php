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
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="/home.css" rel="stylesheet">
	</head>
	<?php
		$user = $_SESSION['user']; //assigns user value
		$id_exists = false;
	?>
	<body>
	<div class="wrapperHome">
		<h2 align="center">Edit Post</h2>
		<table class="table" width="100%">
			<tr>
				<th>Title</th>
				<th>Price</th>
				<th>Category</th>
				<th>Date / Time</th>
				<th></th>
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
							Print '<td align="center">$'. $price . "</td>";
							Print '<td align="center">'. $category . "</td>";
							Print '<td align="center">'. $row['post_date']. " - ". $row['post_time']."</td>";
							Print '<td align="center"><a role="button" class="btn btn-danger btn-xs" href="#" onclick="myFunction('.$id.')">Delete &nbsp<span class="glyphicon glyphicon-trash"></span></a> </td>';
							Print "</tr>";
						}
						Print '</table><hr>';
						//photos for post
						Print'<div> <h3>Photos:</h3> <br>';
						$query = mysqli_query($conn, "SELECT * FROM images WHERE image_post_id='$id'");
						while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
							$image_id = $row['image_id'];
							Print'<img src=getimages.php?post_id='.$image_id.">&nbsp";
						}
						Print'</div>
							  </div>';
					}
					else
					{
						$id_exists = false;
					}
				}
			?>
		<br/>
		<?php
		if($id_exists)
		{
			$query = mysqli_query($conn, "SELECT * from images WHERE image_post_id='$id'");
			$tempcategory = ucfirst($category);
			Print '<div class="wrapper">
			<form action="editupdate.php" method="POST" enctype="multipart/form-data">
				<fieldset class="form-group">
				<label for="category">Category</label>
					<select class="form-control" id="category" name="category">
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
					</select>
				</fieldset>
				
				<fieldset class="form-group">
					<label for="title">Title</label>
					<input class="form-control" id="title" type="text" maxlength="100" name="title" value="' . $title . '" required/> 
				</fieldset>
				
				<h5><strong>Price</strong></h5>
				<div class="input-group">
					<span class="input-group-addon">$</span>
					<input class="form-control" type="number" min="0" name="price" value="' . $price . '"/ required>
					<span class="input-group-addon">.00</span>
				</div>
				
				<fieldset class="form-group">
				<label for="description">Description</label>
				<textarea class="form-control" id="description" rows="4" cols="50" name="description" required>' . $description . '</textarea><br/>
				</fieldset>
				';
				if($numpics > 0){
					$ct = 0;
					while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
						$image_id = $row['image_id'];
				        $image_name = $row['image_name'];
						++$ct;
						Print'Image File '. $ct .', Currently "'.$image_name.'"<br/>
						<a href="deletepic.php?image_id='.$image_id.'&post_id='.$_GET['post_id'].'&numpics='.$numpics.'"> Remove Image </a><br/><br/>';
				    }
				}
				Print
				'
				<input type="hidden" name="photoid" value="'.$picid.'"/>
				<input type="hidden" name="numpics" value="'.$numpics.'"/>
				<input type="hidden" name="post_id" value="' . $id . '"/>
				<input class="btn btn-primary" type="submit" value="Update Post"/>
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
		</div>
	</body>
</html>