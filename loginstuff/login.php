<html>
	<head>
		<title>Log In</title>
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="/signin.css" rel="stylesheet">
	</head>
	<body>
		<!--
		<a href="index.php">Click here to go back</a><br/><br/>
		-->
		<form class="form-signin" action="checklogin.php" method="POST">
			<h2 class="form-signin-heading">Please sign in</h2>
				<label for="Username" class="sr-only">Username</label>
				<input type="text" id="Username" class="form-control" placeholder="Username" required  name="username" required="required"/>
				<label for="Password" class="sr-only">Password</label>
				<input type="password" id="Password" class="form-control" placeholder="Password" name="password" required="required"/><br/>	
			<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
		</form>
	</body>
</html>