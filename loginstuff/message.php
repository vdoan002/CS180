<?php
	session_start();
	if($user = $_SESSION['user']){
	}
	else{
		header("location:index.php");
		Print "Please log in";
		exit();
	}
	if($_SERVER['REQUEST_METHOD'] == "GET"){
		include 'navbar.php';
		class Message{
			public $id;
			public $sender;
			public $receiver;
			public $content;
			public $timesent;
			public $date;
			public $seen;
		}
		$username = $_GET['username'];
		include 'serverconnect.php'; //server connection code
		$msgs = array();
		$user = $_SESSION['user'];
		$query = mysqli_query($conn, "SELECT * FROM messages WHERE (message_sender='$username' AND message_receiver='$user') OR (message_sender='$user' AND message_receiver='$username') "); // SQL Query
		$rowcount = mysqli_num_rows($query);
		while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
			$msg = new Message();
			$msg->id = $row['message_id'];
			$msg->sender = $row['message_sender'];
			$msg->receiver = $row['message_receiver'];
			$msg->content = $row['message_content'];
			$msg->timesent = $row['message_timesent'];
			$msg->date = $row['message_date'];
			$msg->seen = $row['message_seen'];

			array_push($msgs, $msg);
		}
	}
	else{
		header("location: home.php"); //redirects back to home
		exit();
	}

?>
<html>
	<head>
		<title>UCR Craigslist</title>
		<link href="/message.css" rel="stylesheet">
	</head>
	<body>

		<?php
			Print'<div class="wrapperHome">';
			Print'<h1> Messages with <a href="http://practicemakesperfect.co.nf/profile.php?user_profile='.$username.'">'.$username.'</a></h1>';
			
			Print'</div>
					<div class="wrapperMessage">';
			
			Print'<div class="panel panel-default">';
			Print'<div class="panel-body">';
			if($rowcount == 0){//no messages
				Print'
				No existing messages.<br/>
				';
			}
			else{//messages exist

				foreach($msgs as $msg){
					if($username == $msg->sender){
					Print'<span style="color:red">
					'.$msg->sender.'</span> at ' . $msg->timesent . ' on '.$msg->date.'</br>
						' . $msg->content . '<br/><br/>
					';
					}
					else{
					Print'<span style="color:blue">
					'.$msg->sender.'</span> at ' . $msg->timesent . ' on '.$msg->date.'</br>
						' . $msg->content . '<br/><br/>
					';
					}
					if($user == $msg->receiver){
						$nowseen = 1;
						$msgid = $msg->id;
						mysqli_query($conn, "UPDATE messages SET message_seen='$nowseen' WHERE message_id='$msgid'");
					}
				}
			}
			Print'<hr>
			Send Message:<br/>
			<form action="sendmessage.php" method="POST" enctype="multipart/form-data">
				<textarea class="form-control" rows="4" cols="50" name="content" required></textarea><br/>
				<input type="hidden" name="sender" value="'.$user.'"/>
				<input type="hidden" name="receiver" value="'.$username.'"/>
				<input style="float: right" type="submit" class="btn btn-primary" value="Send"/>
			</form>
			</div>
			</div>
			</div>
			';
		?>
	</body>

</html>