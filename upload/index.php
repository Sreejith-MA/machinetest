<?php
if($_SERVER['HTTP_REFERER']=="http://localhost/machinetest/fileupload.html"){
	$filePath = $_SERVER['CONTEXT_DOCUMENT_ROOT'].$_SERVER['REDIRECT_URL'];
	$filePath = str_replace('upload',"uploads",$filePath);
	$fileExtension = pathinfo($_SERVER['REDIRECT_URL'], PATHINFO_EXTENSION);
	$headerarray = ['pdf'=>'application/pdf','jpeg'=>'image/jpeg','png'=>'image/png','docx'=>'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
	header("Content-type:".$headerarray[$fileExtension]);
	print_r(file_get_contents($filePath));
}
else{
	print_r("sorry file doesn't Exist   ");
	echo "<a href='/machinetest/index.html'>Login</a>";
}
?>