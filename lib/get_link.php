<?php
    $servername = 'localhost';
    $username = 'root';
    $password = '';
    $db_name = 'ok_app';

    $conn = new mysqli($servername,$username,$password,$db_name);

    if($conn->connect_error){
        die("connection failed: ". $conn->connect_error);
    };

    $sql = 'SELECT * from share_link';
    $result = $conn->query($sql);
    $response = array();
    if($result -> num_rows > 0 ){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }

    $conn -> close();
    header('Content-Type: application/json');
    echo json_encode($response);
?>