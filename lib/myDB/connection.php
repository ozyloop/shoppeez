

<?php
try{
$connection = new PDO('mysql:host=localhost;dbname=id18695514_flutter', 'id18695514_ozylo', 'KKbe6=vwlKS7gQ0)');
$connection ->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
echo "yes connected";


}catch(PDOException $exc){
echo $exc -> getMessage();
die("could not connect");


}






?>