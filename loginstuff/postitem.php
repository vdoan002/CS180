<?php
	session_start();
	if($_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
?>
<html>
	<head>
		<title>UCR Craigslist</title>
	<head>
	<body>
		<?php
			include 'navbar.php';
		?>

		<form action="add.php" method="POST" enctype="multipart/form-data">
			Add new item<br/>
			Category:
			<select name="category">
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
			Title: <input type="text" maxlength="100" name="title" required/> 
			Price: $<input type="number" min="0" name="price" required/><br/>
			Description: <br/>
			<input type="text" name="description" required/><br/>
			<div id="moreFiles">
				Image File 1: <input type="file" name="itemimages[]"/><br/>
			</div>
			<input type="button" value="Add Another Image" onclick="addFileUpload('moreFiles')"/><br/>
			<input type="submit" value="Add to posts"/>
		</form>

		<h2 align="center">Your Posts</h2>
		<table border="1px" width="100%">
			<tr>
				<th>Title</th>
				<th>Seller</th>
				<th>Price</th>
				<th>Category</th>
				<th>Description</th>
				<th>Date / Time</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>

			<?php
				include 'serverconnect.php'; //server connection code
			    $user = $_SESSION['user'];

				$query = mysqli_query($conn, "SELECT * from posts WHERE post_username='$user'"); // SQL Query
				while($row = mysqli_fetch_array($query,MYSQLI_ASSOC))
				{
					Print "<tr>";
						Print '<td align="center">'. $row['post_title'] . "</td>";
						Print '<td align="center">'. $row['post_username'] . "</td>";
						Print '<td align="center">$'. $row['post_price'] . "</td>";
						Print '<td align="center">'. $row['post_category'] . "</td>";
						Print '<td align="center">'. $row['post_description'] . "</td>";
						Print '<td align="center">'. $row['post_date'] . " - ". $row['post_time']."</td>";
						Print '<td align="center"><a href="edit.php?post_id='. $row['post_id'] .'">edit</a> </td>';
						Print '<td align="center"><a href="#" onclick="myFunction('.$row['post_id'].')">delete</a> </td>';
					Print "</tr>";
				}
			?>
		</table>
		<script>
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
	</body>
</html>