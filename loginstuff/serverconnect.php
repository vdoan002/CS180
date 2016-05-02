<?php
	$servername = "fdb14.biz.nf";
	$serverusername = "2104912_db1";
    $serverpassword = "data5base";
	$conn = mysqli_connect($servername, $serverusername, $serverpassword) or die(mysqli_connect_error());
    mysqli_select_db($conn,"2104912_db1") or die("Cannot connect to database");
?>