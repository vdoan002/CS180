<?php
	session_start();
	if($user = $_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}

	Print'
	    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="/navbar.css" rel="stylesheet">
		<script type="text/javascript" src="bootstrap/js/jquery-2.2.3.min.js"></script>
		<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<nav class="navbar navbar-light" style="background-color: #e3f2fd;" navbar-fixed-top">
		<a class="navbar-brand">UCR Craigslist</a>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav pull-left">
				<li><a href="home.php">Home</a></li>
				<li>
				
					<a class="dropdown-toggle" data-toggle="dropdown">Browse by Category<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
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
				
				</li>
				<li><a href="postitem.php">Manage Posts</a></li>
				<li><a href="chat.php">Messages</a></li>
				<li><a href="map.php">Map</a></li>
				<li><a href="profile.php?user_profile='.$user.'">'.strtoupper($user).'</a></li>
				<li><a href="logout.php">Logout</a></li>
			</ul>
			<form class="form-inline pull-xs-right" action="search.php" method="GET" enctype="multipart/form-data">
				<input class="form-control" placeholder="Search" type="text" name="search" maxlength="50" required/>
				<button class="btn btn-success-outline" type="submit">Search</button>
			</form>
		</div>
	</nav>
	'
?>