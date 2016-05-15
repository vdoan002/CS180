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
	<nav class="navbar navbar-light style="background-color: #e3f2fd;" navbar-fixed-top">
		<a class="navbar-brand">UCR Craigslist</a>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav pull-left">
					<li><a href="home.php">HOME</a></li>
					<li><a href="postitem.php">MANAGE POSTS</a></li>
					<li><a href="chat.php">MESSAGES</a></li>
					<li><a href="map.php">MAP</a></li>
					<li><a href="profile.php?user_profile='.$user.'">'.strtoupper($user).'</a></li>
					<li><a href="logout.php">LOGOUT</a></li>
				</ul>
		</div>
	</nav>
	'
?>