
<?php

require('connection.php');

$makeQuery = "SELECT * FROM customer";

$stamement = $connection->prepare($makeQuery);

$stamement->execute();

$myarray = array();



while ($resultsFrom = $stamement -> fetch()){
    array_push(
        $myarray,array(
            "ingredient_ID"=>$resultsFrom['customer_ID'],
            "first_name"=>$resultsFrom['first_name'],
            "last_name"=>$resultsFrom['last_name'],
            "email"=>$resultsFrom['email']
        )
    );

}

echo json_encode($myarray);



?>