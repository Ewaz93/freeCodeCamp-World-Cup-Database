#! /bin/bash

# This script was written by me Ewaz93 with debugging assistance from AI, I did my best possible.

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo "$($PSQL "TRUNCATE games, teams")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_G OPPONENT_G

do

  if [[ $YEAR != "year" ]]
  
  then 
  
  W_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

  if [[ -z $W_TEAM_ID ]]

  then 

  $PSQL "INSERT INTO teams(name) VALUES('$WINNER')"

  W_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

  fi

  O_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  if [[ -z $O_TEAM_ID ]]

  then

  $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"

  O_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  fi

  INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $W_TEAM_ID, $O_TEAM_ID, $WINNER_G, $OPPONENT_G)")

  if [[ $INSERT_GAME == "INSERT 0 1" ]]

  then

  echo "Logged: $YEAR $ROUND | $WINNER vs $OPPONENT"

  fi 

  fi

  done
  





























