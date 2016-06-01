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
<html>
	<head>
		<title>UCR Craigslist</title>
		<script>
		  	function toggleHidden(divID){
			var item = document.getElementById(divID);
			if(item && item.className === 'hidden')
				item.className = 'visible';
			else if(item && item.className ==='visible')
				item.className = 'hidden';
			}

			var fileCount = 1;

			var fileLimit = 4;
			function myFunction(id)
			{
			var r=confirm("Are you sure you want to delete this record?");
			if (r==true)
			  {
			  	window.location.assign("delete.php?post_id=" + id);
			  }
			}
			function addFileUpload(divID){
				if(fileCount >= fileLimit)
					alert("Max Image Upload Limit Reached");
				else{
					var newdiv = document.createElement('div');
					newdiv.innerHTML = "Image File " + (fileCount+1) + ": <input type='file' name='itemimages[]'/><br/>";
					document.getElementById(divID).appendChild(newdiv);
					++fileCount;
				}
			}
		</script>
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="/home.css" rel="stylesheet">
	</head>
	<body>
		<!-- Add post modal -->
		<div class="modal fade" id="addPost" role="dialog">
			<div class="modal-dialog">
			
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Add Post</h4>
					</div>
					<div class="modal-body">
						<form action="add.php" method="POST" enctype="multipart/form-data">
							<fieldset class="form-group">
							<label for="category">Category</label>
								<select class="form-control" id="category" name="category">
								  <option value="Books">Books</option>
								  <option value="Clothing">Clothing</option>
								  <option value="Electronics">Electronics</option>
								  <option value="Furniture">Furniture</option>
								  <option value="Household">Household</option>
								  <option value="Leases">Leases</option>
								  <option value="Music">Music</option>
								  <option value="Pets">Pets</option>
								  <option value="Services">Services</option>
								  <option value="Tickets">Tickets</option>
								  <option value="Vehicles">Vehicles</option>

								  <option value="Other">Other</option>
								</select>
							</fieldset>
							
							<fieldset class="form-group">
								<label for="title">Title</label>
								<input class="form-control" id="title" type="text" maxlength="100" name="title" required/> 
							</fieldset>
							
							<h5><strong> Price </strong></h5>
							<div class="input-group">
								
								<!--<label for="price">Price</label>-->
								<span class="input-group-addon">$</span>
								<input class="form-control" type="number" min="0" name="price" required/>
								<span class="input-group-addon">.00</span>
							</div>
							
							<fieldset class="form-group">
							<label for="description">Description</label>
							<textarea class="form-control" rows="4" cols="50" id="description" name="description" required></textarea><br/>
							</fieldset>
							
							
							<div id="moreFiles">
								Image File 1: <input type="file" style="display none;" name="itemimages[]"/><br/>
							</div>
							
							<input type="button" class="btn btn-default btn-xs" value="Add Another Image" onclick="addFileUpload('moreFiles')"/><br/><br/>
							<p align="center"><input type="submit" class="btn btn-primary" value="Add to posts"/></p>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- Body of page -->
		<div class="wrapperHome">
			<h2 align="center">Your Posts</h2>
			<table class ="table table-hover table-sm">
				<thead>
					<tr>
						<th>Title</th>
						<th>Price</th>
						<th>Category</th>
						<th>Date / Time</th>
					</tr>
				</thead>
				<tbody>

				<?php
					include 'serverconnect.php'; //server connection code
					$user = $_SESSION['user'];

					$query = mysqli_query($conn, "SELECT * from posts WHERE post_username='$user'"); // SQL Query
					while($row = mysqli_fetch_array($query,MYSQLI_ASSOC))
					{
						Print "<tr>";
							$id = $row['post_id'];
							Print '<td align="center"><a href="specificpost.php?post_id='.$id.'">'. $row['post_title'] . "</a></td>";
							Print '<td align="center">$'. $row['post_price'] . "</td>";
							Print '<td align="center">'. $row['post_category'] . "</td>";
							Print '<td align="center">'. $row['post_date'] . " - ". $row['post_time']."</td>";
							Print '<td align="center"><a role="button" class="btn btn-warning btn-xs" href="edit.php?post_id='. $row['post_id'] .'">Edit &nbsp<span class="glyphicon glyphicon-pencil"></span></a> </td>';
							Print '<td align="center"><a role="button" class="btn btn-danger btn-xs" href="#" onclick="myFunction('.$row['post_id'].')">Delete &nbsp<span class="glyphicon glyphicon-trash"></span></a> </td>';
						Print "</tr>";
					}
				?>
				</tbody>
			</table>
			<!--
			<button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#addPost" aria-expanded="false" aria-controls="addPost">Add New Post</button> 
			-->
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addPost" aria-expanded="false" aria-controls="addPost">Add New Post</button> 
		</div>
	</body>
</html>