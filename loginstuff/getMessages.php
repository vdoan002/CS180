<?php
 
// Create connection
$con=mysqli_connect("fdb14.biz.nf","2104912_db1","silentshrub913","2104912_db1", "3306");
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM messages";
 
// Check if there are results
if ($result = mysqli_query($con, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray=array(); 
	// Loop through each row in the result set
	//while($row = mysqli_fetch_array($result)){
	while($row = $result->fetch_object()){
		// Add each row into our results array
		//echo '<img src="data:image/jpeg;base64,'.base64_encode( $row['image_pic'] ).'"/>';
		//echo $row['image_id'];
		//echo $row['image_post_id'];
		//echo $row['image_name'];
		//echo $row['image_pic'];

		//$tempArray = array();
		//array_push($tempArray, "image_id".":".$row['image_id']);
		//array_push($tempArray, "image_post_id".":".$row['image_post_id']);
		//array_push($tempArray, "image_name".":".$row['image_name']);
		//array_push($tempArray, "image_pic"."\":\"".base64_encode($row['image_pic']));
		//$row['image_pic'] = base64_encode($row['image_pic']);
		$row->image_pic = base64_encode($row->image_pic);
	    array_push($resultArray, $row);

	}
	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
}
 
// Close connections
mysqli_close($con);
?>