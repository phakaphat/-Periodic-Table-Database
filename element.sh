#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ ! $1 ]]
then 
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_INFO_AN=$($PSQL "SELECT melting_point_celsius, boiling_point_celsius, name, symbol, atomic_mass, atomic_number, type
      FROM elements
      INNER join properties 
      USING(atomic_number)
      INNER join types 
      USING(type_id)
      WHERE atomic_number=$1;")
  else
    ATOMIC_INFO_S=$($PSQL "SELECT melting_point_celsius, boiling_point_celsius, name, symbol, atomic_mass, atomic_number, type
      FROM elements
      INNER join properties 
      USING(atomic_number)
      INNER join types 
      USING(type_id)
      WHERE symbol='$1';")
    ATOMIC_INFO_N=$($PSQL "SELECT melting_point_celsius, boiling_point_celsius, name, symbol, atomic_mass, atomic_number, type
      FROM elements
      INNER join properties 
      USING(atomic_number)
      INNER join types 
      USING(type_id)
      WHERE name='$1';")
  fi
  if [[ ! -z $ATOMIC_INFO_AN ]] 
  then
    echo "$ATOMIC_INFO_AN" | while read melting_point_celsius BAR boiling_point_celsius BAR name BAR symbol BAR atomic_mass BAR atomic_number BAR TYPE
  do
    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $TYPE, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
  done
  elif [[ ! -z $ATOMIC_INFO_S ]]
  then
    echo "$ATOMIC_INFO_S" | while read melting_point_celsius BAR boiling_point_celsius BAR name BAR symbol BAR atomic_mass BAR atomic_number BAR TYPE
  do
    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $TYPE, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
  done
  elif [[ ! -z $ATOMIC_INFO_N ]]
  then
    echo "$ATOMIC_INFO_N" | while read melting_point_celsius BAR boiling_point_celsius BAR name BAR symbol BAR atomic_mass BAR atomic_number BAR TYPE
  do
    echo "The element with atomic number $atomic_number is $name ($symbol). It's a $TYPE, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
  done
  else
    echo "I could not find that element in the database."
  fi
fi

