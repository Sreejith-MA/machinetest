<?php

class WebApp {
    public $db; 
    public function __construct() {

        // Start a session
        session_start();
        // Initialize the database connection
        $this->connectToDatabase();
        date_default_timezone_set("Asia/Calcutta");
        $this->date = date('Y-m-d H:i:s');

    }
    public function connectToDatabase() {
        // Database configuration
        $dbHost = "localhost";
        $dbUsername = "root";
        $dbPassword = "password";
        $dbName = "yes";

        // Create a new database connection
        $this->db = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);
        if ($this->db->connect_error) {
            die("Connection failed: " . $this->db->connect_error);
        }
    }

    public function handleRequest() {
      if ($_SERVER["REQUEST_METHOD"] === "POST") {
        if(isset($_FILES["fileInput"])){
            if(empty($_SESSION['user_id'])){
                $result['status']=205;
                $result['message']="User Logged Out";
                $this->sendResponse($result);
            }
            $requestData['method']='handleFileUpload';}
        else{
            $requestData = json_decode(file_get_contents("php://input"), true);
        }
        if(!empty($requestData['method'])){
            $this->{$requestData['method']}($requestData);
        }
        else{
                $result['status']=205;
                $result['message']="Invalid Method";
                $this->sendResponse($result);
            }
        }
    }

    public function signUp($data){
        $password = $data['password'];
        $data['password']=password_hash($data['password'], PASSWORD_DEFAULT);
        $sql = "INSERT INTO users (`username`, `password`,`created_at`) VALUES ('{$data['username']}','{$data['password']}','{$this->date}')";
        $results = $this->db->query($sql);
        if($results){
            $result['status']=200;
            $result['message']="SignUp successful!";
            $this->sendResponse($result);
        }else{
            $result['status']=204;
            $result['message']="SignUp Error";
            $this->sendResponse($result);
        }
    }

    public function login($data){
        $sql = "SELECT id,password FROM users WHERE username = '".$data['username']."'";
        $results = $this->db->query($sql);
        if ($results->num_rows === 1) {
            $row = $results->fetch_assoc();
            $hashedPassword = $row["password"];
            if(password_verify($data['password'], $hashedPassword)) {
                $_SESSION['user_id']=$row['id'];
                $result['status']=200;
                $result['message']="Login successful!";
                $this->sendResponse($result);
            } 
            else{
                $result['status']=204;
                $result['message']="Incorrect password.";
                $this->sendResponse($result);
            }
        } 
    else {
        $result['status']=205;
        $result['message']="User not found.";
        $this->sendResponse($result);
    }
    }

    public function handleFileUpload($data) {
        // Define allowed file extensions
        $allowedExtensions = array("jpg", "png", "pdf", "docx");
    
        // Define maximum file size (in bytes)
        $maxFileSize = 5 * 1024 * 1024; // 5MB
    
        // Define the upload directory (outside the web server's root)
        $uploadDirectory = __DIR__.'/uploads/';
    
        // Get the uploaded file details
        $file = $_FILES['fileInput'];
        // Get the file extension
        $fileExtension = pathinfo($file["name"], PATHINFO_EXTENSION);
        // Check if the file extension is allowed
        if (!in_array($fileExtension, $allowedExtensions)) {
            $this->logUpload("Rejected","Invalid Extension", $file["name"]);
            $result['status']=204;
            $result['message']="Invalid file extension.";
            $this->sendResponse($result);
        }
        // Check if the file size exceeds the limit
        if ($file["size"] > $maxFileSize) {
            $this->logUpload("Rejected","File Too Large",$file["name"]);
            $result['status']=204;
            $result['message']="File size exceeds the limit.";
            $this->sendResponse($result);
        }
        // Sanitize the file name and ensure it's unique
        $fileName = $this->sanitizeFileName($file["name"],$uploadDirectory);
        $filePath = $uploadDirectory . $fileName;

        // Move the uploaded file to the secure directory
        if (move_uploaded_file($file["tmp_name"], $filePath)) {
            $this->logUpload("Accepted","uploaded successfully",$fileName);
            $result['status']=200;
            $result['message']="File uploaded successfully.";
            $this->sendResponse($result);
        } else {
            $this->logUpload("Rejected" ,"Upload Failed",$file["name"]);
            $result['status']=204;
            $result['message']="File upload failed.";
            $this->sendResponse($result);
        }
    }



    public function getUserFileUploadList() {
        // Query the database to retrieve data (you should use prepared statements)
        $query = "SELECT * FROM uploads where user_id=".$_SESSION['user_id']." ORDER BY `id` DESC";
        $result = $this->db->query($query);
        $data = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        $this->sendResponse($data);
    }
    public function verifyUserLogin(){
        if(!empty($_SESSION['user_id'])){
            $result['status']=200;
            $this->sendResponse($result);
        }
        else{
            $result['status']=201;
            $this->sendResponse($result);
        }
    }
    public function saveUploadedData($filename) {
        $query = "INSERT INTO `uploads` (`user_id`, `file_name`, `ip_address`, `created_at`)
                    VALUES ({$_SESSION['user_id']},'{$filename}','{$_SERVER['REMOTE_ADDR']}','{$this->date}');";
        $this->db->query($query);
    }

    // Function to log file uploads
    public function logUpload($status,$message,$filename) {
        $sql = "INSERT INTO `log_details` (`user_id`, `ip_address`, `status`,`message`, `file_name`, `create_at`)
                VALUES ({$_SESSION['user_id']}, '{$_SERVER['REMOTE_ADDR']}', '{$status}','{$message}', '{$filename}', '{$this->date}');";
        $result = $this->db->query($sql);    
        if($status=="Accepted"){
            $this->saveUploadedData($filename);
        }
    }

    public function sanitizeFileName($fileName,$uploadDirectory) {
        // Remove potentially harmful characters and symbols
        $sanitizedFileName = preg_replace("/[^a-zA-Z0-9_.-]/", "_", $fileName);
        $i = 1;
        while (file_exists($uploadDirectory . $sanitizedFileName)) {
            $sanitizedFileName = pathinfo($fileName, PATHINFO_FILENAME) . "_" . $i . "." . pathinfo($fileName, PATHINFO_EXTENSION);
            $i++;
        }
        return $sanitizedFileName;
    }

    public function sendResponse($data) {
        // Send an HTTP response
        header("Content-Type: application/json");
        echo json_encode($data);
        die();
    }
    
}

$app = new WebApp();
$app->handleRequest();
