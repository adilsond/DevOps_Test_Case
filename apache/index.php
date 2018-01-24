<?php
header("Content-Type: application/json; charset=UTF-8");
header('Cache-Control: private, no-cache, no-store, must-revalidate');
header('Pragma: no-cache');


//Only start session if HTTP_X_FORWARDED_FOR is not null
if ($_SERVER["HTTP_X_FORWARDED_FOR"] != NULL)
{
  ini_set('session.gc_maxlifetime', 60 * 60 * 2);  //2 hour session lifetime
  ini_set('session.cookie_lifetime', 60 * 60 * 2); //2 hour cookie lifetime
  session_start();
  // Set sessions variables
  if ($_SESSION["count"] == NULL)
  {
    $_SESSION["count"] = 1;
  }
  else
  {
    $_SESSION["count"]++;
  }
  $count = $_SESSION["count"];
}

//Generate json data based on IP address and current date and time.
$date = date("Y-m-d H:i:s O");
$ip_address = $_SERVER['HTTP_X_FORWARDED_FOR']; //real client ip got from haproxy
$array = array('date' => $date, 'ip_address' => $ip_address);
echo json_encode($array);

?>
