<?php

// dd function to format output
function dd($data)
{
    echo '<pre>';
    var_dump($data);
    echo '</pre>';
}

$db = 'mariadocker';
$host = 'mariadb';
$port = '3306';
$user = 'root';
$password = 'root';
$dsn = "mysql:host=$host;dbname=$db;port=$port";

try {
    // Connection to database with PDO
    $pdo = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    // We throw an error if something wrong happen
    echo 'An error occured: ' . $e->getMessage();
}

$stmt = $pdo->prepare('SELECT * FROM counters WHERE id = :id;');
$stmt->execute([
    ':id' => 1
]);
$my_value = $stmt->fetch();

$value = $my_value["value"] + 1;

$stmt = $pdo->prepare('UPDATE counters SET value = :value WHERE id = :id;');
$stmt->execute([
    ':value' => $value,
    ':id' => 1
]);
?>

Value <?= $value; ?>
