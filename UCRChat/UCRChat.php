<?php
/**
*Original Author: Tamil
 * Code used as a template for CS180, modifications by Chuanping Fan
 */
class FbChatMock {

  // Holds the database connection
  private $dbConnection;

  private $_dbHost = '';
  private $_dbUsername = '';
  private $_dbPassword = '';
  public $_databaseName = '';
  
  /**
   * Create's the connection to the database and stores it in the dbConnection
   */
  public function __construct() {
    $this->dbConnection = new mysqli($this->_dbHost, $this->_dbUsername, 
        $this->_dbPassword, $this->_databaseName);

    if ($this->dbConnection->connect_error) {
      die('Connection error.');
    }
  }

  public function getMessages() {
    $messages = array();
    $query = <<<QUERY
        SELECT 
          `chat`.`message`, 
          `chat`.`sent_on`,
          `users`.`id`, 
          `users`.`username`
        FROM `users`
        JOIN `chat`
          ON `chat`.`user_id` = `users`.`id`
        ORDER BY `sent_on`
QUERY;
    
    // Execute the query
    $resultObj = $this->dbConnection->query($query);
    // Fetch all the rows at once.
    while ($row = $resultObj->fetch_assoc()) {
      $messages[] = $row;
    }
    
    return $messages;
  }

  /*
   * @param Integer $userId The user who sent the message
   * @param String $message The Actual message
   * @return bool|Integer The last inserted id of success and false on faileur
   */
  public function addMessage($userId, $message) {
    $addResult = false;
    
    $cUserId = (int) $userId;
    // Escape the message with mysqli real escape
    $cMessage = $this->dbConnection->real_escape_string($message);
    
    $query = <<<QUERY
      INSERT INTO `chat`(`user_id`, `message`, `sent_on`)
      VALUES ({$cUserId}, '{$cMessage}', UNIX_TIMESTAMP())
QUERY;

    $result = $this->dbConnection->query($query);
    
    if ($result !== false) {
      // Get the last inserted row id.
      $addResult = $this->dbConnection->insert_id;
    } else {
      echo $this->dbConnection->error;
    }
    
    return $addResult;
  }

}