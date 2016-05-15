<?php
		session_start(); //starts the session
		if($_SESSION['user']){ //checks if user is logged in
		}
		else{
			header("location:index.php"); // redirects if user is not logged in
			Print "Please log in";
			exit();
		}
		if(!empty($_GET['post_id'])){
			$post_id = $_GET['post_id'];
			$image_id = $_GET['image_id'];

			Print $post_id;
			Print $image_id;
		}
		/*
		//check for photo delete
		$deletenums = array(0,0,0,0);
		$picsdeleted = 0;
		for($x = 0; $x < $numpics;++$x){
			if(isset($_POST['deletepic'.$x])){
				$deletenums[$x]++;
				$picsdeleted++;
			}
		}
		if($picsdeleted > 0){
			$indexshift = array(0,0,0,0);
			//find how many places to shift pics in database
			for($x = 0; $x < 4; ++$x){
				if($deletenums[$x] > 0){
					$temp = $x+1;
					while($temp < 4){
						if($deletenums[$temp] == 0)
							++$indexshift[$temp];
						++$temp;
					}
				}
			}
			//remove pics to be deleted
			for($x = 0; $x < 4; ++$x){
				if($deletenums[$x]>0){
					$delLoc = $photoid - $x;
					mysqli_query($conn,"DELETE FROM images WHERE image_id='$delLoc'");
				}
			}
			//edit image id's
			for($x = 0; $x < 4; ++$x){
				if($indexshift[$x] > 0){
					$oldid = $updatebase + $x;
					$newid = $updatebase - $indexshift[$x];
					mysqli_query($conn, "UPDATE images SET image_id='$newid' WHERE image_id='$oldid'");
				}
			}
		}
		*/
?>