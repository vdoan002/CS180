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
	class Message{
		public $msguser;
		public $seen;
	}
	//fix this function
	$msgs = array();
	$seenarr = array();
	function filterMessages(&$msgarr, $newmsg){
		$inserted = 0;
		foreach($msgarr as $cur){
			if($cur->msguser == $newmsg->msguser){
				if($newmsg->seen == 0){
					$cur->seen = 0;
				}
				$inserted = 1;
				break;
			}
		}
		if(!$inserted){
			array_push($msgarr, $newmsg);
		}
	}

	include 'serverconnect.php'; //server connection code
	$user = $_SESSION['user'];
	$query = mysqli_query($conn, "SELECT * FROM messages WHERE message_sender='$user' OR message_receiver='$user'"); // SQL Query
	$rowcount = mysqli_num_rows($query);
	while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
		$msg = new Message();
		$sender = $row['message_sender'];
		$receiver = $row['message_receiver'];
		if($user == $receiver)
			$msg->seen = $row['message_seen'];
		else
			$msg->seen = 1;
		
		if($user == $sender)
			$msguser = $receiver;
		else
			$msguser = $sender;
		$msg->msguser = $msguser;
		filterMessages($msgs,$msg);
	}

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
			}
		</script>
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="/home.css" rel="stylesheet">
	</head>
	<body>
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						
							<h4 class="modal-title">New Message</h4>
					</div>
					<div class="modal-body">
					
						<form action="userexists.php" method="POST" enctype="multipart/form-data">
							Enter username of user you wish to message:<br/>
							<input type="text" name="receiver" maxlength="50" required/>
							<input type="submit" value="Message User"/>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="wrapperHome">
		<div>
		<h2> Messages </h2>
			<button class="btn btn-default pull-right" data-toggle="modal" data-target="#myModal">+</button>
		</div>
			<?php
				if($rowcount == 0){//no messages
					Print'
					No existing messages.<br/>
					';
				}
				else{//messages exist
					Print '
					<table class ="table table-hover table-sm">
						<thead>
							<tr>
								<th>User</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
					';
					foreach($msgs as $msg){
						$newmsg = "yes";
						if($msg->seen)
							$newmsg = "no";
						Print'
						<tr>
						<td>'.$msg->msguser.'</td>';
						if($newmsg == "yes"){
						Print'
						<td><span class="label label-pill label-success">New Message Available</span></td>'
						;
						}
						else{
						Print'
						<td>&nbsp</td>';
						}
						Print'
						<td align="right"> <a class="btn btn-primary btn-xs" href="message.php?username='.$msg->msguser.'">Go to thread</a> &nbsp <a class="btn btn-default btn-xs" href="profile.php?user_profile='.$msg->msguser.'">User Profile</a></td>
						</tr>
						';
					}
					Print'
						</tbody>
					</table>
					</div>
					';
				}
			?>
	</body>
</html>