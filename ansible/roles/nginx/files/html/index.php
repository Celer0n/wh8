<?php
        $servername = "localhost";
        $username = "app_user";
        $password = "app_password";  // Переменная для пароля
        $dbname = "app_db";

        // Создание соединения
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Проверка соединения
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        
        echo "<p>Connected successfully to the database!</p>";
?>