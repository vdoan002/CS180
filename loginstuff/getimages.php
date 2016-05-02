<?php
	include 'serverconnect.php'; //server connection code
    $id = $_GET['post_id'];
    $query = mysqli_query($conn, "SELECT * FROM images WHERE image_id=$id");
    header("Content-type: image/jpeg");
    while($row = mysqli_fetch_array($query,MYSQLI_ASSOC)){
        $image_pic = $row['image_pic'];
        Print $image_pic;
    }
?>
