#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
  exit
fi 
if [[ $1 =~ ^[0-9]+$ ]]
then
  data=$($PSQL "select * from elements join properties using(atomic_number) where atomic_number='$1';")
  echo "executed"
else
  data=$($PSQL "select * from elements join properties using(atomic_number) where symbol='$1' or name='$1';")
  echo "executed"
fi
if [[ -z $data ]]
then
  echo "error de fetching"
else
echo "$data" | while IFS="|" read atomic_number VAR symbol VAR name VAR type VAR atomic_mass VAR melting_point_celsius VAR boiling_point_celsius
do 
  echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
done
fi
